output "ip-master"{
    value = var.ip_master
}

# output "ip-worker-01"{
#     value = aws_instance.k8s-worker.*.private_ip
# }

# output "ip-worker-02"{
#     value = concat(aws_instance.k8s-worker.*.private_ip,[""])[1]
# }