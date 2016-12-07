module OmniauthUnigleam
  def my_omniauth(ominiauth_data)
    data = ominiauth_data.info
    if data['email'].present?
      user = User.where(email: data['email']).try(:last)
    else ## Find with user_name when email is not find.
    	user = find_with_username(ominiauth_data)
    end
    if user.present?
      if user.authenticates.present?
        ominiauth_user = user.authenticates.find_by_provider(ominiauth_data['provider'])
       	create_new_provider_authenticates(ominiauth_data, user) if ominiauth_user.nil?
      else
      	create_new_provider_authenticates(ominiauth_data, user)
      end
      user.save
      user
    else
      password = rand 100000000 # for new user.
    	case ominiauth_data['provider']
      when 'google_oauth2'
      	user = create_google_user(ominiauth_data, user, password)
      when 'twitter'
      	user = create_twitter_user(ominiauth_data, user, password)
      when 'facebook'
      	user = create_facebook_user(ominiauth_data, user, password)
      when 'instagram'
      	user = create_instagram_user(ominiauth_data, user, password)
      end
      user.save
      user
    end
    return user
	end

	private

	def find_with_username(ominiauth_data)
		case ominiauth_data['provider']
    when 'twitter'
      uname = ominiauth_data.info['nickname'].delete(' ')
    when 'facebook'
      uname = ominiauth_data.info['name'].delete(' ')
    when 'google_oauth2'
      uname = ominiauth_data.info['name'].delete(' ')
    when 'instagram'
      uname = ominiauth_data.extra.raw_info['username'].delete(' ')
    end
    return User.where(username: uname).try(:last)
	end

	def create_new_provider_authenticates(ominiauth_data, user)
		case ominiauth_data['provider']
    when 'google_oauth2'
    	build_google_omniauth(ominiauth_data, user)
    when 'twitter'
    	build_twitter_omniauth(ominiauth_data, user)
    when 'facebook'
    	build_facebook_omniauth(ominiauth_data, user)
		when 'instagram'
			build_instagram_omniauth(ominiauth_data, user)
    end
    user.save
    user
	end

	def build_instagram_omniauth(ominiauth_data, user)
		user.authenticates.build({
			provider: ominiauth_data['provider'],
			uid: ominiauth_data['uid'],
			image_url: ominiauth_data.info['image'],
			token: ominiauth_data.credentials['token'],
			refresh_token: ominiauth_data.credentials['token'],
			profile_image: ominiauth_data.extra.raw_info['picture'],
			access_token: ominiauth_data.credentials['token']
		})
	end

	def build_facebook_omniauth(ominiauth_data, user)
		user.authenticates.build({
			provider: ominiauth_data['provider'],
			uid: ominiauth_data['uid'],
			token: ominiauth_data.credentials['token'],
			refresh_token: ominiauth_data.credentials['token'],
			image_url: ominiauth_data.info['image'],
			profile: ominiauth_data.info['urls'],
			profile_image: ominiauth_data.info['image'],
			access_token: ominiauth_data.credentials['token']
		})
	end

	def build_twitter_omniauth(ominiauth_data, user)
		user.authenticates.build({
			provider: ominiauth_data['provider'],
			uid: ominiauth_data['uid'],
			token: ominiauth_data.credentials['token'],
			refresh_token: ominiauth_data.credentials['secret'],
			image_url: ominiauth_data.info['image'],
			profile: ominiauth_data.info.urls['Twitter'],
			profile_image: ominiauth_data.extra.raw_info['profile_image_url'],
			location: ominiauth_data.extra.raw_info['location'],
			access_token: ominiauth_data.credentials['token']
		})
	end

	def build_google_omniauth(ominiauth_data, user)
		user.authenticates.build({
			provider: ominiauth_data['provider'],
			uid: ominiauth_data['uid'],
			image_url: ominiauth_data.info['image'],
			token: ominiauth_data.credentials['token'],
			refresh_token: ominiauth_data.credentials['refresh_token'],
			expires_at: ominiauth_data.credentials['expires_at'],
			expires: ominiauth_data.extra.raw_info['expires'],
			profile: ominiauth_data.extra.raw_info['profile'],
			profile_image: ominiauth_data.extra.raw_info['picture'],
			gender: ominiauth_data.extra.raw_info['gender'],
			access_token: ominiauth_data.credentials['token']
		})
	end

	def create_google_user(ominiauth_data, user, password)
    username = ominiauth_data.info['email'].split('@')[0] # split(return an array) email & take first part(first element of array) as username.
    user = User.new({
    	email: ominiauth_data.info['email'],
    	password: password,
    	password_confirmation: password,
    	first_name: ominiauth_data.info['first_name'],
    	last_name: ominiauth_data.info['last_name'],
    	username: username
    })
    build_google_omniauth(ominiauth_data, user)
    return user
	end

	def create_twitter_user(ominiauth_data, user, password)
    first_name 	= ominiauth_data.info['name'].split(' ')[0]
    last_name 	= ominiauth_data.info['name'].split(' ')[1]
    user = User.new({
    	email: ominiauth_data.info['email'],
    	password: password,
    	password_confirmation: password,
    	first_name: first_name,
    	last_name: last_name,
    	username: ominiauth_data.info['nickname'].delete(' ')
    })
    build_google_omniauth(ominiauth_data, user)
    return user
	end

	def create_facebook_user(ominiauth_data, user, password)
    first_name 	= ominiauth_data.info['first_name'].present? ? ominiauth_data.info['first_name'] : ominiauth_data.info['name'].split(' ')[0]
   	last_name 	= ominiauth_data.info['last_name'].present? ? ominiauth_data.info['last_name'] : ominiauth_data.info['name'].split(' ')[1]
    user = User.new({
    	email: ominiauth_data.info['email'],
    	password: password,
    	password_confirmation: password,
    	first_name: first_name,
    	last_name: last_name,
    	username: ominiauth_data.info['name'].delete(' ')
    })
    build_facebook_omniauth(ominiauth_data, user)
    return user
	end

	def create_instagram_user(ominiauth_data, user, password)
    first_name 	= ominiauth_data.extra.raw_info['full_name'].split(' ')[0]
    last_name 	= ominiauth_data.extra.raw_info['full_name'].split(' ')[1]
    user = User.new({
    	password: password,
    	password_confirmation: password,
    	first_name: first_name,
    	last_name: last_name,
    	username: ominiauth_data.extra.raw_info['username'].delete(' ')
    })
    build_instagram_omniauth(ominiauth_data, user)
    return user
	end

end
