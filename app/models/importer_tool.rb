class ImporterTool < ActiveRecord::Base
  class << self

    def find_contact_hash_from(current_user_id, import_source, import_hash )
      puts "find contact hash"
      if import_source == "custom"
        custom_contact_hash(current_user_id, import_hash)
      elsif import_source == "google"
        google_contact_hash(current_user_id, import_hash)
      end
    end

    def find_address_hash_from(current_user_id, import_source, import_hash, address_kind)
      puts "find_address_hash_from source #{import_source} "

      if import_source == "custom"

        us_state = USState.find_by_code(import_hash["state_code"])
        us_state_id = us_state.id unless us_state.blank?
        country_code = "US" #refactor
        country = Country.find_by_code(country_code) || Country.find_by_code("US")
        custom_address_hash(current_user_id, import_hash,address_kind, us_state, country)

      # elsif import_source == "google"


      # elsif address_kind == "work"
      # end
      elsif import_source == "apple"

      elsif import_source == "outlook"
      end
    end

    def add_google_addresses(current_user_id, import_hash, contact)
         puts 'trying google addresses' * 1000
         address_sequence_headers = 
          [ "Address 1", 
            "Address 2", 
            "Address 3"
          ]
      address_sequence_headers.each do |address_sequence_header|
        if  import_hash["#{address_sequence_header} - Formatted"].present?
          if import_hash["#{address_sequence_header} - Type"].present?
            address_kind = import_hash["#{address_sequence_header} - Type"]
          else
            address_kind = "Home"
          end  
            us_state = USState.find_by_code(import_hash["#{address_sequence_header} - Region"])
            us_state_id = us_state.id unless us_state.blank?
            country_name = import_hash["#{address_sequence_header} - Country"] || "United States"#refactor
            country_code = CountryCode.find_code(country_name) unless country_name.blank?
            country = Country.find_by_code(country_code) 
            country_id = country.id  unless country.blank?
            google_address_hash = {
            title: address_kind.titleize,
            address_1: import_hash["#{address_sequence_header} - Street"],
            # address_2:  import_hash["#{address_sequence_header} - Street"],
            city:  import_hash["#{address_sequence_header} - City"],
            us_state_id: us_state_id,
            postal_code:  import_hash["#{address_sequence_header} - Postal Code"],
            country_id: country_id  ,
            editor_user_id: current_user_id,
            importer_user_id:current_user_id,
            owner_id: contact.id,
            owner_type: "Contact"
          }
          address = Address.create!(google_address_hash)
          address.update_attributes!(primary: true) if address.title == "Home"

          puts 'added google addresses' * 1000
        end
      end
    end



  # First Name,Middle Name,Last Name,Title,Suffix,Initials,Web Page,Gender,Birthday,Anniversary,Location,Language,Internet Free Busy,Notes,
  #       E-mail Address,E-mail 2 Address,E-mail 3 Address,Primary 
  #       Phone,Home Phone,Home Phone 2,Mobile Phone,Pager,Home Fax,Home Address,Home Street,Home Street 2,Home Street 3,Home Address PO Box,Home City,Home State,Home Postal Code,Home Country,Spou

   def custom_contact_hash(current_user_id, import_hash)
      puts "custom_contact_hash "

      {
        first_name: import_hash["First Name"],
        last_name: import_hash["Last Name"],
        email: import_hash["email"],
        primary_phone: import_hash["home_phone"] || import_hash["mobile_phone"],
        mobile_phone: import_hash["mobile_phone"],
        home_phone: import_hash["home_phone"],
        url: import_hash["url"],
        importer_user_id: current_user_id,
        editor_user_id: current_user_id,
        status: "approved"
      }
   end

   def google_contact_hash(current_user_id, import_hash)
          puts "google_contact_hash "

         {
            first_name: import_hash["Given Name"],
            middle_name: import_hash["Additional Name"],
            last_name: import_hash["Family Name"],
            prefix: import_hash["Name Prefix"],
            suffix: import_hash["Name Suffix"],
            nickname: import_hash["Nickname"],
            url: import_hash["Web Page"],
            gender: import_hash["Gender"],
            birthday: import_hash["Birthday"],
            email: import_hash["E-mail 1 - Value"],
            note: import_hash["Notes"],
            primary_phone: import_hash["Phone 1 - Value"] || import_hash["Phone 1 - Value"],
            # mobile_phone: import_hash["Mobile Phone"],
            # home_phone: import_hash["Home Phone"],
            importer_user_id: current_user_id,
            editor_user_id: current_user_id,
            status: "approved"

          }
   end

    # def convert_google_address(import_hash, current_user_id, contact)

    #     # us_state = USState.find_by_code(import_hash["#{address_kind.titleize} State"])
    #     # puts "#{us_state}" * 1000
    #     # us_state_id = us_state.id unless us_state.blank?
    #     # country_code = "US" #refactor
    #     # country = Country.find_by_code(country_code) || Country.find_by_code("US")
    #     # google_address_hash(current_user_id, import_hash, address_kind, us_state_id, country)
    #     address_sequence_headers = 
    #       [ "Address 1", 
    #         "Address 2", 
    #         "Address 3"
    #       ]
    #     address_sequence_headers.each do |address_sequence_header|
    #     if  import_hash["#{address_sequence_header} - Formatted"].present?
    #       if import_hash["#{address_sequence_header} - Formatted"].present?
    #         address_kind = import_hash["#{address_sequence_header} - Type"]
    #       else
    #         address_kind = "Home"
    #       end  
    #         us_state = USState.find_by_code(import_hash["#{address_sequence_header} - Region"])
    #         us_state_id = us_state.id unless us_state.blank?
    #         country_name = import_hash["#{address_sequence_header} - Country"] || "United States"#refactor
    #         country = Country.find_by_name(country_name) 

    #         google_address_hash = {
    #         title: address_kind.titleize,
    #         address_1: import_hash["#{address_sequence_header} - Street"],
    #         # address_2:  import_hash["#{address_sequence_header} - Street"],
    #         city:  import_hash["#{address_sequence_header} - City"],
    #         us_state_id: us_state_id,
    #         postal_code:  import_hash["#{address_sequence_header} - Postal Code"],
    #         country_id: country.id,
    #         editor_user_id: current_user_id,
    #         importer_user_id:current_user_id,
    #         owner_id: contact.id
    #       }
    #       Address.create!(google_address_hash)
        
    #     end
    # end

    # def google_address_hash(current_user_id, import_hash, address_kind, us_state_id, country)
    #      {
    #       title: address_kind.titleize,
    #       address_1: import_hash["#{address_kind.titleize} Street"],
    #       address_2:  import_hash["#{address_kind.titleize} Street 2"],
    #       city:  import_hash["#{address_kind.titleize} City"],
    #       us_state_id: us_state_id,
    #       postal_code:  import_hash["#{address_kind.titleize} Postal Code"],
    #       country_id: country.id,
    #       editor_user_id: current_user_id,
    #       importer_user_id: current_user_id
    #       }
    # end

    def custom_address_hash(current_user_id, import_hash, address_kind, us_state_id, country)
         {
          title: address_kind.titleize,
          address_1: import_hash["address_1"],
          address_2:  import_hash["address_2"],
          city:  import_hash["city"],
          us_state_id: us_state_id,
          postal_code:  import_hash["postal_code"],
          country_id: country.id,
          editor_user_id: current_user_id,
          importer_user_id:current_user_id
          }
    end
  end
end
