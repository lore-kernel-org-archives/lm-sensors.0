From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: [PATCH 2.6] Error paths in it87 and via686a drivers
Message-Id: <20040410172219.06b2ee65.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Here comes the patch that fixes error paths in the it87 and via686a
detection functions. The it87 part also adds missing error values.

Please apply (on top of the big kmalloc patch),
thanks.


--- linux-2.6.5-mm3/drivers/i2c/chips/it87.c.orig	Sat Apr 10 10:33:09 2004
+++ linux-2.6.5-mm3/drivers/i2c/chips/it87.c	Sat Apr 10 16:19:46 2004
@@ -533,12 +533,12 @@
 			/* We need the timeouts for at least some IT87-like chips. But only
 			   if we read 'undefined' registers. */
 			i = inb_p(address + 1);
-			if (inb_p(address + 2) != i)
-				goto ERROR1;
-			if (inb_p(address + 3) != i)
-				goto ERROR1;
-			if (inb_p(address + 7) != i)
+			if (inb_p(address + 2) != i
+			 || inb_p(address + 3) != i
+			 || inb_p(address + 7) != i) {
+		 		err = -ENODEV;
 				goto ERROR1;
+			}
 #undef REALLY_SLOW_IO
 
 			/* Let's just hope nothing breaks here */
@@ -546,7 +546,8 @@
 			outb_p(~i & 0x7f, address + 5);
 			if ((inb_p(address + 5) & 0x7f) != (~i & 0x7f)) {
 				outb_p(i, address + 5);
-				return 0;
+				err = -ENODEV;
+				goto ERROR1;
 			}
 		}
 	}
@@ -573,11 +574,12 @@
 	/* Now, we do the remaining detection. */
 
 	if (kind < 0) {
-		if (it87_read_value(new_client, IT87_REG_CONFIG) & 0x80)
-			goto ERROR1;
-		if (!is_isa
-			&& (it87_read_value(new_client, IT87_REG_I2C_ADDR) !-			address)) goto ERROR1;
+		if ((it87_read_value(new_client, IT87_REG_CONFIG) & 0x80)
+		  || (!is_isa
+		   && it87_read_value(new_client, IT87_REG_I2C_ADDR) != address)) {
+		   	err = -ENODEV;
+			goto ERROR2;
+		}
 	}
 
 	/* Determine the chip type. */
@@ -592,7 +594,8 @@
 					"Ignoring 'force' parameter for unknown chip at "
 					"adapter %d, address 0x%02x\n",
 					i2c_adapter_id(adapter), address);
-			goto ERROR1;
+			err = -ENODEV;
+			goto ERROR2;
 		}
 	}
 
@@ -611,7 +614,7 @@
 
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
-		goto ERROR1;
+		goto ERROR2;
 
 	/* Initialize the IT87 chip */
 	it87_init_client(new_client, data);
@@ -667,9 +670,9 @@
 
 	return 0;
 
-ERROR1:
+ERROR2:
 	kfree(data);
-
+ERROR1:
 	if (is_isa)
 		release_region(address, IT87_EXTENT);
 ERROR0:


--- linux-2.6.5-mm3/drivers/i2c/chips/via686a.c.orig	Sat Apr 10 10:32:48 2004
+++ linux-2.6.5-mm3/drivers/i2c/chips/via686a.c	Sat Apr 10 13:08:19 2004
@@ -748,9 +748,9 @@
 	return 0;
 
       ERROR3:
-	release_region(address, VIA686A_EXTENT);
 	kfree(data);
       ERROR0:
+	release_region(address, VIA686A_EXTENT);
 	return err;
 }
 

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
