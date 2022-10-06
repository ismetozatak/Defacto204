az login -> powershell üzerinden  bu klasör açılır ve login olunur.
# Azuredan oluşturuluan hesap girilir.
az account set --subscription "Azure Pass - Sponsorluk"   #"00d099f1-d183-48d2-a3d3-b319d4816d28"

#1. resource group listeleme 
az group list --output table

#1.1. rg oluşturma
az group create --name iodemo-vm-rg-2 --location "westeurope"

#2. Virtual machine oluşturulur.
az vm create \
         --resource-group "iodemo-vm-rg-2" \
         --name "iodemo-win-cli" \
         --image "win2019datacenter" \
         --admin-username "ismetozatak" \
         --admin-password "Pa55W0rd1234"

# ssh type ile bağlanılmışsa
  az vm create \
         --resource-group "iodemo-vm-rg-2" \
         --name "iodemo-linux-cli" \
         --image "UbuntuTls" \
         --admin-username "ismetozatak" \
         --admin-password "Pa55W0rd1234"
         --authentication-type "ssh"
         --ssh-key-value ~/.ssh/id_rsa.pub \
         --generate-ssh-keys



#3. Bağlanmak istenen portlar aç:
az vm open-port \
    --resource-group "iodemo-vm-rg-2" \
    --name "iodemo-win-cli" \
    --port "3389" 

#4.  public ip yi sorgulama
az vm list-ip-addresses \
  --resource-group "iodemo-vm-rg-2" \
  --name "iodemo-win-cli" \
  --output table

  # VirtualMachine    PublicIPAddresses    PrivateIPAddresses
  #----------------  -------------------  --------------------
  #iodemo-win-cli    40.113.147.160       10.0.0.4

#5.silme işlemi  portal üzerindne oluşturulan vm siler.
az group delete --name iodemo-vm-rg
