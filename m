From: andrewm@isoar.ca (Andrew E. Mileski)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: PATCH - ALI 1535
Message-Id: <4050ECF0.4030302@isoar.ca>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The enclosed patch adds an adapter class to the ALI1535 bus driver.
The patch is against Linux kernel 2.6.1, but is trivial so it should
apply to more recent kernels.

Background
   The ADM1021 chip driver fails to detect the pair of MAX1617A on one
   of my ALI1535 equipped systems.  The detection never gets performed,
   as the first thing adm1021_attach_adapter() does is check for
   I2C_ADAP_CLASS_SMBUS.

   I figured the ALI1535 bus driver was probably not popular enough to
   be thoroughly tested in 2.6, so I looked at the PIIX4 bus driver
   and noticed that it explictly set the adapter class.  Doing the same
   in the ALI1535 bus driver causes the ADM1021 driver to detect as
   expected, and appears to be "The right thing to do".

Additional
   The ADM1021 chip driver returns success for several error conditions.
   This should probably be addressed.

-- 
Andrew E. Mileski

-------------- next part --------------
From: "Andrew E. Mileski" <andrewm@isoar.ca>
To: "Andrew E. Mileski" <andrewm@isoar.ca>
Subject: ALI1535 patch
MIME-Version: 1.0
Content-type: multipart/mixed; boundary="B_3073578747_26242"

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

B_3073578747_26242
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit

The enclosed patch adds an adapter class to the ALI1535 bus driver.
The patch is against Linux kernel 2.6.1, but is trivial so it should
apply to more recent kernels.

Background
  The ADM1021 chip driver fails to detect the pair of MAX1617A on one of
  my ALI1535 equipped systems.  The detection never gets performed, as
  the first thing adm1021_attach_adapter() does is check for
  I2C_ADAP_CLASS_SMBUS.

  I figured the ALI1535 bus driver was probably not popular enough to be
  thoroughly tested in 2.6, so I looked at the PIIX4 bus driver and noticed
  that it explictly set the adapter class.  Doing the same in the ALI1535
  bus driver causes the ADM1021 driver to detect as expected, and appears
  to be "the right thing to do".

Additional
  The ADM1021 chip driver returns success for several error conditions.
  This should probably be addressed.


B_3073578747_26242
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: attachment;
  filename="i2c-ali1535.patch"

diff -urN drivers/i2c/busses/i2c-ali1535.c.orig drivers/i2c/busses/i2c-ali1535.c
--- drivers/i2c/busses/i2c-ali1535.c.orig	2004-03-11 06:14:37.938198293 -0500
+++ drivers/i2c/busses/i2c-ali1535.c	2004-03-11 06:16:14.190730740 -0500
@@ -481,6 +481,7 @@
 
 static struct i2c_adapter ali1535_adapter = {
 	.owner		= THIS_MODULE,
+	.class		= I2C_ADAP_CLASS_SMBUS,
 	.algo		= &smbus_algorithm,
 	.name		= "unset",
 };
B_3073578747_26242
