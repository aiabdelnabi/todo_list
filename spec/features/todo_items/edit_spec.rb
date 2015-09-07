require "spec_helper"

describe "Editing todo items" do
	let!(:todo_list) { TodoList.create(title: "Grocery list", description: "Grocery items") }
	let!(:todo_item) { todo_list.todo_items.create(content: "Milk") }

	def visit_todo_list(list)
		visit "/todo_lists"
		within "#todo_list_#{list.id}" do
			click_link "List Items"
		end
	end

	it "is successful with vaild content" do
		visit_todo_list(todo_list)
		within("#todo_item_#{todo_item.id}") do
			click_link "Edit"
		end

		fill_in "Content", with: "lots of Milk"
		click_button "Save"
		expect(page).to have_content("Saved todo list item.")
		todo_item.reload
		expect(todo_item.content).to eq("lots of Milk")
	end

	it "is unsuccessful with no content" do
		visit_todo_list(todo_list)
		within("#todo_item_#{todo_item.id}") do
			click_link "Edit"
		end

		fill_in "Content", with: ""
		click_button "Save"
		expect(page).to have_content("That todo item could no be saved.")
		expect(page).to have_content("Content can't be blank")
		todo_item.reload
		expect(todo_item.content).to eq("Milk")
	end

	it "is unsuccessful with content length less than 2" do
		visit_todo_list(todo_list)
		within("#todo_item_#{todo_item.id}") do
			click_link "Edit"
		end

		fill_in "Content", with: "h"
		click_button "Save"
		expect(page).to have_content("That todo item could no be saved.")
		expect(page).to have_content("Content is too short")
		todo_item.reload
		expect(todo_item.content).to eq("Milk")
	end
end