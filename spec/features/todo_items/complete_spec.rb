require "spec_helper"

describe "Complete todo item" do
	let!(:todo_list) { TodoList.create(title: "grociry list", description: "grociry list desc") }
	let!(:todo_item) { todo_list.todo_items.create(content: "Milk") }

	it "is successfull when check singl it complete" do
		expect(todo_item.completed_at).to be_nil
		visit_todo_list todo_list
		within dom_id_for(todo_item) do
			click_link "Mark Complete"
		end
		todo_item.reload
		expect(todo_item.completed_at).to_not be_nil
	end

	context "with completed items" do
		let!(:completed_todo_item) { todo_list.todo_items.create(content: "Milk", completed_at: 5.minutes.ago) }

		it "should display completed time" do
			visit_todo_list todo_list
			within dom_id_for(completed_todo_item) do
				expect(page).to have_content(completed_todo_item.completed_at)
			end
		end

		it "Should Hide the mark as completed option" do
			visit_todo_list todo_list
			within dom_id_for(completed_todo_item) do
				expect(page).to_not have_content("Mark Complete")
			end
		end
	end
end