=begin

My best attempt to use v2 of the AWS API seems verbose, and I suspect
there is a more compact way to perform basic operations like deleting
everything from a bucket and copying all the contents of a bucket.

=end

require 'fileutils'

namespace :storage do

  namespace :delete do

    task all: :environment do

      case Rails.configuration.carrierwave_storage
      when :fog
        s3_client = Aws::S3::Client.new({region:'us-east-1'})
        objects = s3_client.
          list_objects(bucket: Rails.configuration.s3_bucket).
          contents.
          map{|b|{key: b.key}}
        s3_client.delete_objects(
           bucket: Rails.configuration.s3_bucket,
           delete: { objects: objects }
         ) if objects.any?
      when :file
        FileUtils.rm_rf(Rails.root.join('public','uploads'))
      end
    end
  end


  namespace :copy do

    task prod: :'storage:delete:all' do
      s3_client = Aws::S3::Client.new({region:'us-east-1'})
      s3_client.
        list_objects(bucket: 'oct-prod').
        contents.
        map(&:key).
        reject{|b|b[-1]=='/'}.
        each do |key|
          print "Copying #{key}... "
          s3_client.copy_object(
            bucket: Rails.configuration.s3_bucket,
            copy_source: 'oct-prod/' + key,
            key: key,
            acl: 'public-read'
          )
          puts "Done"
        end
    end

  end


end
