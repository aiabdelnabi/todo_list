class TodoItemsController < ApplicationController

  before_action :find_todo_list

  def index
  end

  def new
  		@todo_item = @todo_list.todo_items.new
  end

  def create
  		@todo_item = @todo_list.todo_items.create(todo_item_params)

  		if @todo_item.save
  			flash[:success] = "Save new item successfuly";
  			redirect_to todo_list_todo_items_path
  		else
  			flash[:error] = "Save new item error";
  			render action: :new 
  		end	
  end

  def edit
    @todo_item = @todo_list.todo_items.find(params[:id])
  end

  def update
    @todo_item = @todo_list.todo_items.find(params[:id])
    if(@todo_item.update_attributes(todo_item_params))
      flash[:success] = "Saved todo list item."
      redirect_to todo_list_todo_items_path
    else
      flash[:error] = "That todo item could no be saved."
      render action: :edit
    end
  end

  def destroy
    @todo_item = @todo_list.todo_items.find(params[:id])

    if @todo_item.destroy
      flash[:success] = "todo item was successfully deleted"
    else
      flash[:error] = "todo item could not be deleted"
    end
    redirect_to todo_list_todo_items_path
  end

  def complete
    @todo_item = @todo_list.todo_items.find(params[:id])
    @todo_item.update_attribute(:completed_at, Time.now)
    redirect_to todo_list_todo_items_path, notice: "todo item is complete"

  end


  def url_options
    { todo_list_id: params[:todo_list_id] }.merge(super)
  end

  private
  def find_todo_list
     @todo_list = TodoList.find(params[:todo_list_id])
  end

  def todo_item_params
  		params[:todo_item].permit(:content)
  end

end
