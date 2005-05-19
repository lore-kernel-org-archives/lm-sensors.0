From: alexander.pohl@tu-berlin.de (Alexander Pohl)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: Intel 82801DA ICH4
Message-Id: <32780.62.246.165.72.1058995255.squirrel@mailbox.TU-Berlin.DE>
List-Id: <lm-sensors.vger.kernel.org>
References: <32803.62.246.166.13.1058892758.squirrel@mailbox.TU-Berlin.DE>
In-Reply-To: <32803.62.246.166.13.1058892758.squirrel@mailbox.TU-Berlin.DE>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

I finally got it running, but your p4b_smbus.o code is not SMP compliant.
I compiled it successfully under a single processor kernel. Here comes
what the module said, when inserting it under the SMP kernel again:

# insmod p4b_smbus.o
p4b_smbus.o: unresolved symbol pci_insert_device_R3341a12e
p4b_smbus.o: unresolved symbol pci_read_config_word_R923654cb
p4b_smbus.o: unresolved symbol pci_remove_device_R2d6c74a6
p4b_smbus.o: unresolved symbol kmalloc_R93d4cfe6
p4b_smbus.o: unresolved symbol pcibios_present_R520a75b9
p4b_smbus.o: unresolved symbol pci_find_device_Rc584f4e3
p4b_smbus.o: unresolved symbol pci_enable_device_R1bc741d2
p4b_smbus.o: unresolved symbol pci_write_config_word_Rf23d8795
p4b_smbus.o: unresolved symbol kfree_R037a0cba
p4b_smbus.o: unresolved symbol printk_R1b7d4074
p4b_smbus.o: unresolved symbol pci_setup_device_R863ed348


When activating the SMBus I really didn't know what I was doing. I got the
hex value 0049 and then changed it to 0040, like described in the
README.p4b. The output of pcitweak was as followed:

# setpci -d 8086:24c0 f2.w@
# pcitweak -l
PCI: Probing config type using method 1
PCI: Config type is 1
PCI: PCI scan (all values are in hex)
PCI: 00:00:0: chip 8086,2560 card 1043,80b2 rev 02 class 06,00,00 hdr 00
PCI: 00:01:0: chip 8086,2561 card 0000,0000 rev 02 class 06,04,00 hdr 01
PCI: 00:1d:0: chip 8086,24c2 card 1043,8089 rev 02 class 0c,03,00 hdr 80
PCI: 00:1d:1: chip 8086,24c4 card 1043,8089 rev 02 class 0c,03,00 hdr 00
PCI: 00:1d:2: chip 8086,24c7 card 1043,8089 rev 02 class 0c,03,00 hdr 00
PCI: 00:1d:7: chip 8086,24cd card 1043,8089 rev 02 class 0c,03,20 hdr 00
PCI: 00:1e:0: chip 8086,244e card 0000,0000 rev 82 class 06,04,00 hdr 01
PCI: 00:1f:0: chip 8086,24c0 card 0000,0000 rev 02 class 06,01,00 hdr 80
PCI: 00:1f:1: chip 8086,24cb card 1043,8089 rev 02 class 01,01,8a hdr 00
PCI: 00:1f:3: chip 8086,24c3 card 1043,8089 rev 02 class 0c,05,00 hdr 00
PCI: 00:1f:5: chip 8086,24c5 card 1043,80b0 rev 02 class 04,01,00 hdr 00
PCI: 01:00:0: chip 10de,0253 card 1043,803f rev a3 class 03,00,00 hdr 00
PCI: 02:03:0: chip 1106,3044 card 1043,808a rev 80 class 0c,00,10 hdr 00
PCI: 02:05:0: chip 14e4,4401 card 1043,80a8 rev 01 class 02,00,00 hdr 00
PCI: End of PCI scan

I hope you have all information to change the module code. Anyway, sensors
works now under the single processor kernel.

Best regards,
Alexander Pohl


