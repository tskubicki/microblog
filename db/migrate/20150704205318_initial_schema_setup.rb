class InitialSchemaSetup < ActiveRecord::Migration
  def change
	create_table :users do |t|
		t.string :user_name
		t.string :password
		t.string :first_name
		t.string :last_name
		t.string :email
		t.datetime :created
		t.datetime :modified
	end
	
	create_table :posts do |t|
		t.integer :user_id
		t.string :content
		t.datetime :created
		t.datetime :modified
	end
	
	create_table :groups do |t|
		t.string :group_name
		t.string :about
		t.datetime :created
		t.datetime :modified
	end
	
	create_table :groups_users, id: false do |t|
		t.integer :group_id, index: true
		t.integer :user_id, index: true
	end
	
	create_table :follows, id: false do |t|
		t.integer :followee_id
		t.integer :follower_id
	end
	
  end
end
