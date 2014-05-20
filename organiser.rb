require "bundler"
Bundler.require(:default)

JTask.configure do |config|
  config.file_dir = "storage"
end

class Organiser < Sinatra::Base
  get "/" do
    @orders = JTask.get("orders.json")
    erb :index
  end

  post "/new_order" do
    JTask.save("orders.json", {
      name: params[:name],
      order: params[:order],
      price: params[:price],
      paid: params[:paid]
    })
    redirect "/"
  end

  get "/update_order/:id" do
    @order = JTask.get("orders.json", params[:id].to_i)
    erb :update
  end

  post "/update_order/:id" do
    JTask.update("orders.json", params[:id], {
      name: params[:name],
      order: params[:order],
      price: params[:price],
      paid: params[:paid]
    })
    redirect "/"
  end

  get "/delete_order/:id" do
    JTask.destroy("orders.json", params[:id].to_i)
    redirect "/"
  end
end