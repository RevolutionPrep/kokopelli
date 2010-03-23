module FakeWeb
  module Declaration

    def self.http_request_internal_error
      FakeWeb.register_uri(:get, "https://example.com/internal_error&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"internal-error\" />
      <exception>
      Exception Backtrace
      </exception>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.http_request_indeterminant
      FakeWeb.register_uri(:get, "https://example.com/indeterminant&session=na1breezaspo5qded43ka7fh",
      :body => "",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.http_request_invalid
      FakeWeb.register_uri(:get, "https://example.com/invalid&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"invalid\">
      <invalid field=\"action\" type=\"enum\" subcode=\"no-such-item\"/>
      </status>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.http_request_failure
      FakeWeb.register_uri(:get, "https://example.com/failure&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"no-data\" />
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.http_request_success
      FakeWeb.register_uri(:get, "https://example.com/success&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\" />
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.principal_update_Base_Obj
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=principal-update&account-id=1030182041&name=Base%20Obj&login=user@test.com&type=user&has-children=false&is-primary=false&is-hidden=false&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <principal is-primary=\"false\" account-id=\"1030182041\" principal-id=\"1035770400\" has-children=\"false\" type=\"user\" is-hidden=\"false\">
      <ext-login>user@test.com</ext-login>
      <name>Base Obj</name>
      <login>user@test.com</login>
      </principal>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.principal_update_Base_Obj_for_User
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=principal-update&account-id=1030182041&name=Base%20Obj&login=user@test.com&type=user&has-children=false&is-primary=false&is-hidden=false&password=password&email=user@test.com&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <principal has-children=\"false\" type=\"user\" is-hidden=\"false\" account-id=\"1030182041\" is-primary=\"false\" principal-id=\"1035814880\">
      <ext-login>user@test.com</ext-login>
      <name>Base Obj</name>
      <login>user@test.com</login>
      </principal>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.principal_update_Other_Obj_for_User
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=principal-update&principal-id=1035814880&account-id=1030182041&training-group-id=1234&name=Other%20Obj&login=other_user@test.com&has-children=true&is-primary=true&is-hidden=true&password=newpassword&email=other_user@test.com&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.principal_update_Other_Obj
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=principal-update&principal-id=1035770400&account-id=1030182041&training-group-id=1234&name=Other%20Obj&login=other_user@test.com&has-children=true&is-primary=true&is-hidden=true&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.principal_list
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=principal-list&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <principal-list>
      <principal principal-id=\"1030094617\" account-id=\"1030182041\" type=\"user\" has-children=\"false\" is-primary=\"false\" is-hidden=\"false\" training-group-id=\"\">
      <name>Ryan Moran</name>
      <login>ryan.moran@gmail.com</login>
      <email>ryan.moran@gmail.com</email>
      </principal>
      <principal principal-id=\"1030182055\" account-id=\"1030182041\" type=\"admins\" has-children=\"true\" is-primary=\"true\" is-hidden=\"false\" training-group-id=\"\">
      <name>Administrators</name>
      <login>Administrators</login>
      <description>Administrators group</description>
      </principal>
      <principal principal-id=\"1030182056\" account-id=\"1030182041\" type=\"authors\" has-children=\"true\" is-primary=\"true\" is-hidden=\"false\" training-group-id=\"\">
      <name>Authors</name>
      <login>Authors</login>
      <description>Authors group</description>
      </principal>
      <principal principal-id=\"1030182057\" account-id=\"1030182041\" type=\"live-admins\" has-children=\"true\" is-primary=\"true\" is-hidden=\"false\" training-group-id=\"\">
      <name>Meeting Hosts</name>
      <login>Meeting Hosts</login>
      <description>Meeting hosts group</description>
      </principal>
      <principal principal-id=\"1030182058\" account-id=\"1030182041\" type=\"course-admins\" has-children=\"true\" is-primary=\"true\" is-hidden=\"false\" training-group-id=\"\">
      <name>Training Managers</name>
      <login>Training Managers</login>
      <description>Training managers group</description>
      </principal>
      <principal principal-id=\"1030182059\" account-id=\"1030182041\" type=\"event-admins\" has-children=\"true\" is-primary=\"true\" is-hidden=\"false\" training-group-id=\"\">
      <name>Event Managers</name>
      <login>Event Managers</login>
      <description>Event managers group</description>
      </principal>
      <principal principal-id=\"1030182061\" account-id=\"1030182041\" type=\"learners\" has-children=\"true\" is-primary=\"true\" is-hidden=\"false\" training-group-id=\"\">
      <name>Learners</name>
      <login>Learners</login>
      <description>All learners in this account</description>
      </principal>
      <principal principal-id=\"1030182062\" account-id=\"1030182041\" type=\"admins-limited\" has-children=\"true\" is-primary=\"true\" is-hidden=\"false\" training-group-id=\"\">
      <name>Administrators - Limited</name>
      <login>Administrators - Limited</login>
      <description>Limited Administrators group</description>
      </principal>
      </principal-list>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.principal_list_filter_users
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=principal-list&filter-type=user&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <principal-list>
      <principal principal-id=\"1030094617\" account-id=\"1030182041\" type=\"user\" has-children=\"false\" is-primary=\"false\" is-hidden=\"false\" training-group-id=\"\">
      <name>Ryan Moran</name>
      <login>ryan.moran@gmail.com</login>
      <email>ryan.moran@gmail.com</email>
      </principal>
      </principal-list>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.principal_list_filter_users_empty
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=principal-list&filter-type=user&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <principal-list/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.principal_list_1035770400
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=principal-list&filter-principal-id=1035770400&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <principal-list>
      <principal principal-id=\"1035770400\" account-id=\"1030182041\" type=\"user\" has-children=\"false\" is-primary=\"false\" is-hidden=\"false\" training-group-id=\"\">
      <name>Base Obj</name>
      <login>user@test.com</login>
      </principal>
      </principal-list>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.principal_list_1030094617_for_User
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=principal-list&filter-principal-id=1030094617&filter-type=user&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <principal-list>
      <principal principal-id=\"1030094617\" account-id=\"1030182041\" type=\"user\" has-children=\"false\" is-primary=\"false\" is-hidden=\"false\" training-group-id=\"\">
      <name>Ryan Moran</name>
      <login>ryan.moran@gmail.com</login>
      <email>ryan.moran@gmail.com</email>
      </principal>
      </principal-list>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.principal_list_1030094617
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=principal-list&filter-principal-id=1030094617&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <principal-list>
      <principal principal-id=\"1030094617\" account-id=\"1030182041\" type=\"user\" has-children=\"false\" is-primary=\"false\" is-hidden=\"false\" training-group-id=\"\">
      <name>Ryan Moran</name>
      <login>ryan.moran@gmail.com</login>
      <email>ryan.moran@gmail.com</email>
      </principal>
      </principal-list>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.principal_list_1030182057
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=principal-list&filter-principal-id=1030182057&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <principal-list>
      <principal principal-id=\"1030182057\" account-id=\"1030182041\" type=\"live-admins\" has-children=\"true\" is-primary=\"true\" is-hidden=\"false\" training-group-id=\"\">
      <name>Meeting Hosts</name>
      <login>Meeting Hosts</login>
      <description>Meeting hosts group</description>
      </principal>
      </principal-list>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.principal_list_1035814880_for_User
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=principal-list&filter-principal-id=1035814880&filter-type=user&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <principal-list>
      <principal principal-id=\"1035814880\" account-id=\"1030182041\" type=\"user\" has-children=\"false\" is-primary=\"false\" is-hidden=\"false\" training-group-id=\"\">
      <name>Base Obj</name>
      <login>user@test.com</login>
      <email>user@test.com</email>
      </principal>
      </principal-list>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.principal_list_1035770400_empty
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=principal-list&filter-principal-id=1035770400&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <principal-list/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.principal_list_1035814880_for_User_empty
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=principal-list&filter-principal-id=1035814880&filter-type=user&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <principal-list/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.principal_list_members_of_1030182057
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=principal-list&filter-is-member=true&group-id=1030182057&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <principal-list>
      <principal principal-id=\"1030094617\" account-id=\"1030182041\" type=\"user\" has-children=\"false\" is-primary=\"false\" is-hidden=\"false\" training-group-id=\"\">
      <name>Ryan Moran</name>
      <login>ryan.moran@gmail.com</login>
      <email>ryan.moran@gmail.com</email>
      <is-member>true</is-member>
      </principal>
      </principal-list>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.principal_list_members_of_1030182057_1030094617
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=principal-list&filter-is-member=true&group-id=1030182057&filter-principal-id=1030094617&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <principal-list>
      <principal principal-id=\"1030094617\" account-id=\"1030182041\" type=\"user\" has-children=\"false\" is-primary=\"false\" is-hidden=\"false\" training-group-id=\"\">
      <name>Ryan Moran</name>
      <login>ryan.moran@gmail.com</login>
      <email>ryan.moran@gmail.com</email>
      <is-member>true</is-member>
      </principal>
      </principal-list>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.principals_delete_1035770400
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=principals-delete&principal-id=1035770400&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.principals_delete_1035814880
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=principals-delete&principal-id=1035814880&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.login_user
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=login&login=user@test.com&password=password",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.login_admin
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=login&login=ryan.moran@gmail.com&password=revprep123",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.login_other_user
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=login&login=other_user@test.com&password=newpassword",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"no-data\"/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.logout
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=logout&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.principal_update_Base_Obj_for_Guest
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=principal-update&account-id=1030182041&name=Base%20Obj&login=user@test.com&type=user&has-children=false&is-primary=false&is-hidden=false&password=password&email=user@test.com&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <principal has-children=\"false\" type=\"guest\" is-hidden=\"false\" account-id=\"1030182041\" is-primary=\"false\" principal-id=\"1035816176\">
      <ext-login>user@test.com</ext-login>
      <name>Base Obj</name>
      <login>user@test.com</login>
      </principal>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.principal_update_Other_Obj_for_Guest
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=principal-update&principal-id=1035816176&account-id=1030182041&training-group-id=1234&name=Other%20Obj&login=other_user@test.com&has-children=true&is-primary=true&is-hidden=true&password=newpassword&email=other_user@test.com&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.principals_delete_1035816176
      FakeWeb.register_uri(:get, "https://admin.acrobat.com/api/xml?action=principals-delete&principal-id=1035816176&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.principal_list_1035816176_for_Guest
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=principal-list&filter-principal-id=1035816176&filter-type=user&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <principal-list>
      <principal principal-id=\"1035816176\" account-id=\"1030182041\" type=\"user\" has-children=\"false\" is-primary=\"false\" is-hidden=\"false\" training-group-id=\"\">
      <name>Base Obj</name>
      <login>user@test.com</login>
      <email>user@test.com</email>
      </principal>
      </principal-list>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.principal_list_1035816176_for_Guest_empty
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=principal-list&filter-principal-id=1035816176&filter-type=user&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <principal-list/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.principal_list_filter_guests
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=principal-list&filter-type=guest&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <principal-list>
      <principal principal-id=\"1035780294\" account-id=\"1030182041\" type=\"guest\" has-children=\"false\" is-primary=\"false\" is-hidden=\"false\" training-group-id=\"\">
      <name>Other Obj</name>
      <login>other_user@test.com</login>
      <email>other_user@test.com</email>
      </principal>
      <principal principal-id=\"1035863641\" account-id=\"1030182041\" type=\"guest\" has-children=\"false\" is-primary=\"false\" is-hidden=\"false\" training-group-id=\"\">
      <name>Base Obj</name>
      <login>user@test.com</login>
      <email>user@test.com</email>
      </principal>
      </principal-list>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.principal_list_filter_guests_empty
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=principal-list&filter-type=guest&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <principal-list/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.principal_list_filter_admins
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=principal-list&filter-type=admins&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <principal-list>
      <principal principal-id=\"1030182055\" account-id=\"1030182041\" type=\"admins\" has-children=\"true\" is-primary=\"true\" is-hidden=\"false\" training-group-id=\"\">
      <name>Administrators</name>
      <login>Administrators</login>
      <description>Administrators group</description>
      </principal>
      </principal-list>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.principal_list_is_member_of_1030182055
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=principal-list&group-id=1030182055&filter-is-member=true&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <principal-list>
      <principal principal-id=\"1035814880\" account-id=\"1030182041\" type=\"user\" has-children=\"false\" is-primary=\"false\" is-hidden=\"false\" training-group-id=\"\">
      <name>Ryan Moran</name>
      <login>ryan.moran@gmail.com</login>
      <email>ryan.moran@gmail.com</email>
      <is-member>true</is-member>
      </principal>
      <principal-list>
      <principal principal-id=\"1035814880\" account-id=\"1030182041\" type=\"user\" has-children=\"false\" is-primary=\"false\" is-hidden=\"false\" training-group-id=\"\">
      <name>Base Obj</name>
      <login>user@test.com</login>
      <email>user@test.com</email>
      <is-member>true</is-member>
      </principal>
      </principal-list>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.principal_list_is_member_of_1030182055_empty
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=principal-list&group-id=1030182055&filter-is-member=true&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <principal-list/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.principal_list_is_member_of_1030182055_1035814880_empty
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=principal-list&group-id=1030182055&filter-is-member=true&filter-principal-id=1035814880&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <principal-list/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.principal_list_is_member_of_1030182055_1035814880
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=principal-list&group-id=1030182055&filter-is-member=true&filter-principal-id=1035814880&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <principal-list>
      <principal principal-id=\"1035814880\" account-id=\"1030182041\" type=\"user\" has-children=\"false\" is-primary=\"false\" is-hidden=\"false\" training-group-id=\"\">
      <name>Base Obj</name>
      <login>user@test.com</login>
      <email>user@test.com</email>
      <is-member>true</is-member>
      </principal>
      </principal-list>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.principal_list_filter_live_admins
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=principal-list&filter-type=live-admins&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <principal-list>
      <principal principal-id=\"1030182057\" account-id=\"1030182041\" type=\"live-admins\" has-children=\"true\" is-primary=\"true\" is-hidden=\"false\" training-group-id=\"\">
      <name>Meeting Hosts</name>
      <login>Meeting Hosts</login>
      <description>Meeting hosts group</description>
      </principal>
      </principal-list>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.principal_list_is_member_of_1030182057
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=principal-list&group-id=1030182057&filter-is-member=true&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <principal-list>
      <principal principal-id=\"1035814880\" account-id=\"1030182041\" type=\"user\" has-children=\"false\" is-primary=\"false\" is-hidden=\"false\" training-group-id=\"\">
      <name>Base Obj</name>
      <login>user@test.com</login>
      <email>user@test.com</email>
      <is-member>true</is-member>
      </principal>
      <principal principal-id=\"1030094617\" account-id=\"1030182041\" type=\"user\" has-children=\"false\" is-primary=\"false\" is-hidden=\"false\" training-group-id=\"\">
      <name>Ryan Moran</name>
      <login>ryan.moran@gmail.com</login>
      <email>ryan.moran@gmail.com</email>
      <is-member>true</is-member>
      </principal>
      </principal-list>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.principal_list_is_member_of_1030182057_empty
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=principal-list&group-id=1030182057&filter-is-member=true&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <principal-list/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.group_membership_update_1030182057_1035814880
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=group-membership-update&group-id=1030182057&principal-id=1035814880&is-member=true&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.principal_list_is_member_of_1030182057_1035814880
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=principal-list&group-id=1030182057&filter-is-member=true&filter-principal-id=1035814880&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <principal-list>
      <principal principal-id=\"1035814880\" account-id=\"1030182041\" type=\"user\" has-children=\"false\" is-primary=\"false\" is-hidden=\"false\" training-group-id=\"\">
      <name>Base Obj</name>
      <login>user@test.com</login>
      <email>user@test.com</email>
      <is-member>true</is-member>
      </principal>
      </principal-list>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.principal_list_is_member_of_1030182057_1035814880_empty
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=principal-list&group-id=1030182057&filter-is-member=true&filter-principal-id=1035814880&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <principal-list/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.sco_update_SCO
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-update&date-begin=2010-02-04T18:03:38-08:00&date-end=2010-02-04T19:03:38-08:00&description=this%20is%20some%20description&folder-id=1030182069&name=SCO&source-sco-id=1030182073&type=meeting&url-path=sco_path&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <sco account-id=\"1030182041\" disabled=\"\" display-seq=\"0\" folder-id=\"1030182069\" icon=\"meeting\" lang=\"en\" max-retries=\"\" sco-id=\"1036115664\" source-sco-id=\"1030182073\" type=\"meeting\" version=\"0\">
      <date-begin>2010-02-04T18:03:38.000-08:00</date-begin>
      <date-created>2010-02-23T12:08:24.700-08:00</date-created>
      <date-end>2010-02-04T19:03:38.000-08:00</date-end>
      <date-modified>2010-02-23T12:08:24.700-08:00</date-modified>
      <description>this is some description</description>
      <name>SCO</name>
      <url-path>/sco_path/</url-path>
      </sco>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.sco_update_SCO_New
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-update&sco-id=1036115664&date-begin=2010-02-04T20:03:38-08:00&date-end=2010-02-04T21:03:38-08:00&description=this%20is%20some%20new%20description&name=SCO%20New&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.sco_delete_1036115664
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-delete&sco-id=1036115664&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.sco_shortcuts
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-shortcuts&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <shortcuts>
      <sco tree-id=\"1030182044\" sco-id=\"1030182076\" type=\"shared-training-templates\">
      <domain-name>http://connectpro90536458.acrobat.com</domain-name>
      </sco>
      <sco tree-id=\"1030182048\" sco-id=\"1030182068\" type=\"my-courses\">
      <domain-name>http://connectpro90536458.acrobat.com</domain-name>
      </sco>
      <sco tree-id=\"1030182045\" sco-id=\"1030182072\" type=\"shared-meeting-templates\">
      <domain-name>http://connectpro90536458.acrobat.com</domain-name>
      </sco>
      <sco tree-id=\"1030182046\" sco-id=\"1030182070\" type=\"my-meeting-templates\">
      <domain-name>http://connectpro90536458.acrobat.com</domain-name>
      </sco>
      <sco tree-id=\"1030182046\" sco-id=\"1030182069\" type=\"my-meetings\">
      <domain-name>http://connectpro90536458.acrobat.com</domain-name>
      </sco>
      <sco tree-id=\"1030182043\" sco-id=\"1030182067\" type=\"my-content\">
      <domain-name>http://connectpro90536458.acrobat.com</domain-name>
      </sco>
      <sco tree-id=\"1030182042\" sco-id=\"1030182042\" type=\"content\">
      <domain-name>http://connectpro90536458.acrobat.com</domain-name>
      </sco>
      <sco tree-id=\"1030182044\" sco-id=\"1030182044\" type=\"courses\">
      <domain-name>http://connectpro90536458.acrobat.com</domain-name>
      </sco>
      <sco tree-id=\"1030182043\" sco-id=\"1030182043\" type=\"user-content\">
      <domain-name>http://connectpro90536458.acrobat.com</domain-name>
      </sco>
      <sco tree-id=\"1030182045\" sco-id=\"1030182045\" type=\"meetings\">
      <domain-name>http://connectpro90536458.acrobat.com</domain-name>
      </sco>
      <sco tree-id=\"1030182046\" sco-id=\"1030182046\" type=\"user-meetings\">
      <domain-name>http://connectpro90536458.acrobat.com</domain-name>
      </sco>
      <sco tree-id=\"1030182047\" sco-id=\"1030182047\" type=\"account-custom\">
      <domain-name>http://connectpro90536458.acrobat.com</domain-name>
      </sco>
      <sco tree-id=\"1030182048\" sco-id=\"1030182048\" type=\"user-courses\">
      <domain-name>http://connectpro90536458.acrobat.com</domain-name>
      </sco>
      <sco tree-id=\"1030182049\" sco-id=\"1030182049\" type=\"events\">
      <domain-name>http://connectpro90536458.acrobat.com</domain-name>
      </sco>
      <sco tree-id=\"1030182050\" sco-id=\"1030182050\" type=\"user-events\">
      <domain-name>http://connectpro90536458.acrobat.com</domain-name>
      </sco>
      <sco tree-id=\"1030182054\" sco-id=\"1030182054\" type=\"training-catalog\">
      <domain-name>http://connectpro90536458.acrobat.com</domain-name>
      </sco>
      <sco tree-id=\"1030182052\" sco-id=\"1030182052\" type=\"forced-archives\">
      <domain-name>http://connectpro90536458.acrobat.com</domain-name>
      </sco>
      <sco tree-id=\"1030182053\" sco-id=\"1030182053\" type=\"chat-transcripts\">
      <domain-name>http://connectpro90536458.acrobat.com</domain-name>
      </sco>
      </shortcuts>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.sco_contents_1030182076
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-contents&sco-id=1030182076&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <scos>
      <sco sco-id=\"1030182077\" source-sco-id=\"-8881\" folder-id=\"1030182076\" type=\"meeting\" icon=\"virtual-classroom\" display-seq=\"0\" is-folder=\"0\">
      <name>Default Virtual Classroom Template</name>
      <url-path>/defaultvirtualclassroomtemplate/</url-path>
      <date-created>2010-02-02T18:03:38.580-08:00</date-created>
      <date-modified>2010-02-02T18:03:38.580-08:00</date-modified>
      </sco>
      </scos>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.sco_contents_1030182068
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-contents&sco-id=1030182068&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <scos/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.sco_contents_1030182072
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-contents&sco-id=1030182072&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <scos>
      <sco sco-id=\"1030182075\" source-sco-id=\"-8886\" folder-id=\"1030182072\" type=\"meeting\" icon=\"meeting\" display-seq=\"0\" is-folder=\"0\">
      <name>Default Event Template</name>
      <url-path>/defaulteventtemplate/</url-path>
      <date-created>2010-02-02T18:03:38.580-08:00</date-created>
      <date-modified>2010-02-02T18:03:38.580-08:00</date-modified>
      </sco>
      <sco sco-id=\"1030182073\" source-sco-id=\"-8888\" folder-id=\"1030182072\" type=\"meeting\" icon=\"meeting\" display-seq=\"0\" is-folder=\"0\">
      <name>Default Meeting Template</name>
      <url-path>/defaultmeetingtemplate/</url-path>
      <date-created>2010-02-02T18:03:38.580-08:00</date-created>
      <date-modified>2010-02-02T18:03:38.580-08:00</date-modified>
      </sco>
      <sco sco-id=\"1030182074\" source-sco-id=\"-8887\" folder-id=\"1030182072\" type=\"meeting\" icon=\"meeting\" display-seq=\"0\" is-folder=\"0\">
      <name>Default Training Template</name>
      <url-path>/defaulttrainingtemplate/</url-path>
      <date-created>2010-02-02T18:03:38.580-08:00</date-created>
      <date-modified>2010-02-02T18:03:38.580-08:00</date-modified>
      </sco>
      </scos>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.sco_contents_1030182070
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-contents&sco-id=1030182070&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <scos/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.sco_contents_1030182069
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-contents&sco-id=1030182069&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <scos>
      <sco sco-id=\"1030182070\" source-sco-id=\"\" folder-id=\"1030182069\" type=\"folder\" icon=\"folder\" display-seq=\"0\" is-folder=\"1\">
      <name>My Templates</name>
      <url-path>/f1030182070/</url-path>
      <date-created>2010-02-02T18:03:30.023-08:00</date-created>
      <date-modified>2010-02-12T16:42:04.303-08:00</date-modified>
      </sco>
      <sco sco-id=\"1034518634\" source-sco-id=\"1030182073\" folder-id=\"1030182069\" type=\"meeting\" icon=\"meeting\" display-seq=\"0\" is-folder=\"0\">
      <name>blah blah</name>
      <url-path>/blah_blah/</url-path>
      <date-created>2010-02-17T17:01:39.110-08:00</date-created>
      <date-modified>2010-02-17T17:44:39.357-08:00</date-modified>
      </sco>
      <sco sco-id=\"1030726615\" source-sco-id=\"1030182073\" folder-id=\"1030182069\" type=\"meeting\" icon=\"meeting\" display-seq=\"0\" is-folder=\"0\">
      <name>Intro to Programming</name>
      <description>this is an intro to film</description>
      <url-path>/intro_to_film/</url-path>
      <date-begin>2010-02-04T11:30:00.000-08:00</date-begin>
      <date-end>2010-02-04T12:30:00.000-08:00</date-end>
      <date-created>2010-02-04T11:35:41.010-08:00</date-created>
      <date-modified>2010-02-17T17:26:22.300-08:00</date-modified>
      <duration>01:00:00.000</duration>
      </sco>
      <sco sco-id=\"1036115664\" source-sco-id=\"1030182073\" folder-id=\"1030182069\" type=\"meeting\" icon=\"meeting\" display-seq=\"0\" is-folder=\"0\">
      <name>SCO New</name>
      <description>this is some new description</description>
      <url-path>/sco_path/</url-path>
      <date-begin>2010-02-04T20:03:38.000-08:00</date-begin>
      <date-end>2010-02-04T21:03:38.000-08:00</date-end>
      <date-created>2010-02-23T12:08:24.700-08:00</date-created>
      <date-modified>2010-02-23T12:51:07.780-08:00</date-modified>
      <duration>01:00:00.000</duration>
      </sco>
      <sco sco-id=\"1034542690\" source-sco-id=\"1030182073\" folder-id=\"1030182069\" type=\"meeting\" icon=\"meeting\" display-seq=\"0\" is-folder=\"0\">
      <name>this is a test</name>
      <url-path>/something/</url-path>
      <date-created>2010-02-17T15:51:01.503-08:00</date-created>
      <date-modified>2010-02-17T15:51:01.503-08:00</date-modified>
      </sco>
      </scos>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.sco_contents_1030182067
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-contents&sco-id=1030182067&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <scos/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.sco_contents_1030182042
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-contents&sco-id=1030182042&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <scos/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.sco_contents_1030182044
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-contents&sco-id=1030182044&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <scos>
      <sco sco-id=\"1030182076\" source-sco-id=\"\" folder-id=\"1030182044\" type=\"folder\" icon=\"folder\" display-seq=\"0\" is-folder=\"1\">
      <name>Shared Templates</name>
      <url-path>/f1030182076/</url-path>
      <date-created>2010-02-02T18:03:38.580-08:00</date-created>
      <date-modified>2010-02-02T18:03:38.580-08:00</date-modified>
      </sco>
      </scos>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.sco_contents_1030182043
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-contents&sco-id=1030182043&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <scos>
      <sco sco-id=\"1033716516\" source-sco-id=\"\" folder-id=\"1030182043\" type=\"folder\" icon=\"folder\" display-seq=\"0\" is-folder=\"1\">
      <name>a@b.com</name>
      <url-path>/f1033716516/</url-path>
      <date-created>2010-02-15T10:30:34.053-08:00</date-created>
      <date-modified>2010-02-15T10:57:11.030-08:00</date-modified>
      </sco>
      <sco sco-id=\"1033765940\" source-sco-id=\"\" folder-id=\"1030182043\" type=\"folder\" icon=\"folder\" display-seq=\"0\" is-folder=\"1\">
      <name>host@host.com</name>
      <url-path>/f1033765940/</url-path>
      <date-created>2010-02-15T11:33:03.947-08:00</date-created>
      <date-modified>2010-02-15T11:40:51.590-08:00</date-modified>
      </sco>
      <sco sco-id=\"1033792235\" source-sco-id=\"\" folder-id=\"1030182043\" type=\"folder\" icon=\"folder\" display-seq=\"0\" is-folder=\"1\">
      <name>host@test.com</name>
      <url-path>/f1033792235/</url-path>
      <date-created>2010-02-15T10:42:41.557-08:00</date-created>
      <date-modified>2010-02-17T15:36:36.717-08:00</date-modified>
      </sco>
      <sco sco-id=\"1032225488\" source-sco-id=\"\" folder-id=\"1030182043\" type=\"folder\" icon=\"folder\" display-seq=\"0\" is-folder=\"1\">
      <name>host1@revolutionprep.com</name>
      <url-path>/f1032225488/</url-path>
      <date-created>2010-02-09T16:13:56.300-08:00</date-created>
      <date-modified>2010-02-09T16:13:56.300-08:00</date-modified>
      </sco>
      <sco sco-id=\"1032225508\" source-sco-id=\"\" folder-id=\"1030182043\" type=\"folder\" icon=\"folder\" display-seq=\"0\" is-folder=\"1\">
      <name>host2@revolutionprep.com</name>
      <url-path>/f1032225508/</url-path>
      <date-created>2010-02-09T16:14:58.210-08:00</date-created>
      <date-modified>2010-02-15T10:28:58.827-08:00</date-modified>
      </sco>
      <sco sco-id=\"1030182067\" source-sco-id=\"\" folder-id=\"1030182043\" type=\"folder\" icon=\"folder\" display-seq=\"0\" is-folder=\"1\">
      <name>ryan.moran@gmail.com</name>
      <url-path>/f1030182067/</url-path>
      <date-created>2010-02-02T18:03:30.023-08:00</date-created>
      <date-modified>2010-02-02T18:03:30.023-08:00</date-modified>
      </sco>
      <sco sco-id=\"1036041619\" source-sco-id=\"\" folder-id=\"1030182043\" type=\"folder\" icon=\"folder\" display-seq=\"0\" is-folder=\"1\">
      <name>someuser@test.com</name>
      <url-path>/f1036041619/</url-path>
      <date-created>2010-02-23T10:53:53.353-08:00</date-created>
      <date-modified>2010-02-23T10:53:53.353-08:00</date-modified>
      </sco>
      <sco sco-id=\"1036095929\" source-sco-id=\"\" folder-id=\"1030182043\" type=\"folder\" icon=\"folder\" display-seq=\"0\" is-folder=\"1\">
      <name>user@test.com</name>
      <url-path>/f1036095929/</url-path>
      <date-created>2010-02-23T11:15:11.390-08:00</date-created>
      <date-modified>2010-02-23T11:15:11.390-08:00</date-modified>
      </sco>
      </scos>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.sco_contents_1030182045
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-contents&sco-id=1030182045&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <scos>
      <sco sco-id=\"1030182072\" source-sco-id=\"\" folder-id=\"1030182045\" type=\"folder\" icon=\"folder\" display-seq=\"0\" is-folder=\"1\">
      <name>Shared Templates</name>
      <url-path>/f1030182072/</url-path>
      <date-created>2010-02-02T18:03:38.580-08:00</date-created>
      <date-modified>2010-02-02T18:03:38.580-08:00</date-modified>
      </sco>
      </scos>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.sco_contents_1030182046
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-contents&sco-id=1030182046&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <scos>
      <sco sco-id=\"1033716517\" source-sco-id=\"\" folder-id=\"1030182046\" type=\"folder\" icon=\"folder\" display-seq=\"0\" is-folder=\"1\">
      <name>a@b.com</name>
      <url-path>/f1033716517/</url-path>
      <date-created>2010-02-15T10:30:34.053-08:00</date-created>
      <date-modified>2010-02-15T10:57:11.030-08:00</date-modified>
      </sco>
      <sco sco-id=\"1033765941\" source-sco-id=\"\" folder-id=\"1030182046\" type=\"folder\" icon=\"folder\" display-seq=\"0\" is-folder=\"1\">
      <name>host@host.com</name>
      <url-path>/f1033765941/</url-path>
      <date-created>2010-02-15T11:33:03.947-08:00</date-created>
      <date-modified>2010-02-15T11:40:51.590-08:00</date-modified>
      </sco>
      <sco sco-id=\"1033792236\" source-sco-id=\"\" folder-id=\"1030182046\" type=\"folder\" icon=\"folder\" display-seq=\"0\" is-folder=\"1\">
      <name>host@test.com</name>
      <url-path>/f1033792236/</url-path>
      <date-created>2010-02-15T10:42:41.557-08:00</date-created>
      <date-modified>2010-02-17T15:36:36.717-08:00</date-modified>
      </sco>
      <sco sco-id=\"1032225489\" source-sco-id=\"\" folder-id=\"1030182046\" type=\"folder\" icon=\"folder\" display-seq=\"0\" is-folder=\"1\">
      <name>host1@revolutionprep.com</name>
      <url-path>/f1032225489/</url-path>
      <date-created>2010-02-09T16:13:56.300-08:00</date-created>
      <date-modified>2010-02-09T16:13:56.300-08:00</date-modified>
      </sco>
      <sco sco-id=\"1032225509\" source-sco-id=\"\" folder-id=\"1030182046\" type=\"folder\" icon=\"folder\" display-seq=\"0\" is-folder=\"1\">
      <name>host2@revolutionprep.com</name>
      <url-path>/f1032225509/</url-path>
      <date-created>2010-02-09T16:14:58.210-08:00</date-created>
      <date-modified>2010-02-15T10:28:58.827-08:00</date-modified>
      </sco>
      <sco sco-id=\"1030182069\" source-sco-id=\"\" folder-id=\"1030182046\" type=\"folder\" icon=\"folder\" display-seq=\"0\" is-folder=\"1\">
      <name>ryan.moran@gmail.com</name>
      <url-path>/f1030182069/</url-path>
      <date-created>2010-02-02T18:03:30.023-08:00</date-created>
      <date-modified>2010-02-12T16:42:04.303-08:00</date-modified>
      </sco>
      <sco sco-id=\"1036041620\" source-sco-id=\"\" folder-id=\"1030182046\" type=\"folder\" icon=\"folder\" display-seq=\"0\" is-folder=\"1\">
      <name>someuser@test.com</name>
      <url-path>/f1036041620/</url-path>
      <date-created>2010-02-23T10:53:53.353-08:00</date-created>
      <date-modified>2010-02-23T10:53:53.353-08:00</date-modified>
      </sco>
      <sco sco-id=\"1036095930\" source-sco-id=\"\" folder-id=\"1030182046\" type=\"folder\" icon=\"folder\" display-seq=\"0\" is-folder=\"1\">
      <name>user@test.com</name>
      <url-path>/f1036095930/</url-path>
      <date-created>2010-02-23T11:15:11.390-08:00</date-created>
      <date-modified>2010-02-23T11:15:11.390-08:00</date-modified>
      </sco>
      </scos>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.sco_contents_1030182047
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-contents&sco-id=1030182047&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <scos/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.sco_contents_1030182048
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-contents&sco-id=1030182048&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <scos>
      <sco sco-id=\"1030182068\" source-sco-id=\"\" folder-id=\"1030182048\" type=\"folder\" icon=\"folder\" display-seq=\"0\" is-folder=\"1\">
      <name>ryan.moran@gmail.com</name>
      <url-path>/f1030182068/</url-path>
      <date-created>2010-02-02T18:03:30.023-08:00</date-created>
      <date-modified>2010-02-02T18:03:30.023-08:00</date-modified>
      </sco>
      </scos>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.sco_contents_1030182049
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-contents&sco-id=1030182049&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <scos/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.sco_contents_1030182050
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-contents&sco-id=1030182050&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <scos/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.sco_contents_1030182054
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-contents&sco-id=1030182054&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <scos/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.sco_contents_1030182052
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-contents&sco-id=1030182052&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <scos/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.sco_contents_1030182053
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-contents&sco-id=1030182053&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <scos/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.sco_contents_1030182076_empty
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-contents&sco-id=1030182076&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <scos/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.sco_contents_1030182068_empty
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-contents&sco-id=1030182068&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <scos/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.sco_contents_1030182072_empty
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-contents&sco-id=1030182072&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <scos/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.sco_contents_1030182070_empty
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-contents&sco-id=1030182070&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <scos/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.sco_contents_1030182069_empty
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-contents&sco-id=1030182069&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <scos/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.sco_contents_1030182067_empty
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-contents&sco-id=1030182067&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <scos/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.sco_contents_1030182042_empty
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-contents&sco-id=1030182042&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <scos/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.sco_contents_1030182044_empty
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-contents&sco-id=1030182044&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <scos/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.sco_contents_1030182043_empty
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-contents&sco-id=1030182043&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <scos/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.sco_contents_1030182045_empty
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-contents&sco-id=1030182045&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <scos/>
      </scos>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.sco_contents_1030182046_empty
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-contents&sco-id=1030182046&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <scos/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.sco_contents_1030182047_empty
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-contents&sco-id=1030182047&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <scos/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.sco_contents_1030182048_empty
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-contents&sco-id=1030182048&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <scos/>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.sco_contents_1030182049_empty
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-contents&sco-id=1030182049&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <scos/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.sco_contents_1030182050_empty
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-contents&sco-id=1030182050&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <scos/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.sco_contents_1030182054_empty
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-contents&sco-id=1030182054&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <scos/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.sco_contents_1030182052_empty
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-contents&sco-id=1030182052&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <scos/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.sco_contents_1030182053_empty
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-contents&sco-id=1030182053&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <scos/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.sco_info_12345
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-info&sco-id=12345&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"no-data\"/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.sco_info_1030726615
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-info&sco-id=1030726615&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <sco account-id=\"1030182041\" disabled=\"\" display-seq=\"0\" folder-id=\"1030182069\" icon=\"meeting\" lang=\"en\" max-retries=\"\" sco-id=\"1030726615\" source-sco-id=\"1030182073\" type=\"meeting\" version=\"1\">
      <date-begin>2010-02-04T11:30:00.000-08:00</date-begin>
      <date-created>2010-02-04T11:35:41.010-08:00</date-created>
      <date-end>2010-02-04T12:30:00.000-08:00</date-end>
      <date-modified>2010-02-17T17:26:22.300-08:00</date-modified>
      <description>this is an intro to film</description>
      <name>Intro to Programming</name>
      <url-path>/intro_to_film/</url-path>
      <update-linked-item>true</update-linked-item>
      </sco>
      <source-sco>
      <source-sco account-id=\"1030182041\" disabled=\"\" display-seq=\"0\" folder-id=\"1030182072\" icon=\"meeting\" lang=\"en\" max-retries=\"\" sco-id=\"1030182073\" source-sco-id=\"-8888\" type=\"meeting\" version=\"0\">
      <date-created>2010-02-02T18:03:38.580-08:00</date-created>
      <date-modified>2010-02-02T18:03:38.580-08:00</date-modified>
      <name>Default Meeting Template</name>
      <url-path>/defaultmeetingtemplate/</url-path>
      </source-sco>
      </source-sco>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.sco_update_TEMPLATE
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-update&date-begin=2010-02-04T18:03:38-08:00&date-end=2010-02-04T19:03:38-08:00&description=this%20is%20some%20description&folder-id=1030182072&name=TEMPLATE&source-sco-id=1030182073&type=meeting&url-path=sco_template_path&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <sco account-id=\"1030182041\" disabled=\"\" display-seq=\"0\" folder-id=\"1030182072\" icon=\"meeting\" lang=\"en\" max-retries=\"\" sco-id=\"1037064220\" source-sco-id=\"1030182073\" type=\"meeting\" version=\"0\">
      <date-begin>2010-02-04T18:03:38.000-08:00</date-begin>
      <date-created>2010-02-25T11:16:29.010-08:00</date-created>
      <date-end>2010-02-04T19:03:38.000-08:00</date-end>
      <date-modified>2010-02-25T11:16:29.010-08:00</date-modified>
      <description>this is some description</description>
      <name>TEMPLATE</name>
      <url-path>/sco_template_path/</url-path>
      </sco>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.sco_update_TEMPLATE_New
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-update&sco-id=1037064220&date-begin=2010-02-04T20:03:38-08:00&date-end=2010-02-04T21:03:38-08:00&description=this%20is%20some%20new%20description&name=TEMPLATE%20New&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.sco_delete_1037064220
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-delete&sco-id=1037064220&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.permissions_update_1036115664_1035814880
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=permissions-update&acl-id=1036115664&principal-id=1035814880&permission-id=host&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

    def self.permissions_info_1036115664_1035814880
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=permissions-info&acl-id=1036115664&principal-id=1035814880&session=na1breezaspo5qded43ka7fh",
      :body => "<?xml version=\"1.0\" encoding=\"utf-8\"?>
      <results>
      <status code=\"ok\"/>
      <permission acl-id=\"1036115664\" permission-id=\"host\" principal-id=\"1035814880\"/>
      </results>",
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end
    
    def self.permissions_update_1037064220_public_access
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=permissions-update&acl-id=1037064220&principal-id=public-access&permission-id=denied&session=na1breezaspo5qded43ka7fh",
      :body => %Q{ <?xml version="1.0" encoding="utf-8"?>
      <results><status code="ok"/></results> },
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end
    
    def self.permissions_update_1036115664_public_access
      FakeWeb.register_uri(:get, "https://" + KOKOPELLI[:domain] + "/api/xml?action=permissions-update&acl-id=1036115664&principal-id=public-access&permission-id=denied&session=na1breezaspo5qded43ka7fh",
      :body => %Q{ <?xml version="1.0" encoding="utf-8"?>
      <results><status code="ok"/></results> },
      :set_cookie => "BREEZESESSION=na1breezaspo5qded43ka7fh;HttpOnly;domain=.acrobat.com;path=/")
    end

  end
end