require k_link "Edit"
		end"spec_helper"

describe "Editing todo list" do

	let!(:todo_list) {TodoList.create(title: "grocery", description: "shoping list")}

	def update_todo_list(options={})
		options[:title] ||= "new title"
		options[:description] ||= "new description"

		todo_list = options[:todo_list]

		visit "/todo_lists"

		within "#todo_list_#{todo_list.id}" do
			click_link "Edit"
		end

		fill_in "Title", with: "new title"
		fill_in "Description", with: "new description"

		click_button "Update Todo list"

	end	

	it "updates todo list successfully with correct information" do
		update_todo_list  todo_list: todo_list

		todo_list.reload

		expect(page).to have_content "new title"
		expect(todo_list.title).to eq("new title")
		expect(todo_list.description).to eq("new description")

	end
end