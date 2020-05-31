ActiveAdmin.register Post do
  permit_params :title, :body, :published_at, :user_id

  scope :all
  scope :published
  scope :unpublished
  
  form do |f|
    inputs 'Details' do 
      input :body
      input :title
      input :user
    end
    actions
  end
  action_item :view, only: :show do
    link_to 'Publish', publish_admin_post_path(post), method: :put unless post.published_at?
  end

  action_item :view, only: :show do
    link_to 'Unpublish', unpublish_admin_post_path(post), method: :put if post.published_at?
  end

  member_action :publish, method: :put do
    post = Post.find(params[:id])
    post.update(published_at: Time.zone.now)
    redirect_to admin_post_path(post)
  end

  member_action :unpublish, method: :put do
    post = Post.find(params[:id])
    post.update(published_at: nil)
    redirect_to admin_post_path(post)
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :title, :body, :published_at, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :body, :published_at, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
