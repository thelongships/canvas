#
# Copyright (C) 2011 Instructure, Inc.
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

require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper.rb')

describe SIS::UserImporter do
  it "should split into transactions based on time elapsed" do
    account_model
    messages = []
    Setting.set('sis_transaction_seconds', '1')
    # this is the fun bit where we get to stub User.new to insert a sleep into
    # the transaction loop.
    class User
      def _stub_sleep
        sleep 1
        true
      end
      before_save :_stub_sleep
    end

    SIS::UserImporter.new(@account, {}).process(2, messages) do |importer|
      importer.add_user(*"U001,user1,active,User,One,user1@example.com".split(','))
      importer.add_user(*"U002,user2,active,User,Two,user2@example.com".split(','))
      importer.add_user(*"U003,user3,active,User,Three,user3@example.com".split(','))
    end
    Pseudonym.all.map(&:sis_user_id).sort.should == %w(U001 U002 U003)

    class User
      @before_save_callbacks.delete :_stub_sleep
    end
  end

  it 'should handle user_ids as integers just in case' do
    SIS::UserImporter.new(account_model, {}).process(2, []) do |importer|
      importer.add_user(12345, 'user1', 'active', 'User', 'One', 'user1@example.com')
    end
    Pseudonym.last.sis_user_id.should == '12345'
  end
end
