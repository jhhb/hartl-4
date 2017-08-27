FactoryGirl.define do 
	factory :user do 
		name "James Boyle"
		email "James@gmail.com"
		password "foobar"
		password_confirmation "foobar"
	end
end