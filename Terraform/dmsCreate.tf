resource "aws_dms_replication_subnet_group" "fp-dms-subnetgroup" {
    replication_subnet_group_description = "final project replication dms subnet group"
    replication_subnet_group_id = "fp-dms-subnet-group"

    subnet_ids = [
        aws_subnet.fp-DB-Private-Subnet-01.id,
        aws_subnet.fp-DB-Private-Subnet-02.id
    ]
    

    tags = {
      Name = "fp-dms-subnet-group"
    }

    depends_on = [ aws_iam_role_policy_attachment.dms-vpc-role ]
  
}


resource "aws_dms_replication_instance" "fp-dms-instance" {
    replication_instance_class = "dms.t3.medium"
    replication_instance_id = "fpdmsinstance"
    multi_az = false
    network_type = "IPV4"
    publicly_accessible = true
    replication_subnet_group_id = aws_dms_replication_subnet_group.fp-dms-subnetgroup.id
    vpc_security_group_ids = [ aws_security_group.fp-test.id ]
  
}


resource "aws_dms_endpoint" "onpremise-mongodb-endpoint" {
  endpoint_type = "source"
  engine_name = "mongodb"
  endpoint_id = "ongodb-endpoint"
  server_name = "172.24.0.61"
  port = "27017"
  username = "admin"
  password = "VMware1!"
  mongodb_settings {
    
  }
  tags = {
    Name = "ongodb-endpoint"
  }
}




resource "aws_dms_endpoint" "documentDB-endpoint" {
  endpoint_type = "target"
  engine_name = "docdb"
  endpoint_id = "docdb-endpoint"
  server_name = aws_docdb_cluster.fp-documentDB-Cluster.endpoint
  username = "AdminDB"
  password = "VMware1!"
  port = "27017"
  database_name = "fp-documentdb-cluster"
  tags = {
    Name = "docdb-endpoint"
  }
  
}
