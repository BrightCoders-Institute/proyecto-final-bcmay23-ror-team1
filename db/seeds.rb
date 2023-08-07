# Post
Post.create([
  {
    content: "test post 1", 
    user_id: 1
  },
  {
    content: "test post 2", 
    user_id: 2
  },
  {
    content: "test post 3", 
    user_id: 3
  }
])

# SharedPost
SharedPost.create([
  {
    user: User.first, 
    post: Post.second
  },
  {
    user: User.first, 
    post: Post.third
  },
  {
    user: User.second, 
    post: Post.third
  }
])
