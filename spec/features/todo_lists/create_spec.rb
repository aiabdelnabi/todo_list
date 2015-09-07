require 'spec_helper'

describe "Create a todo list" do

	def create_todo_list(options={})

		options[:title] ||= "my todo list"
		options[:description] ||= "my todolist describe"

		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content "New Todo List"

		fill_in "Title", with: options[:title]
		fill_in "Description", with: options[:description]

		click_button "Create Todo list"
	end

	it "Redirect to todolist index page on success" do
		create_todo_list

		expect(page).to have_content "my todo list"
	end

	it "Show Error when no title" do
		expect(TodoList.count).to eq(0)

		create_todo_list title: ""

		expect(page).to have_content "error"
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"

		expect(page).to_not have_content "my todolist describe"
	end

	it "Show Error when title lenght is less than 3" do
		expect(TodoList.count).to eq(0)

		create_todo_list title: "hi"

		expect(page).to have_content "error"
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"

		expect(page).to_not have_content "my todolist describe"
	end

	it "Show Error when no describe" do
		expect(TodoList.count).to eq(0)

		create_todo_list description:""

		expect(page).to have_content "error"
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"

		expect(page).to_not have_content "my todolist title"
	end

	it "Show Error when describe length is less than 10" do
		expect(TodoList.count).to eq(0)

		create_todo_list description:"12345"

		expect(page).to have_content "error"
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"

		expect(page).to_not have_content "my todolist title"
	end
end