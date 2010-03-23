module FakeWeb
  module Mapping

    def self.build(*args)
      url_path = args[0]
      alt      = args[1]
      case alt
      when :empty
        case url_path

          # PRINCIPAL LIST
        when "principal-list&filter-principal-id=1035770400"
          FakeWeb::Declaration.principal_list_1035770400_empty
        when "principal-list&filter-principal-id=1035814880&filter-type=user"
          FakeWeb::Declaration.principal_list_1035814880_for_User_empty
        when "principal-list&filter-principal-id=1035816176&filter-type=user"
          FakeWeb::Declaration.principal_list_1035816176_for_Guest_empty
        when "principal-list&group-id=1030182055&filter-is-member=true"
          FakeWeb::Declaration.principal_list_is_member_of_1030182055_empty
        when "principal-list&group-id=1030182055&filter-is-member=true&filter-principal-id=1035814880"
          FakeWeb::Declaration.principal_list_is_member_of_1030182055_1035814880_empty
        when "principal-list&group-id=1030182057&filter-is-member=true"
          FakeWeb::Declaration.principal_list_is_member_of_1030182057_empty
        when "principal-list&group-id=1030182057&filter-is-member=true&filter-principal-id=1035814880"
          FakeWeb::Declaration.principal_list_is_member_of_1030182057_1035814880_empty
        when "principal-list&filter-type=user"
          FakeWeb::Declaration.principal_list_filter_users_empty
        when "principal-list&filter-type=guest"
          FakeWeb::Declaration.principal_list_filter_guests_empty

          # SCO CONTENTS
        when "sco-contents&sco-id=1030182076"
          FakeWeb::Declaration.sco_contents_1030182076_empty
        when "sco-contents&sco-id=1030182068"
          FakeWeb::Declaration.sco_contents_1030182068_empty
        when "sco-contents&sco-id=1030182072"
          FakeWeb::Declaration.sco_contents_1030182072_empty
        when "sco-contents&sco-id=1030182070"
          FakeWeb::Declaration.sco_contents_1030182070_empty
        when "sco-contents&sco-id=1030182069"
          FakeWeb::Declaration.sco_contents_1030182069_empty
        when "sco-contents&sco-id=1030182067"
          FakeWeb::Declaration.sco_contents_1030182067_empty
        when "sco-contents&sco-id=1030182042"
          FakeWeb::Declaration.sco_contents_1030182042_empty
        when "sco-contents&sco-id=1030182044"
          FakeWeb::Declaration.sco_contents_1030182044_empty
        when "sco-contents&sco-id=1030182043"
          FakeWeb::Declaration.sco_contents_1030182043_empty
        when "sco-contents&sco-id=1030182045"
          FakeWeb::Declaration.sco_contents_1030182045_empty
        when "sco-contents&sco-id=1030182046"
          FakeWeb::Declaration.sco_contents_1030182046_empty
        when "sco-contents&sco-id=1030182047"
          FakeWeb::Declaration.sco_contents_1030182047_empty
        when "sco-contents&sco-id=1030182048"
          FakeWeb::Declaration.sco_contents_1030182048_empty
        when "sco-contents&sco-id=1030182049"
          FakeWeb::Declaration.sco_contents_1030182049_empty
        when "sco-contents&sco-id=1030182050"
          FakeWeb::Declaration.sco_contents_1030182050_empty
        when "sco-contents&sco-id=1030182054"
          FakeWeb::Declaration.sco_contents_1030182054_empty
        when "sco-contents&sco-id=1030182052"
          FakeWeb::Declaration.sco_contents_1030182052_empty
        when "sco-contents&sco-id=1030182053"
          FakeWeb::Declaration.sco_contents_1030182053_empty
        else
          raise "No FakeWebMapping could be found for \"#{url_path}\", please include one in the module!"
        end
      else
        case url_path

          # SIGNIN
        when "login&login=user@test.com&password=password"
          FakeWeb::Declaration.login_user
        when "login&login=other_user@test.com&password=newpassword"
          FakeWeb::Declaration.login_other_user
        when "login&login=ryan.moran@gmail.com&password=revprep123"
          FakeWeb::Declaration.login_admin

          # SIGNOUT
        when "logout"
          FakeWeb::Declaration.logout 

          # PRINCIPAL-LIST
        when "principal-list"
          FakeWeb::Declaration.principal_list

        when "principal-list&filter-principal-id=1035770400"
          FakeWeb::Declaration.principal_list_1035770400
        when "principal-list&filter-principal-id=1030094617"
          FakeWeb::Declaration.principal_list_1030094617
        when "principal-list&filter-principal-id=1030182057"
          FakeWeb::Declaration.principal_list_1030182057

        when "principal-list&filter-principal-id=1030094617&filter-type=user"
          FakeWeb::Declaration.principal_list_1030094617_for_User
        when "principal-list&filter-principal-id=1035814880&filter-type=user"
          FakeWeb::Declaration.principal_list_1035814880_for_User

        when "principal-list&filter-principal-id=1035816176&filter-type=user"
          FakeWeb::Declaration.principal_list_1035816176_for_Guest

        when "principal-list&filter-is-member=true&group-id=1030182057"
          FakeWeb::Declaration.principal_list_members_of_1030182057
        when "principal-list&filter-is-member=true&group-id=1030182057&filter-principal-id=1030094617"
          FakeWeb::Declaration.principal_list_members_of_1030182057_1030094617

        when "principal-list&filter-type=user"
          FakeWeb::Declaration.principal_list_filter_users

        when "principal-list&filter-type=guest"
          FakeWeb::Declaration.principal_list_filter_guests

        when "principal-list&filter-type=admins"
          FakeWeb::Declaration.principal_list_filter_admins

        when "principal-list&group-id=1030182055&filter-is-member=true"
          FakeWeb::Declaration.principal_list_is_member_of_1030182055

        when "principal-list&group-id=1030182055&filter-is-member=true&filter-principal-id=1035814880"
          FakeWeb::Declaration.principal_list_is_member_of_1030182055_1035814880

        when "principal-list&filter-type=live-admins"
          FakeWeb::Declaration.principal_list_filter_live_admins

        when "principal-list&group-id=1030182057&filter-is-member=true"
          FakeWeb::Declaration.principal_list_is_member_of_1030182057
        when "principal-list&group-id=1030182057&filter-is-member=true&filter-principal-id=1035814880"
          FakeWeb::Declaration.principal_list_is_member_of_1030182057_1035814880

          # PRINCIPAL-UPDATE
        when "principal-update&account-id=1030182041&name=Base%20Obj&login=user@test.com&type=user&has-children=false&is-primary=false&is-hidden=false"
          FakeWeb::Declaration.principal_update_Base_Obj
        when "principal-update&principal-id=1035770400&account-id=1030182041&training-group-id=1234&name=Other%20Obj&login=other_user@test.com&has-children=true&is-primary=true&is-hidden=true"
          FakeWeb::Declaration.principal_update_Other_Obj

        when "principal-update&account-id=1030182041&name=Base%20Obj&login=user@test.com&type=user&has-children=false&is-primary=false&is-hidden=false&password=password&email=user@test.com"
          FakeWeb::Declaration.principal_update_Base_Obj_for_User
        when "principal-update&principal-id=1035814880&account-id=1030182041&training-group-id=1234&name=Other%20Obj&login=other_user@test.com&has-children=true&is-primary=true&is-hidden=true&password=newpassword&email=other_user@test.com"
          FakeWeb::Declaration.principal_update_Other_Obj_for_User

        when "principal-update&account-id=1030182041&name=Base%20Obj&login=user@test.com&type=guest&has-children=false&is-primary=false&is-hidden=false&password=password&email=user@test.com"
          FakeWeb::Declaration.principal_update_Base_Obj_for_Guest
        when "principal-update&principal-id=1035816176&account-id=1030182041&training-group-id=1234&name=Other%20Obj&login=other_user@test.com&has-children=true&is-primary=true&is-hidden=true&password=newpassword&email=other_user@test.com"
          FakeWeb::Declaration.principal_update_Other_Obj_for_Guest

          # PRINCIPALS-DELETE
        when "principals-delete&principal-id=1035770400"
          FakeWeb::Declaration.principals_delete_1035770400
        when "principals-delete&principal-id=1035814880"
          FakeWeb::Declaration.principals_delete_1035814880
        when "principals-delete&principal-id=1035816176"
          FakeWeb::Declaration.principals_delete_1035816176

          # HTTP REQUEST
        when "https://example.com/success"
          FakeWeb::Declaration.http_request_success
        when "https://example.com/invalid"
          FakeWeb::Declaration.http_request_invalid
        when "https://example.com/failure"
          FakeWeb::Declaration.http_request_failure
        when "https://example.com/indeterminant"
          FakeWeb::Declaration.http_request_indeterminant
        when "https://example.com/internal_error"
          FakeWeb::Declaration.http_request_internal_error

          # GROUP MEMBERSHIP UPDATE
        when "group-membership-update&group-id=1030182057&principal-id=1035814880&is-member=true"
          FakeWeb::Declaration.group_membership_update_1030182057_1035814880

          # SCO UPDATE
        when "sco-update&date-begin=2010-02-04T18:03:38-08:00&date-end=2010-02-04T19:03:38-08:00&description=this%20is%20some%20description&folder-id=1030182069&name=SCO&source-sco-id=1030182073&type=meeting&url-path=sco_path"
          FakeWeb::Declaration.sco_update_SCO
        when "sco-update&sco-id=1036115664&date-begin=2010-02-04T20:03:38-08:00&date-end=2010-02-04T21:03:38-08:00&description=this%20is%20some%20new%20description&name=SCO%20New"
          FakeWeb::Declaration.sco_update_SCO_New
        when "sco-update&date-begin=2010-02-04T18:03:38-08:00&date-end=2010-02-04T19:03:38-08:00&description=this%20is%20some%20description&folder-id=1030182072&name=TEMPLATE&source-sco-id=1030182073&type=meeting&url-path=sco_template_path"
          FakeWeb::Declaration.sco_update_TEMPLATE
        when "sco-update&sco-id=1037064220&date-begin=2010-02-04T20:03:38-08:00&date-end=2010-02-04T21:03:38-08:00&description=this%20is%20some%20new%20description&name=TEMPLATE%20New"
          FakeWeb::Declaration.sco_update_TEMPLATE_New

          # SCO DELETE
        when "sco-delete&sco-id=1036115664"
          FakeWeb::Declaration.sco_delete_1036115664
        when "sco-delete&sco-id=1037064220"
          FakeWeb::Declaration.sco_delete_1037064220

          # SCO SHORTCUTS
        when "sco-shortcuts"
          FakeWeb::Declaration.sco_shortcuts

          # SCO CONTENTS
        when "sco-contents&sco-id=1030182076"
          FakeWeb::Declaration.sco_contents_1030182076
        when "sco-contents&sco-id=1030182068"
          FakeWeb::Declaration.sco_contents_1030182068
        when "sco-contents&sco-id=1030182072"
          FakeWeb::Declaration.sco_contents_1030182072
        when "sco-contents&sco-id=1030182070"
          FakeWeb::Declaration.sco_contents_1030182070
        when "sco-contents&sco-id=1030182069"
          FakeWeb::Declaration.sco_contents_1030182069
        when "sco-contents&sco-id=1030182067"
          FakeWeb::Declaration.sco_contents_1030182067
        when "sco-contents&sco-id=1030182042"
          FakeWeb::Declaration.sco_contents_1030182042
        when "sco-contents&sco-id=1030182044"
          FakeWeb::Declaration.sco_contents_1030182044
        when "sco-contents&sco-id=1030182043"
          FakeWeb::Declaration.sco_contents_1030182043
        when "sco-contents&sco-id=1030182045"
          FakeWeb::Declaration.sco_contents_1030182045
        when "sco-contents&sco-id=1030182046"
          FakeWeb::Declaration.sco_contents_1030182046
        when "sco-contents&sco-id=1030182047"
          FakeWeb::Declaration.sco_contents_1030182047
        when "sco-contents&sco-id=1030182048"
          FakeWeb::Declaration.sco_contents_1030182048
        when "sco-contents&sco-id=1030182049"
          FakeWeb::Declaration.sco_contents_1030182049
        when "sco-contents&sco-id=1030182050"
          FakeWeb::Declaration.sco_contents_1030182050
        when "sco-contents&sco-id=1030182054"
          FakeWeb::Declaration.sco_contents_1030182054
        when "sco-contents&sco-id=1030182052"
          FakeWeb::Declaration.sco_contents_1030182052
        when "sco-contents&sco-id=1030182053"
          FakeWeb::Declaration.sco_contents_1030182053

          # SCO INFO
        when "sco-info&sco-id=12345"
          FakeWeb::Declaration.sco_info_12345
        when "sco-info&sco-id=1030726615"
          FakeWeb::Declaration.sco_info_1030726615

          # PERMISSIONS UPDATE
        when "permissions-update&acl-id=1036115664&principal-id=1035814880&permission-id=host"
          FakeWeb::Declaration.permissions_update_1036115664_1035814880
        when "permissions-update&acl-id=1037064220&principal-id=public-access&permission-id=denied"
          FakeWeb::Declaration.permissions_update_1037064220_public_access
        when "permissions-update&acl-id=1036115664&principal-id=public-access&permission-id=denied"
          FakeWeb::Declaration.permissions_update_1036115664_public_access

          # PERMISSIONS INFO
        when "permissions-info&acl-id=1036115664&principal-id=1035814880"
          FakeWeb::Declaration.permissions_info_1036115664_1035814880

          # MAPPING DOESN'T EXIST
        else
          raise "No FakeWebMapping could be found for \"#{url_path}\", please include one in the module!"
        end
      end
    end

  end
end