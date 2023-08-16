# frozen_string_literal: true

users = User.create([
    { name: "Aaa Aaa", username: "a", email: "a@a.a", password: "123456" },
    { name: "Bbb Bbb", username: "b", email: "b@b.b", password: "123456" },
])

posts = Post.create([
    #Posts
    { content: "This is the first post", user_id: 1 },
    { content: "This is the second post", user_id: 1 },

    # Comments
    { content: "Comment on post 1", user_id: 1, parent_id: 1 },
    { content: "Comment on comment post 1", user_id: 2, parent_id: 3 },
    { content: "Comment on comment on comment post 1", user_id: 1, parent_id: 4 },
])
