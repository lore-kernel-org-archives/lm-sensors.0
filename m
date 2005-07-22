From: jcromie@divsol.com (Jim Cromie)
Date: Fri, 22 Jul 2005 15:41:22 +0000
Subject: [lm-sensors] [patches pc87360]  printk-format, magic-init
Message-Id: <42E0F763.1040500@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


1st is self-explanatory.

2nd adds some missing parts of the magic init sequence.
It doesnt seem to change anything, (ie improve my numbers),

I cant cut-paste from the PDF, but its page 208.

its also in this code;
http://phk.freebsd.dk/soekris/env4801/env4801.c

if (argc = 2 && !strcmp(argv[1], "-i")) {
		/* Magic init sequence from page 208 */
		outb(atms + 0x8, 0x00);
		outb(atms + 0x9, 0x0f);
		outb(atms + 0xa, 0x08);
		outb(atms + 0xb, 0x04);
		outb(atms + 0xc, 0x35);
		outb(atms + 0xd, 0x05);
		outb(atms + 0xe, 0x05);


Incidentally, the reason I got into this that,
despite the fact that Ive got an 'ignore fan2' in my config,
Im getting this error:

    prog/sensors/chips.c:    printf("ERROR: Can't get FAN2 data!\n");




Ive been unable to build 2.9.1 or cvs on my fedora 3 laptop,
so Ive been unable to add prints to narrow the source of the problem.

For now, Id like to find out if others are building ok on Fedora 3,
how they got around the lack of modversions.h.


fwiw, my soekris board has no fans, so I think the module-code
detects that lack via extra_isa, and sets fannr = 0, so never creates
the sysfs files.  The lib code apparently doesnt handle a missing
sysfs node well.

I'll verify this supposition with printks b4 returning here.


-------------- next part --------------
diff -ruN -X exclude-diffs linux-2.6.12-ska12/drivers/i2c/chips/pc87360.c linux-2.6.12-i2c/drivers/i2c/chips/pc87360.c
--- linux-2.6.12-ska12/drivers/i2c/chips/pc87360.c	2005-06-17 13:48:29.000000000 -0600
+++ linux-2.6.12-i2c/drivers/i2c/chips/pc87360.c	2005-07-21 11:25:16.000000000 -0600
@@ -1045,7 +1047,7 @@
 		reg = pc87360_read_value(data, LD_IN, NO_BANK,
 					 PC87365_REG_IN_CONVRATE);
 		dev_info(&client->dev, "VLM conversion set to"
-			 "1s period, 160us delay\n");
+			 " 1s period, 160us delay\n");
 		pc87360_write_value(data, LD_IN, NO_BANK,
 				    PC87365_REG_IN_CONVRATE,
 				    (reg & 0xC0) | 0x11);
-------------- next part --------------
diff -ruN -X exclude-diffs linux-2.6.12-ska12/drivers/i2c/chips/pc87360.c linux-2.6.12-i2c/drivers/i2c/chips/pc87360.c
--- linux-2.6.12-ska12/drivers/i2c/chips/pc87360.c	2005-06-17 13:48:29.000000000 -0600
+++ linux-2.6.12-i2c/drivers/i2c/chips/pc87360.c	2005-07-21 11:25:16.000000000 -0600
@@ -1144,11 +1146,14 @@
 
 		if (init >= 2) {
 			/* Chip config as documented by National Semi. */
-			pc87360_write_value(data, LD_TEMP, 0xF, 0xA, 0x08);
+			pc87360_write_value(data, LD_TEMP, 0xF, 0x8, 0x00);
 			/* We voluntarily omit the bank here, in case the
 			   sequence itself matters. It shouldn't be a problem,
 			   since nobody else is supposed to access the
 			   device at that point. */
+			pc87360_write_value(data, LD_TEMP, NO_BANK, 0x9, 0x0F);
+			pc87360_write_value(data, LD_TEMP, NO_BANK, 0xA, 0x08);
+
 			pc87360_write_value(data, LD_TEMP, NO_BANK, 0xB, 0x04);
 			pc87360_write_value(data, LD_TEMP, NO_BANK, 0xC, 0x35);
 			pc87360_write_value(data, LD_TEMP, NO_BANK, 0xD, 0x05);
