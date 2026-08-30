class BoardPostsController < ApplicationController
before_action :authenticate_user!

def index
family = current_user.families.first

@board_posts = BoardPost
                 .joins(:family_member)
                 .where(family_members: { family_id: family.id })
                 .includes(family_member: :user)
                 .order(created_at: :desc)
                 .page(params[:page])
                 .per(10)

end

def new
family = current_user.families.first

@board_full = BoardPost
                .joins(:family_member)
                .where(family_members: { family_id: family.id })
                .count >= 3

@board_post = BoardPost.new

end

def create
family = current_user.families.first
family_member = current_user.family_members.first

if BoardPost.joins(:family_member)
            .where(family_members: { family_id: family.id })
            .count >= 3
  redirect_to board_posts_path,
              alert: "📋 ホワイトボードは3枚までです。古いメモを剥がすと新しく貼れます！"
  return
end

@board_post = BoardPost.new(board_post_params)
@board_post.family_member = family_member

if @board_post.save
  redirect_to board_posts_path
else
  render :new, status: :unprocessable_entity
end

end

def destroy
family = current_user.families.first

@board_post = BoardPost
                .joins(:family_member)
                .where(family_members: { family_id: family.id })
                .find(params[:id])

@board_post.destroy

redirect_to board_posts_path

end

private

def board_post_params
params.require(:board_post).permit(:body)
end
end
