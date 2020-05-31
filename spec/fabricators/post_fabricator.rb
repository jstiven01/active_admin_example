Fabricator(:post) do
    
    title { 'title test' }
    body { 'body test' }
    published_at {Time.now}
    user
end