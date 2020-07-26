require 'rails_helper'

RSpec.describe Post, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  context "Validate title post" do
    it "Valid title" do
      post = Post.new(title: "First title", content: "Content")
      expect(post).to be_valid
    end

    it "Not valid title" do
      post = Post.new(content: "Content")
      expect(post).to_not be_valid
    end
  end

  context "Validate content post" do
    it "Valid content" do
      post = Post.new(title: "New title", content: "Content")
      expect(post).to be_valid
    end

    it "Not content title" do
      post = Post.new(title: "New title")
      expect(post).to_not be_valid
    end
  end
end
