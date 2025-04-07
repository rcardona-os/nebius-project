variable "cloud_id"    {}
variable "folder_id"   {}
variable "token"       {}
variable "image_id"    {}
variable "subnet_id"   {}


    private_key_file_env = "~/.ssh/id_rsa.pub"
    public_key_id_env    = "NB_AUTHKEY_PUBLIC_ID"
    account_id_env       = "NB_SA_ID"