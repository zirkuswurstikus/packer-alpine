
source "hyperv-iso" "hyperv" {
  boot_command       = ["root<enter><wait>", "ifconfig eth0 up && udhcpc -i eth0<enter><wait10>", "wget http://{{ .HTTPIP }}:{{ .HTTPPort }}/answers<enter><wait>", "setup-alpine -f answers<enter><wait5>" , "vagrant<enter><wait>", "vagrant<enter><wait>", "<wait10><wait10><wait10>", "y<enter>", "<wait10><wait10><wait10>", "<wait10><wait10><wait10>", "rc-service sshd stop<enter>", "mount /dev/sda3 /mnt<enter>", "echo 'PermitRootLogin yes' >> /mnt/etc/ssh/sshd_config<enter>", "umount /mnt<enter>", "eject -s /dev/cdrom<enter>", "reboot<enter>", "<wait10><wait10><wait10>", "root<enter><wait>", "vagrant<enter><wait>", "apk add hvtools<enter><wait>", "rc-update add hv_fcopy_daemon default<enter><wait>", "rc-update add hv_kvp_daemon default<enter><wait>", "rc-update add hv_vss_daemon default<enter><wait>", "reboot<enter>"]
  # IMPORTANT always use none keyboard layout else key sequence do not work!!!
  #boot_command     = ["<wait>root<enter><wait>setup-alpine<enter><wait>none<enter>alpine319<enter>eth0<enter>dhcp<enter>n<enter><wait10>vagrant<enter>vagrant<enter>Europe<enter>Berlin<enter><wait10><enter><enter>r<wait5>vagrant<enter>vagrant<enter>vagrant<enter>vagrant<enter>http://10.10.2.201:8080/vagrant.pub<enter>openssh<enter>sda<enter>sys<enter><wait5>y<enter><wait10>"]
  boot_wait          = "10s"
  communicator       = "ssh"
  disk_size          = "512"
  enable_secure_boot = false
  generation         = 2
  http_directory     = "http"
  http_port_max      = "8080"
  http_port_min      = "8080"
  iso_checksum       = "sha256:366317d854d77fc5db3b2fd774f5e1e5db0a7ac210614fd39ddb555b09dbb344"
  iso_url            = "https://dl-cdn.alpinelinux.org/alpine/v3.19/releases/x86_64/alpine-virt-3.19.1-x86_64.iso"
  shutdown_command   = "poweroff"
  skip_compaction    = "true"
  ssh_password       = "vagrant"
  ssh_username       = "root"
  switch_name        = "Default Switch"
}

build {
  sources = ["source.hyperv-iso.hyperv"]

  provisioner "file" {
    destination = "/tmp/useradd.sh"
    source      = "ressources/scripts/useradd.sh"
  }

  provisioner "shell" {
    script = "ressources/scripts/provision.sh"
  }

  post-processor "vagrant" {
    keep_input_artifact  = true	// DEFAULT false
    output               = "ALPINE_319_VIRTAMD64_{{ .Provider }}.box"
    #vagrantfile_template = "ressources/configs/ALPINE_319_VIRTAMD64_BASE.vagrantfile.template"
  }

}
