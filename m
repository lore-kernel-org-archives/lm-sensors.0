From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 12 Dec 2005 19:27:48 +0000
Subject: [lm-sensors] i2cdetect fails on a Asus P5ND2-Sli Deluxe
Message-Id: <20051212202748.7643f6b3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4399D312.1010109@free.fr>
In-Reply-To: <4399D312.1010109@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Fred,

> > You may take your chance and add 0x0034 to the list of IDs in
> > drivers/i2c/busses/i2c-nforce2.c. If your chip is actually compatible
> > with the earlier incarnations, it may work. Or it may not work, and
> > may even do bad things. Unless you have a datasheet, it's impossible
> > for us to tell. And you're on your own if something bad happens, of
> > course.
>
> Hmmm, I don't know where to add it in i2c-nforce2.c
> :-(
> 
> Any help, plz ?

That would be it:

 drivers/i2c/busses/i2c-nforce2.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6.15-rc5.orig/drivers/i2c/busses/i2c-nforce2.c	2005-11-12 15:49:51.000000000 +0100
+++ linux-2.6.15-rc5/drivers/i2c/busses/i2c-nforce2.c	2005-12-12 20:08:03.000000000 +0100
@@ -30,6 +30,7 @@
     nForce3 Pro150 MCP		00D4
     nForce3 250Gb MCP		00E4
     nForce4 MCP			0052
+    nForce4 MCP-04		0034
 
     This driver supports the 2 SMBuses that are included in the MCP of the
     nForce2/3/4 chipsets.
@@ -257,6 +258,7 @@
 	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE4_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, 0x0034) },
 	{ 0 }
 };
 

USE AT YOUR OWN RISK! Without a datasheet, I can't say whether this new
chip is compatible with the older ones. Chances are, it is. But again
maybe not. If you try it out, please let us know the outcome.

-- 
Jean Delvare

