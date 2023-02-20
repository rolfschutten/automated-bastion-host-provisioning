variable "ServiceName" {
  type     = string
  description = "The name of all resources referring to the service name."
  default = "bstsnooze"
}
variable "Location" {
  type    = string
  description = "Resource location"
  default = "westeurope"
}
variable "EnvironmentPrefix" {
  type     = string
  description = "The prefix of all resources referring to environment type. Choose p for production, t for testing and a for acceptance. Only 1 character."
  default = "t"
}
variable "VNetPrefixSecondOctet" {
  type     = number
  description = "The second octet IP address space. For example: if you need a address space of 172.20.8.0/22, choose 20."
  default = 17
}
variable "VNetPrefixThirdOctet" {
  type     = number
  description = "The third octet IP address space. For example: if you need a address space of 172.20.8.0/22, choose 8."
  default = 12
}
variable "Timezone" {
  type     = string
  description = "The timezone in which the Azure Function acts and uses for its time schedule."
  default = "W. Europe Standard Time"
}
variable "CreateSchedule" {
  type     = string
  description = "Schedule for creating the Bastion Host (NCRONTAB expression). {second} {minute} {hour} {day} {month} {day-of-week}"
  default = "0 30 8 * * 1-5"
}
variable "DeleteSchedule" {
  type     = string
  description = "Schedule for deleting the Bastion Host (NCRONTAB expression). {second} {minute} {hour} {day} {month} {day-of-week}"
  default = "0 0 18 * * 1-5"
}