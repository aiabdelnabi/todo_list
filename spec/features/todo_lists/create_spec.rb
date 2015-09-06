require 'spec_helper'

describe "Create a todo list" do
	it "Redirect to todolist index page on success" do
		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content "New Todo List"

		fill_in "Title", with: "my todo list"
		fill_in "Description", with: "my todolist describe"

		click_button "Create Todo list"
		expect(page).to have_content "my todo list"
	end

	it "Show Error when no title" do
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content "New Todo List"

		fill_in "Title", with: ""
		fill_in "Description", with: "my todolist describe"

		click_button "Create Todo list"

		expect(page).to have_content "error"
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"

		expect(page).to_not have_content "my todolist describe"
	end

	it "Show Error when title lenght is less than 3" do
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content "New Todo List"

		fill_in "Title", with: "hi"
		fill_in "Description", with: "my todolist describe"

		click_button "Create Todo list"

		expect(page).to have_content "error"
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"

		expect(page).to_not have_content "my todolist describe"
	end	
end