require "spec_helper"

describe "Show todo item" do

	let!(:todo_list) { TodoList.create(title: "new todo list", description: "todo list describe") }

	def visit_todo_list(list)
		visit "/todo_lists"

		within "#todo_list_#{list.id}" do
			#click_link "List Items"
		end
	end

	it "display todo list title" do
		visit_todo_list(todo_list)
		#within("h1") do
			#expect(page).to have_content(todo_list.title)
		#end
	end

	#it "display no items when a todo list is empty" do
		#visit_todo_list(todo_list)
		#expect(page.all("#ul.todo_items li").size).to eq(0)
	#end	

	#it "display items when a todo list has items" do
		#todo_list.todo_items.create(content: "list items")
		
		#visit_todo_list(todo_list)

		#expect(page.all("#ul.todo_items li").size).to eq(1)
	#end

end