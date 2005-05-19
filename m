From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:23:58 +0000
Subject: [Fwd: Re: [RFC PATCH] Re: [OOPS] w83781d during rmmod (2.5.69-bk17)]
Message-Id: <3EDF6EFC.7070604@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This got tagged as spam, so I'll forward it along.


Phil

-------- Original Message --------
From: 	- Thu Jun 5 09:24:00 2003
X-UIDL: 	20b89fe49ed911d3
X-Mozilla-Status: 	0011
X-Mozilla-Status2: 	10000000
Return-Path: 	<lm78@Stimpy.netroedge.com>
Received: 	from Stimpy.netroedge.com (IDENT:root@Stimpy.netroedge.com 
[206.228.191.3]) by Ren.netroedge.com (8.12.8p1/8.9.1) with ESMTP id 
h552fCvL022979 for <phil@ren.netroedge.com>; Wed, 4 Jun 2003 19:41:12 -0700
Received: 	from Stimpy.netroedge.com (IDENT:lm78@localhost [127.0.0.1]) 
h552mnBI008665; Wed, 4 Jun 2003 19:48:49 -0700
Received: 	(from lm78@localhost) by Stimpy.netroedge.com 
(8.12.8p1/8.12.8/Submit) id h552mlUN008658; Wed, 4 Jun 2003 19:48:47 -0700
Received: 	from charger.oldcity.dca.net (charger.oldcity.dca.net 
[207.245.82.76])h552mhBI008638 for <sensors@stimpy.netroedge.com>; Wed, 
4 Jun 2003 19:48:44 -0700
Received: 	from earth.solarsys.private 
(adsl-216-158-52-153.cust.oldcity.dca.net [216.158.52.153]) 
h552dM509015; Wed, 4 Jun 2003 22:39:23 -0400
Received: 	by earth.solarsys.private (Postfix, from userid 1000) id 
2EBF87DE1; Wed, 4 Jun 2003 22:39:22 -0400 (EDT)
Date: 	Wed, 4 Jun 2003 22:39:22 -0400
From: 	Mark M. Hoffman <mhoffman@lightlink.com>
To: 	LKML <linux-kernel@vger.kernel.org>, Sensors 
<sensors@Stimpy.netroedge.com>
Cc: 	Greg KH <greg@kroah.com>, Martin Schlemmer <azarah@gentoo.org>
Subject: 	Re: [RFC PATCH] Re: [OOPS] w83781d during rmmod (2.5.69-bk17)
Message-ID: 	<20030605023922.GA8943@earth.solarsys.private>
Mail-Followup-To: 	LKML <linux-kernel@vger.kernel.org>, Sensors 
<sensors@stimpy.netroedge.com>, Greg KH <greg@kroah.com>, Martin 
Schlemmer <azarah@gentoo.org>
References: 	<20030524183748.GA3097@earth.solarsys.private> 
<3ED8067E.1050503@paradyne.com> 
<20030601143808.GA30177@earth.solarsys.private> 
<20030602172040.GC4992@kroah.com>
Mime-Version: 	1.0
X-Security: 	MIME headers sanitized on Stimpy.netroedge.com See 
http://www.impsec.org/email-tools/procmail-security.html for details. 
$Revision: 1.129 $Date: 2001-04-14 20:20:43-07
Content-Type: 	multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: 	inline
In-Reply-To: 	<20030602172040.GC4992@kroah.com>
User-Agent: 	Mutt/1.4.1i
X-SpamBouncer: 	1.5 (8/16/02)
X-SBClass: 	OK
X-Spambayes-Classification: 	spam; 1.00



* Greg KH <greg@kroah.com> [2003-06-02 10:20:40 -0700]:
> On Sun, Jun 01, 2003 at 10:38:08AM -0400, Mark M. Hoffman wrote:
> > 
> > This patch against 2.5.70 works for me vs. an SMBus adapter.  It needs
> > re-testing against an ISA adapter since my particular chip is SMBus only.
> 
> I've applied this and will send it off to Linus in a bit.

Thanks!

This patch fixes the various return values in the w83781d_detect()
error paths.  It also cleans up some formatting here and there.
It should be applied on top of the previous one.

It works for me; same caveat as above w.r.t. ISA.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com



-------------- next part --------------
--- linux-2.5.70/drivers/i2c/chips/w83781d.c.orig1	2003-06-04 21:05:35.000000000 -0400
+++ linux-2.5.70/drivers/i2c/chips/w83781d.c	2003-06-04 21:37:11.000000000 -0400
@@ -1039,7 +1039,7 @@
 		struct i2c_client *new_client)
 {
 	int i, val1 = 0, id;
-	int err = 0;
+	int err;
 	const char *client_name;
 	struct w83781d_data *data = i2c_get_clientdata(new_client);
 
@@ -1058,7 +1058,8 @@
 			    force_subclients[i] > 0x4f) {
 				dev_err(&new_client->dev, "Invalid subclient "
 					"address %d; must be 0x48-0x4f\n",
-			       force_subclients[i]);
+					force_subclients[i]);
+				err = -EINVAL;
 				goto ERROR_SC_1;
 			}
 		}
@@ -1082,6 +1083,7 @@
 			dev_err(&new_client->dev,
 			       "Duplicate addresses 0x%x for subclients.\n",
 			       data->lm75[0].addr);
+			err = -EBUSY;
 			goto ERROR_SC_1;
 		}
 	}
@@ -1119,7 +1121,7 @@
 			break;
 	}
 
-	return err;
+	return 0;
 
 /* Undo inits in case of errors */
 ERROR_SC_2:
@@ -1136,18 +1138,22 @@
 	int i = 0, val1 = 0, val2;
 	struct i2c_client *new_client;
 	struct w83781d_data *data;
-	int err = 0;
+	int err;
 	const char *client_name = "";
 	int is_isa = i2c_is_isa_adapter(adapter);
 	enum vendor { winbond, asus } vendid;
 
 	if (!is_isa
-	    && !i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+	    && !i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
+		err = -EINVAL;
 		goto ERROR0;
+	}
 
 	if (is_isa)
-		if (!request_region(address, W83781D_EXTENT, "w83781d"))
+		if (!request_region(address, W83781D_EXTENT, "w83781d")) {
+			err = -EBUSY;
 			goto ERROR0;
+		}
 
 	/* Probe whether there is anything available on this address. Already
 	   done for SMBus clients */
@@ -1155,15 +1161,21 @@
 		if (is_isa) {
 
 #define REALLY_SLOW_IO
-			/* We need the timeouts for at least some LM78-like chips. But only
-			   if we read 'undefined' registers. */
+			/* We need the timeouts for at least some LM78-like
+			   chips. But only if we read 'undefined' registers. */
 			i = inb_p(address + 1);
-			if (inb_p(address + 2) != i)
+			if (inb_p(address + 2) != i) {
+				err = -ENODEV;
 				goto ERROR1;
-			if (inb_p(address + 3) != i)
+			}
+			if (inb_p(address + 3) != i) {
+				err = -ENODEV;
 				goto ERROR1;
-			if (inb_p(address + 7) != i)
+			}
+			if (inb_p(address + 7) != i) {
+				err = -ENODEV;
 				goto ERROR1;
+			}
 #undef REALLY_SLOW_IO
 
 			/* Let's just hope nothing breaks here */
@@ -1171,7 +1183,8 @@
 			outb_p(~i & 0x7f, address + 5);
 			if ((inb_p(address + 5) & 0x7f) != (~i & 0x7f)) {
 				outb_p(i, address + 5);
-				return 0;
+				err = -ENODEV;
+				goto ERROR1;
 			}
 		}
 	}
@@ -1204,8 +1217,10 @@
 	   force_*=... parameter, and the Winbond will be reset to the right
 	   bank. */
 	if (kind < 0) {
-		if (w83781d_read_value(new_client, W83781D_REG_CONFIG) & 0x80)
+		if (w83781d_read_value(new_client, W83781D_REG_CONFIG) & 0x80){
+			err = -ENODEV;
 			goto ERROR2;
+		}
 		val1 = w83781d_read_value(new_client, W83781D_REG_BANK);
 		val2 = w83781d_read_value(new_client, W83781D_REG_CHIPMAN);
 		/* Check for Winbond or Asus ID if in bank 0 */
@@ -1213,14 +1228,19 @@
 		    (((!(val1 & 0x80)) && (val2 != 0xa3) && (val2 != 0xc3)
 		      && (val2 != 0x94))
 		     || ((val1 & 0x80) && (val2 != 0x5c) && (val2 != 0x12)
-			 && (val2 != 0x06))))
+			 && (val2 != 0x06)))) {
+			err = -ENODEV;
 			goto ERROR2;
-		/* If Winbond SMBus, check address at 0x48. Asus doesn't support */
+		}
+		/* If Winbond SMBus, check address at 0x48.
+		   Asus doesn't support */
 		if ((!is_isa) && (((!(val1 & 0x80)) && (val2 = 0xa3)) ||
 				  ((val1 & 0x80) && (val2 = 0x5c)))) {
 			if (w83781d_read_value
-			    (new_client, W83781D_REG_I2C_ADDR) != address)
+			    (new_client, W83781D_REG_I2C_ADDR) != address) {
+				err = -ENODEV;
 				goto ERROR2;
+			}
 		}
 	}
 
@@ -1239,8 +1259,11 @@
 			vendid = winbond;
 		else if ((val2 = 0x12) || (val2 = 0x06))
 			vendid = asus;
-		else
+		else {
+			err = -ENODEV;
 			goto ERROR2;
+		}
+
 		/* mask off lower bit, not reliable */
 		val1  		    w83781d_read_value(new_client, W83781D_REG_WCHIPID) & 0xfe;
@@ -1262,6 +1285,7 @@
 				       "Ignoring 'force' parameter for unknown chip at"
 				       "adapter %d, address 0x%02x\n",
 				       i2c_adapter_id(adapter), address);
+			err = -EINVAL;
 			goto ERROR2;
 		}
 	}
@@ -1279,7 +1303,9 @@
 	} else if (kind = w83697hf) {
 		client_name = "W83697HF chip";
 	} else {
-		dev_err(&new_client->dev, "Internal error: unknown kind (%d)?!?", kind);
+		dev_err(&new_client->dev, "Internal error: unknown "
+						"kind (%d)?!?", kind);
+		err = -ENODEV;
 		goto ERROR2;
 	}
 
