
resource "aws_docdb_subnet_group" "fp-documentDB-subnetGroup" {
    name = "documentdb-subnetgroup"
    subnet_ids = [ aws_subnet.fp-DB-Private-Subnet-01.id, aws_subnet.fp-DB-Private-Subnet-02.id ]

    tags = {
      Name = "fp-documentDB-SubnetGroup"
    }
  
}

resource "aws_docdb_cluster_instance" "fp-documentDB-instance" {
    count = 3
    cluster_identifier = aws_docdb_cluster.fp-documentDB-Cluster.id
    instance_class = "db.t3.medium"
  
}



resource "aws_docdb_cluster" "fp-documentDB-Cluster" {
    cluster_identifier = "fp-documentdb-cluster"
    availability_zones = [ "ap-northeast-1a", "ap-northeast-1c" ]
    storage_type = "standard"
    engine = "docdb"
    vpc_security_group_ids = [ aws_security_group.fp-test.id ]
    db_subnet_group_name = aws_docdb_subnet_group.fp-documentDB-subnetGroup.name
    master_username = "AdminDB"
    master_password = "VMware1!"
    skip_final_snapshot = true
    tags = {
      Name = "fp-documentDB-Cluster"
    }
}
