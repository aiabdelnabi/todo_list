require "spec_helper"

describe "Delete todo item" do
	let!(:todo_list) { TodoList.create(title: "Grocery list", description: "Grocery list descrip") }
	let!(:todo_item) { todo_list.todo_items.create(content: "Milk") }

	it "Should delete todo item" do
		visit_todo_list(todo_list)
		within "#todo_item_#{todo_item.id}" do
			click_link "Delete"
		end
		expect(page).to have_content("todo item was successfully deleted")
		expect(TodoItem.count).to eq(0)
	end
end