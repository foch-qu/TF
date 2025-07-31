output "alb_target_nfc_private" {
    value = aws_alb_target_group.alb_target_nfc_private
}

output "alb_target_nfc_private_backend" {
    value = aws_alb_target_group.alb_target_nfc_private_backend
}

output "alb_target_nfc_public" {
    value = aws_alb_target_group.alb_target_nfc_public
}



output "alb_listen_nfc_private" {
    value = aws_alb_listener.alb_listen_nfc_private
}

output "alb_listen_nfc_public" {
    value = aws_alb_listener.alb_listen_nfc_public
}

