From: hvw59601@yahoo.com (Hugo Vanwoerkom)
Date: Sun, 31 Jul 2005 20:09:19 +0000
Subject: [lm-sensors] Support for Winbond W83687THF in Lm_sensors-2.9.1
Message-Id: <20050731180836.85440.qmail@web31009.mail.mud.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050726214252.85202.qmail@web31008.mail.mud.yahoo.com>
In-Reply-To: <20050726214252.85202.qmail@web31008.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Hate to bother you, you are so busy! 

--- Jean Delvare <khali@linux-fr.org> wrote:

> Hi Hugo,
>  
> Your patch looks almost correct to me, I think you
> simply forgot to
> update this part:
> 
> 	if (kind = w83627hf) {
> 		type_name = "w83627hf";
> 		client_name = "W83627HF chip";
> 	} else if (kind = w83627thf) {
> 		type_name = "w83627thf";
> 		client_name = "W83627THF chip";
> 	} else if (kind = w83697hf) {
> 		type_name = "w83697hf";
> 		client_name = "W83697HF chip";
> 	} else if (kind = w83637hf) {
> 		type_name = "w83637hf";
> 		client_name = "W83637HF chip";
> 	} else {
> 		goto ERROR1;
> 	}
> 
> 
> You need another "else if" statement for the
> W83687THF here, and it
> should be OK after that.
> 
> Let us know :)
> 

I got that one after I posted, still "no sensors
found".

I attach my updated patch, with that change added.

Thanks for answering!

Hugo



		
____________________________________________________
Start your day with Yahoo! - make it your home page 
http://www.yahoo.com/r/hs 
 
-------------- next part --------------
--- w83627hf.orig.c	2005-03-09 15:09:52.000000000 -0600
+++ w83627hf.c	2005-07-27 06:42:39.000000000 -0500
@@ -27,6 +27,7 @@
     w83627hf	9	3	2	3	0x20	0x5ca3	no	yes(LPC)
     w83627thf	7	3	3	3	0x90	0x5ca3	no	yes(LPC)
     w83637hf	7	3	3	3	0x80	0x5ca3	no	yes(LPC)
+    w83687thf   ?       ?       ?       ?       0x90    0x5ca3  no      yes(LPC)
     w83697hf	8	2	2	2	0x60	0x5ca3	no	yes(LPC)
 
     For other winbond chips, and for i2c support in the above chips,
@@ -35,7 +36,7 @@
     Note: automatic ("cruise") fan control for 697, 637 & 627thf not
     supported yet.
 */
-
+#define DEBUG 1
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/ioport.h>
@@ -63,7 +64,7 @@
 static unsigned int normal_isa_range[] = { SENSORS_ISA_END };
 
 /* Insmod parameters */
-SENSORS_INSMOD_4(w83627hf, w83627thf, w83697hf, w83637hf);
+SENSORS_INSMOD_5(w83627hf, w83627thf, w83697hf, w83637hf, w83687thf);
 
 static int init = 1;
 MODULE_PARM(init, "i");
@@ -135,6 +136,7 @@
 #define W627THF_DEVID 0x82
 #define W697_DEVID 0x60
 #define W637_DEVID 0x70
+#define W687THF_DEVID 0x85
 #define WINB_ACT_REG 0x30
 #define WINB_BASE_REG 0x60
 /* Constants specified below */
@@ -596,7 +598,7 @@
 
 	superio_enter();
 	val= superio_inb(DEVID);
-	if(val != W627_DEVID && val !=W627THF_DEVID && val != W697_DEVID && val != W637_DEVID) {
+	if(val != W687THF_DEVID && val != W627_DEVID && val !=W627THF_DEVID && val != W697_DEVID && val != W637_DEVID) {
 		superio_exit();
 		return -ENODEV;
 	}
@@ -655,6 +657,8 @@
 		kind = w83627thf;
 	else if(val = W637_DEVID)
 		kind = w83637hf;
+	else if(val = W687THF_DEVID)
+		kind = w83687thf;
 		
 	superio_select(W83627HF_LD_HWM);
 	if((val = 0x01 & superio_inb(WINB_ACT_REG)) = 0)
@@ -691,10 +695,12 @@
 	} else if (kind = w83637hf) {
 		type_name = "w83637hf";
 		client_name = "W83637HF chip";
+	} else if (kind = w83687thf) {
+		type_name = "w83687thf";
+		client_name = "W83687THF chip";
 	} else {
 		goto ERROR1;
 	}
-
 	request_region(address, WINB_EXTENT, type_name);
 
 	/* Fill in the remaining client fields and put it into the global list */
@@ -888,12 +894,12 @@
 		int lo = w83627hf_read_value(client, W83781D_REG_VID_FANDIV);
 		int hi = w83627hf_read_value(client, W83781D_REG_CHIPID);
 		data->vid = (lo & 0x0f) | ((hi & 0x01) << 4);
-	} else if (w83627thf = data->type) {
+	} else if (w83627thf = data->type || w83687thf = data->type) {
 		data->vid = w83627thf_read_gpio5(client) & 0x3f;
 	}
 
 	/* Read VRM & OVT Config only once */
-	if (w83627thf = data->type || w83637hf = data->type)
+	if (w83627thf = data->type || w83687thf = data->type || w83637hf = data->type)
 		data->vrm_ovt  			w83627hf_read_value(client, W83627THF_REG_VRM_OVT_CFG);
 	else
@@ -973,7 +979,7 @@
 		for (i = 0; i <= 8; i++) {
 			/* skip missing sensors */
 			if (((data->type = w83697hf) && (i = 1)) ||
-			    ((data->type = w83627thf || data->type = w83637hf) &&
+			    ((data->type = w83627thf || data->type = w83637hf || w83687thf = data->type) &&
 			     (i = 4 || i = 5)))
 				continue;
 			data->in[i] @@ -995,7 +1001,7 @@
 		for (i = 1; i <= 3; i++) {
 			u8 tmp = w83627hf_read_value(client,
 				W836X7HF_REG_PWM(data->type, i));
-			if (data->type = w83627thf)
+			if (data->type = w83627thf || w83687thf = data->type)
 				tmp &= 0xf0; /* bits 0-3 are reserved  in 627THF */
 			data->pwm[i - 1] = tmp;
 			if(i = 2 && (data->type = w83627hf || data->type = w83697hf))
@@ -1345,7 +1351,7 @@
 		*nrels_mag = 1;
 	} else if (operation = SENSORS_PROC_REAL_WRITE) {
 		if (*nrels_mag >= 1) {
-			if (data->type = w83627thf) {
+			if (data->type = w83627thf || w83687thf = data->type) {
 				/* bits 0-3 are reserved  in 627THF */
 				data->pwm[nr - 1] = PWM_TO_REG(results[0]) & 0xf0;
 				w83627hf_write_value(client,
