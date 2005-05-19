From: stoyan_martinov@btv.bg (stoyan_martinov@btv.bg)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: quirks.c.patch_for_2.6.8rc1 for HP D330L hidden smbus
Message-Id: <6261FB78A7376A42BB857B6FBD228A8D13E1F2@email.btv.bg>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
I've made a little mod of drivers/pci/quirks.c to enable hidden smbus device on my HP Compaq D330L :
After applying the patch:

iotzolin:~/my_lm_sensors_patch # lspci 
0000:00:00.0 Host bridge: Intel Corp. 82865G/PE/P Processor to I/O Controller (rev 02)
0000:00:01.0 PCI bridge: Intel Corp. 82865G/PE/P Processor to AGP Controller (rev 02)
0000:00:1d.0 USB Controller: Intel Corp. 82801EB USB (rev 02)
0000:00:1d.1 USB Controller: Intel Corp. 82801EB USB (rev 02)
0000:00:1d.2 USB Controller: Intel Corp. 82801EB USB (rev 02)
0000:00:1d.7 USB Controller: Intel Corp. 82801EB USB2 (rev 02)
0000:00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev c2)
0000:00:1f.0 ISA bridge: Intel Corp. 82801EB LPC Interface Controller (rev 02)
0000:00:1f.1 IDE interface: Intel Corp. 82801EB Ultra ATA Storage Controller (rev 02)
0000:00:1f.2 IDE interface: Intel Corp. 82801EB Ultra ATA Storage Controller (rev 02)
0000:00:1f.3 SMBus: Intel Corp. 82801EB SMBus Controller (rev 02)
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801EB AC'97 Audio Controller (rev 02)
0000:01:00.0 VGA compatible controller: nVidia Corporation NV15DDR [GeForce2 Ti] (rev a4)
0000:05:02.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5782 Gigabit Ethernet (rev 03)
iotzolin:~/my_lm_sensors_patch # lspci -n
0000:00:00.0 Class 0600: 8086:2570 (rev 02)
0000:00:01.0 Class 0604: 8086:2571 (rev 02)
0000:00:1d.0 Class 0c03: 8086:24d2 (rev 02)
0000:00:1d.1 Class 0c03: 8086:24d4 (rev 02)
0000:00:1d.2 Class 0c03: 8086:24d7 (rev 02)
0000:00:1d.7 Class 0c03: 8086:24dd (rev 02)
0000:00:1e.0 Class 0604: 8086:244e (rev c2)
0000:00:1f.0 Class 0601: 8086:24d0 (rev 02)
0000:00:1f.1 Class 0101: 8086:24db (rev 02)
0000:00:1f.2 Class 0101: 8086:24d1 (rev 02)
0000:00:1f.3 Class 0c05: 8086:24d3 (rev 02)
0000:00:1f.5 Class 0401: 8086:24d5 (rev 02)
0000:01:00.0 Class 0300: 10de:0151 (rev a4)
0000:05:02.0 Class 0200: 14e4:1696 (rev 03)
iotzolin:~/my_lm_sensors_patch # uname -a
Linux iotzolin 2.6.8-rc1 #26 SMP Fri Jul 16 18:20:41 EEST 2004 i686 i686 i386 GNU/Linux
iotzolin:~/my_lm_sensors_patch # pcitweak -l
PCI: Probing config type using method 1
PCI: Config type is 1
PCI: PCI scan (all values are in hex)
PCI: 00:00:0: chip 8086,2570 card 103c,12bc rev 02 class 06,00,00 hdr 00
PCI: 00:01:0: chip 8086,2571 card 0000,0000 rev 02 class 06,04,00 hdr 01
PCI: 00:1d:0: chip 8086,24d2 card 103c,12bc rev 02 class 0c,03,00 hdr 80
PCI: 00:1d:1: chip 8086,24d4 card 103c,12bc rev 02 class 0c,03,00 hdr 00
PCI: 00:1d:2: chip 8086,24d7 card 103c,12bc rev 02 class 0c,03,00 hdr 00
PCI: 00:1d:7: chip 8086,24dd card 103c,12bc rev 02 class 0c,03,20 hdr 00
PCI: 00:1e:0: chip 8086,244e card 0000,0000 rev c2 class 06,04,00 hdr 01
PCI: 00:1f:0: chip 8086,24d0 card 0000,0000 rev 02 class 06,01,00 hdr 80
PCI: 00:1f:1: chip 8086,24db card 103c,12bc rev 02 class 01,01,8a hdr 00
PCI: 00:1f:2: chip 8086,24d1 card 103c,12bc rev 02 class 01,01,8f hdr 00
PCI: 00:1f:3: chip 8086,24d3 card 103c,12bc rev 02 class 0c,05,00 hdr 00
PCI: 00:1f:5: chip 8086,24d5 card 103c,12bc rev 02 class 04,01,00 hdr 00
PCI: 01:00:0: chip 10de,0151 card 0000,0000 rev a4 class 03,00,00 hdr 00
PCI: 05:02:0: chip 14e4,1696 card 103c,12bc rev 03 class 02,00,00 hdr 00
PCI: End of PCI scan

-------------- next part --------------
A non-text attachment was scrubbed...
Name: quirks.c.patch_for_2.6.8rc1
Type: application/octet-stream
Size: 1607 bytes
Desc: quirks.c.patch_for_2.6.8rc1
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040716/82298362/quirks.c.patch_for_2.6.obj
