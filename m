From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sat, 22 Oct 2005 22:13:15 +0000
Subject: [lm-sensors] ATI SMBus - new information
Message-Id: <435A9D3D.2030309@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <435A1BA9.9080009@sh.cvut.cz>
In-Reply-To: <435A1BA9.9080009@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all,

Update. Please send me the DSDT tables directly. The mailing list will throw them away.(bin attachment)
See the attachment for the patch.

Please note, the code was not tested. I belive it should work, but it may do bad things to your HW.
On the other hand you want the ATI SMBUS support :)

This patch is for 2.6 driver of i2c-i801.c After applying the patch you should be able to modprobe i2c-i801
if you modprobe i2c-dev then you should be able to run i2cdetect and i2cdump.

i2cdump 0
should show that 0x50 or above is used.

40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
50: 50 51 XX XX XX XX XX XX XX XX XX XX XX XX XX XX

If you see all XX it means there is nothing or my patch does not work.

If so you can try to dump the address:
i2cdump 0 0x50

00: 80 08 07 0d 0a 02 40 00 04 50 60 00 82 08 00 01    ??????@.?P`.??.?
10: 0e 04 0c 01 02 20 00 60 70 00 00 3c 28 3c 28 40    ????? .`p..<(<(@

....

If the output is similar to this one then you can run sensors-detect to detect the chips (leave the i2c-i801 loaded)

Please report how it goes.
Good luck.

Thanks,
Regards
Rudolf
-------------- next part --------------
diff -Naur a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
--- a/drivers/i2c/busses/i2c-i801.c	2005-09-30 23:17:35.000000000 +0200
+++ b/drivers/i2c/busses/i2c-i801.c	2005-10-22 21:36:20.000000000 +0200
@@ -119,6 +119,22 @@
 	unsigned char temp;
 
 	/* Note: we keep on searching until we have found 'function 3' */
+	
+	if (PCI_DEVFN(0x14,0) = dev->devfn) {
+		I801_dev = dev;
+		pci_read_config_word(I801_dev, 0x90, &i801_smba);
+		i801_smba &= 0xfff0;
+		isich4 = 0; //dont know yet
+
+		if (!request_region(i801_smba, (isich4 ? 16 : 8), "i801-smbus")) {
+			dev_err(&dev->dev, "I801_smb region 0x%x already in use!\n",
+				i801_smba);
+			error_return = -EBUSY;
+			goto END;
+		}
+		return 0;
+	}	
+
 	if(PCI_FUNC(dev->devfn) != 3)
 		return -ENODEV;
 
@@ -557,6 +573,9 @@
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_16) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_17) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB2_17) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, 0x4353) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, 0x4363) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, 0x4372) },
 	{ 0, }
 };
 
