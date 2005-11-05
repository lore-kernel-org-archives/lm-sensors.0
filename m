From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sat, 05 Nov 2005 22:01:08 +0000
Subject: [lm-sensors] ATI SMBus - new information
Message-Id: <436D1D6E.5000002@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <435A1BA9.9080009@sh.cvut.cz>
In-Reply-To: <435A1BA9.9080009@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> 
> Here is requested isadump:
> -----------------------------------
> [root@home ~]# isadump -f 0x400 16
> WARNING! Running this program can cause system crashes, data loss and worse!
> I will probe address range 0x400 to 0x40f.
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 00 00 00 37 ae 3c 00 00 00 00 00 00 00 00 a0 00
> -----------------------------------

Thanks,

This is slightly different that what should be the default of i801 conteroller. There are two other candidates left:
i2c-viapro and i2c-piix4.

They have both compatible commands and both have even the base addr at PCI config space 0x90.
Intel PIIX4 is used inside Serverworks and other chipsets so this leads me to the fact that they sold it to ATI too.
(or ATI copied it). I checked all PCI config space dumps I had (thank you all for posting them!) and it seems that
the registers are same.

I developed new patch. Please see attachment. As you can see it is quite simple one. It just add PCI IDs to PIIX4 driver.

Please can you repeat your tests with this patch?
(apply patch to i2c-piix4 and modprobe i2c-piix4; modprobe i2c-dev)

Additionaly I want to know:
i2cdetect 0
i2cdump 0 0x50
i2cdump 0 0x50 c
i2cdump 0 0x50
i2cdetect 0

If this sequence produces same results. Also please modprobe eeprom driver and try to read from the chip this way:
hexdump -C /sys/bus/i2c/devices/0-0050/eeprom

Thank you very much

Regards
Rudolf


-------------- next part --------------
diff -Naur c/drivers/i2c/busses/i2c-piix4.c d/drivers/i2c/busses/i2c-piix4.c
--- c/drivers/i2c/busses/i2c-piix4.c	2005-10-28 02:02:08.000000000 +0200
+++ d/drivers/i2c/busses/i2c-piix4.c	2005-11-05 21:20:02.801161750 +0100
@@ -423,6 +423,12 @@
 	  .driver_data = 3 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_SLC90E66_3),
 	  .driver_data = 0 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, 0x4353),
+	  .driver_data = 0 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, 0x4363),
+	  .driver_data = 0 },	
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, 0x4372),
+	  .driver_data = 0 },
 	{ 0, }
 };
 
