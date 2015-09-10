require 'spec_helper'

describe TodoList do
  it { should have_many(:todo_items) }

  describe "#has_completed_items?" do
  	let!(:todo_list) { TodoList.create(title: "Groceries", description: "Grocery list desc") }

  	it "Should return true with completed list items" do
  	 	todo_list.todo_items.create(content: "Eggs", completed_at: 1.minute.ago)

  		expect(todo_list.has_completed_items?).to be_true
  	end

	it "Should return false with uncompleted list items" do
  	 	todo_list.todo_items.create(content: "Eggs")

  		expect(todo_list.has_completed_items?).to be_false
  	end
  end

  describe "#has_incompleted_items?" do
  	let!(:todo_list) { TodoList.create(title: "Groceries", description: "Grocery list desc") }

  	it "Should Return true with incompleted list items" do
  		todo_list.todo_items.create(content: "eggs")
  		expect(todo_list.has_incompleted_items?).to be_true
  	end

  	it "Should return false with no incompleted list items" do
  		todo_list.todo_items.create(content: "eggs", completed_at: 1.minute.ago)
  		expect(todo_list.has_incompleted_items?).to be_false
  	end
  end

end
