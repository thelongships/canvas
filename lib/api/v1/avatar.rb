#
# Copyright (C) 2012 Instructure, Inc.
#
# This file is part of Canvas.
#
# Canvas is free software: you can redistribute it and/or modify it under
# the terms of the GNU Affero General Public License as published by the Free
# Software Foundation, version 3 of the License.
#
# Canvas is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE. See the GNU Affero General Public License for more
# details.
#
# You should have received a copy of the GNU Affero General Public License along
# with this program. If not, see <http://www.gnu.org/licenses/>.
#

module Api::V1::Avatar
  include Api::V1::Json
  include Api::V1::Attachment
  #include model::Kthavatar

  def avatars_json_for_user(user, includes={})
    avatars = []
   
    # getting images from server and showing it
    list_of_cartoons = Kthavatar.get_available_avatars()
    list_of_cartoons.each do |cartoon|
      avatars << avatar_json_no_change(user, User.avatar_fallback_url(cartoon, request), {
        :type => 'attachment',
        :alt => 'is this the one?',
        :name => user.name
      })
     end
    avatars
  end

  def avatar_json(user, attachment_or_url, options = {})
    json = if options[:type] == 'attachment'
      attachment_json(attachment_or_url, user, {}, { :thumbnail_url => true })
    else
      { 'url' => attachment_or_url }
    end

    json['type'] = options[:type]
    json['display_name'] ||= options[:alt]
    json['pending'] = options[:pending] unless api_request?
    json['token'] = construct_token(user, json['type'], json['url'])
    json
  end

  def avatar_json_no_change(user, attachment_or_url, options = {})
    json = if options[:type] == 'attachment'
      {'url' => attachment_or_url }
    else
      { 'url' => attachment_or_url }
    end

    json['type'] = options[:type]
    json['display_name'] ||= options[:name]
    json['pending'] = options[:pending] unless api_request?
    json['token'] = construct_token(user, json['type'], json['url'])
    json
  end
  
  
  def construct_token(user, type, url)
    uid = user.is_a?(User) ? user.id : user
    token = "#{uid}::#{type}::#{url}"
    Canvas::Security.hmac_sha1(token)
  end

  def avatar_for_token(user, token)
    chosenAvatar = avatars_json_for_user(user).select{ |j| j['token'] == token }.first
    nameOfAvatar = chosenAvatar['url'].split('/').last.split('.').first 
    result = Kthavatar.update_avatars_taken(nameOfAvatar)
    avatars_json_for_user(user).select{ |j| j['token'] == token }.first
    chosenAvatar
  end
end
