require 'spec_helper'

describe "Adding todo items" do
	let!(:todo_list) { TodoList.create(title: "grocery list", description: "grocery items") }

	def visit_todo_list(list)
		visit "/todo_lists"
		within "#todo_list_#{list.id}" do
			click_link "List Items"
		end	
	end	

	it "is successfil with valid content" do
		visit_todo_list(todo_list)
		click_link "New Todo Item"
		fill_in "Content", with: "Milk"
		click_button "Save"
		expect(page).to have_content("Save new item successfuly")
		within("ul.todo_items") do
			expect(page).to have_content("Milk")
		end
	end

	it "displays an error with no content" do
		visit_todo_list(todo_list)
		click_link "New Todo Item"
		fill_in "Content", with: ""
		click_button "Save"
		within "div.flash" do
			expect(page).to have_content("Save new item error")	
		end
		expect(page).to have_content("Content can't be blank")
	end

	it "it displays an error with content length less than 5" do
		visit_todo_list(todo_list)
		click_link "New Todo Item"
		fill_in "Content", with: "h"
		click_button "Save"
		within "div.flash" do
			expect(page).to have_content("Save new item error")	
		end
		expect(page).to have_content("Content is too short")
	end


end