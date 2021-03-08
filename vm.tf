resource "ah_cloud_server" "example" {
  count      = 4
  name       = "U20-${count.index}"
  datacenter = var.ah_dc
  image      = var.ah_image_type
  product    = var.ah_machine_type
  use_password = var.use_password
  ssh_keys   = ["YOUR FINGERPRINT"]
}

resource "ah_private_network" "example" {
  ip_range = "192.168.1.0/24"
  name = "LAN for cluster1"
  depends_on = [
    ah_cloud_server.example,
  ]
}

resource "ah_private_network_connection" "example" {
  count = 4
  cloud_server_id = ah_cloud_server.example[count.index].id
  private_network_id = ah_private_network.example.id
  ip_address = "192.168.1.${count.index+10}"
  depends_on = [
    ah_cloud_server.example,
    ah_private_network.example
  ]
}