terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    config = {
      source  = "alabuel/config"
      version = "0.2.8"
    }
  }
}



# data "aws_eip" "elastic-ip" {
#   id = data.external.config[0].result.publicIPId0
# }

data "external" "config" {
  program = ["pwsh", "./AWS_Preparation.ps1"]
  query = merge({for key,value in local.ini_map[local.name] : key => value}, { inifile = var.iniFile})
  count = (var.uag_count > 0 && fileexists(var.inputs)) ? 1 : 0
}

data "config_ini" "sensitive_ini" {
  ini = file(var.inputs)
}

locals {
  name     = var.uag_name
  count    = var.uag_count
  uagArray = {for i in range(1, local.count+1) : format("%s%d", local.name, i) => i}

  ini_map = jsondecode(data.config_ini.sensitive_ini.json)
}


# Associate existing Elastic IPs with the corresponding NIC
# resource "aws_eip_association" "eip_assoc" {
#   for_each           = aws_instance.uag-aws
#   network_interface_id        = aws_network_interface.nic0[0].id
#   allocation_id      = data.aws_eip.elastic-ip.id # Associate each instance with the correct EIP
# }


# Network Interface 0 (No private IP assigned, will use DHCP)
resource "aws_network_interface" "nic0" {
  subnet_id       = data.external.config[0].result.subnetId0
  security_groups = [data.external.config[0].result.securityGroupId0]

  tags = {
    Name = "nic0"
  }
  count = data.external.config[0].result.subnetId0 == "" ? 0 : 1
}

# Network Interface 1 (No private IP assigned, will use DHCP)
resource "aws_network_interface" "nic1" {
  subnet_id       = data.external.config[0].result.subnetId1
  security_groups = [data.external.config[0].result.securityGroupId0]

  tags = {
    Name = "nic1"
  }
  count = data.external.config[0].result.subnetId1 == "" ? 0 : 1
}

# Network Interface 2 (No private IP assigned, will use DHCP)
resource "aws_network_interface" "nic2" {
  subnet_id       = data.external.config[0].result.subnetId2
  security_groups = [data.external.config[0].result.securityGroupId0]

  tags = {
    Name = "nic2"
  }
  count = data.external.config[0].result.subnetId2 == "" ? 0 : 1
}


# Create a EC2 instance
resource "aws_instance" "uag-aws" {
  for_each = local.uagArray
  ami           = data.external.config[0].result.amiID
  tags = {
  Name = each.key
  }
  instance_type = data.external.config[0].result.instanceType
  user_data_base64 = data.external.config[0].result.userData

  # Dynamic block for NIC 1
  dynamic "network_interface" {
    for_each = aws_network_interface.nic0.*.id
    content {
      network_interface_id = network_interface.value
      device_index         = 0
    }
  }

  # Dynamic block for NIC 2
  dynamic "network_interface" {
    for_each = aws_network_interface.nic1.*.id
    content {
      network_interface_id = network_interface.value
      device_index         = 1
    }
  }

  # Dynamic block for NIC 3
  dynamic "network_interface" {
    for_each = aws_network_interface.nic2.*.id
    content {
      network_interface_id = network_interface.value
      device_index         = 2
    }
  }
}


# Output the instance's public IP
# output "instance_ip" {
#   value = aws_instance.uag-aws[*].public_ip
# }

# output "instance_ip" {
#   value = aws_eip_association.eip_assoc[*].public_ip  # Use EIP public IP
# }

output "powershell_script" {
  value = data.external.config[0].result.output
}