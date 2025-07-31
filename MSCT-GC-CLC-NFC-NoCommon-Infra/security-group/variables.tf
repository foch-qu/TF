variable "vpc_id_nfc" {}

#variable "vpc_id_hkdc" {}


variable "tags_default" {
  type = map(string)
  default = {


    "Application" = "CLC-NFC"                      #application name
    "Project" = "CLC-NFC"                            #project name
    "Environment" = "nonprod"                    #environment e.g. Deplyoment
    "ContactEmail" = ""
  }
}