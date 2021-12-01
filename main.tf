# You take a template file and pass variables values into it
data "template_file" "config" {
  template = "templates/my_config.json"

  vars = {
    hostname = aws_instance.db_instance.private_dns
  }
}

# Now your may use this rendered template whenever you wish
# For example to save it on S3 or add it as the user_data
# to EC2-instance
resource "aws_s3_bucket_object" "config" {
  bucket  = "my-super-duper-bucket"
  key     = "conf/my-service/config.json"
  content = data.template_file.config.rendered
