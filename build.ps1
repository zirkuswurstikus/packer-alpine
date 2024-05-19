$env:PACKER_LOG=1
$env:PACKER_LOG_PATH="packerlog.txt"
packer build -force -on-error=ask . 