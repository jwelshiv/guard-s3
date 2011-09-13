begin
  require 'aws/s3'
rescue LoadError => e
  e.message << " (You may need to install the aws-s3 gem)"
  raise e
end unless defined?(AWS::S3)

require 'guard'
require 'guard/guard'

module ::Guard
  class Sync3r < Guard
    include AWS::S3
    
    attr_reader :s3_connection, :pwd

    def initialize(watchers = [], options = {})
      super
      @s3_connection = Base.establish_connection!(
        :access_key_id  => options[:access_key_id]
        :secret_access_key => options[:secret_access_key]
      )
      @bucket         = options[:bucket]
      @s3_permissions = :public_read
      @debug          = true
      @pwd            = Dir.pwd
      
      log "Initialized with watchers = #{watchers.inspect}"
    end
    
    def start
      
    end
    
    def stop
      true
    end
    
    def reload
      stop
      start
    end
    
    def run_all
      true
    end
       
    def run_on_change(paths)
      paths.each do |path|
        log path.inspect
        file  = File.join(pwd, path)
        
        begin
          if exists?(file)
            log "Nothing uploaded. #{file} already exists!"
          else
            log "Syncing #{path}"
            S3Object.store(path, open(file), @bucket) 
            #S3Object.store(file, open(file), @bucket, {:content_type => file.content_type.to_s.strip, :access => @s3_permissions}) 
          end
          
        rescue Exception => e
          log e.message
        end

      end
    end
    
    def exists?(filename)
      if filename
        AWS::S3::S3Object.exists?(filename, @bucket)
      else
        false
      end
    end

    private

    def debug?
      @debug || false
    end

    def log(msg)
      return unless debug?
      puts "[#{Time.now}] #{msg}"
    end

  end
end
