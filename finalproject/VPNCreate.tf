resource "aws_customer_gateway" "fp-CGW" {
    bgp_asn = 65000
    ip_address = "175.196.82.2"
    type = "ipsec.1"

    tags = {
      Name = "fp-CGW"
    }
}

resource "aws_vpn_gateway" "fp-VPG" {
    vpc_id = aws_vpc.fp-VPC.id
    tags = {
      Name = "fp-VPG"
    }
}

resource "aws_vpn_gateway_attachment" "fp-VPG-connection" {
    vpc_id = aws_vpc.fp-VPC.id
    vpn_gateway_id = aws_vpn_gateway.fp-VPG.id
}


resource "aws_vpn_connection" "fp-VPN-connection" {
    customer_gateway_id = aws_customer_gateway.fp-CGW.id
    vpn_gateway_id = aws_vpn_gateway.fp-VPG.id
    local_ipv4_network_cidr = "172.24.0.0/24"
    remote_ipv4_network_cidr = "10.10.0.0/16"
    static_routes_only = true

    tunnel1_preshared_key = "testkeys"
    tunnel2_preshared_key = "testkeys"

    type = "ipsec.1"

    tags = {
      Name = "fp-SiteToSite-VPN-Connection"
    }
}

resource "aws_vpn_connection_route" "fp-VPN-connection-route" {
    vpn_connection_id = aws_vpn_connection.fp-VPN-connection.id
    destination_cidr_block = "172.24.0.0/24"
  
}

resource "aws_vpn_gateway_route_propagation" "fp-vpn-propagation-public-rt" {
  vpn_gateway_id = aws_vpn_gateway.fp-VPG.id
  route_table_id = aws_route_table.fp-Public-routingtable.id
}

resource "aws_vpn_gateway_route_propagation" "fp-vpn-propagation-privat-rt" {
  vpn_gateway_id = aws_vpn_gateway.fp-VPG.id
  route_table_id = aws_route_table.fp-Private-routingtable.id
}