# guard-sync3r

Sync3r is a simple guard library that syncs local directories with S3 as files are changed. 

# Usage

This is a sample Guardfile

    opts = {
      :access_key_id      => 'ACCESS_KEY_ID_XXXXXX',
      :secret_access_key  => 'SECRET_ACCESS_KEY_XXXXXXXXXXXXXXXXXXXXXX',
      :bucket             => "mybucket",
      :s3_permissions     => :public_read,          
      :debug              => true
    }
    
    guard 'sync3r', opts do
      watch(/.*/)
    end
    

# Dependencies

 - guard
 - aws-s3