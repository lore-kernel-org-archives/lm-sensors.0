From: Johann.Glaser@gmx.at (Johann Glaser)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: ASUS P4C800 Deluxe - W83627THF
Message-Id: <1062325973.1151.43.camel@hansi>
List-Id: <lm-sensors.vger.kernel.org>
References: <1062239759.1074.30.camel@hansi>
In-Reply-To: <1062239759.1074.30.camel@hansi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi!

> As you saw, we've already added support for the ICH5 in 2.8.0.
> The w83627hf driver supports the thf as well, and we would
> rather enhance the support there than in w83781d.c, which is hopelessly cluttered.
> If you can give us a patch against CVS for that driver that would be most helpful.

I made a patch agains the current 2.8.0 sources downloaded from the
homepage.

Bye
  Hansi

-- 
Johann Glaser   <Johann.Glaser@gmx.at>
   Vienna University of Technology
       Electrical Engineering 
____ http://www.johann-glaser.at/ ____
-------------- next part --------------
--- lm_sensors-2.8.0/kernel/chips/w83627hf.c	2003-06-21 18:12:58.000000000 +0200
+++ lm_sensors-2.8.0-new/kernel/chips/w83627hf.c	2003-08-31 12:27:18.000000000 +0200
@@ -25,7 +25,7 @@
 
     Chip	#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
     w83627hf	9	3	2	3	0x20	0x5ca3	no	yes(LPC)
-    w83627thf	9	2	?	3	??	0x5ca3	no	yes(LPC)
+    w83627thf	6	3	0	3	0x90	0x5ca3	no	yes(LPC)
     w83697hf	8	2	2	2	0x60	0x5ca3	no	yes(LPC)
 
     For other winbond chips, and for i2c support in the above chips,
@@ -68,7 +68,7 @@
 static unsigned int normal_isa_range[] = { SENSORS_ISA_END };
 
 /* Insmod parameters */
-SENSORS_INSMOD_2(w83627hf, w83697hf);
+SENSORS_INSMOD_3(w83627hf, w83627thf, w83697hf);
 
 static int init = 1;
 MODULE_PARM(init, "i");
@@ -641,7 +641,7 @@
 	       superio_inb(WINB_BASE_REG + 1);
 	*address = val & ~(WINB_EXTENT - 1);
 	if (*address = 0 && force_addr = 0) {
-		printk("vt1211.o: base address not set - use force_addr=0xaddr\n");
+		printk("w83627hf.o: base address not set - use force_addr=0xaddr\n");
 		superio_exit();
 		return -ENODEV;
 	}
@@ -668,11 +668,11 @@
 	if(force_addr)
 		address = force_addr & ~(WINB_EXTENT - 1);
 	if (check_region(address, WINB_EXTENT)) {
-		printk("vt1211.o: region 0x%x already in use!\n", address);
+		printk("w83627hf.o: region 0x%x already in use!\n", address);
 		return -ENODEV;
 	}
 	if(force_addr) {
-		printk("vt1211.o: forcing ISA address 0x%04X\n", address);
+		printk("w83627hf.o: forcing ISA address 0x%04X\n", address);
 		superio_enter();
 		superio_select();
 		superio_outb(WINB_BASE_REG, address >> 8);
@@ -687,7 +687,7 @@
 	else if(val = W697_DEVID)
 		kind = w83697hf;
 	else if(val = W627THF_DEVID)
-		kind = w83627hf;
+		kind = w83627thf;
 		
 	superio_select();
 	if((val = 0x01 & superio_inb(WINB_ACT_REG)) = 0)
@@ -717,6 +717,9 @@
 	if (kind = w83627hf) {
 		type_name = "w83627hf";
 		client_name = "W83627HF chip";
+	} else if (kind = w83627thf) {
+		type_name = "w83627thf";
+		client_name = "W83627THF chip";
 	} else if (kind = w83697hf) {
 		type_name = "w83697hf";
 		client_name = "W83697HF chip";
@@ -1029,7 +1032,7 @@
 			    w83627hf_read_value(client,
 					       W83781D_REG_IN_MAX(i));
 			if ((data->type != w83697hf)
-			    && (data->type != w83627hf) && (i = 6))
+			    && (data->type != w83627hf) && (data->type != w83627thf) && (i = 6))
 				break;
 		}
 		for (i = 1; i <= 3; i++) {
