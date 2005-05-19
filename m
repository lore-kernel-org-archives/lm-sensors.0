From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: Support DB Entry 1770
Message-Id: <20040911213751.451cfbba.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <007201c49733$ef934970$0a01a8c0@enterprise>
In-Reply-To: <007201c49733$ef934970$0a01a8c0@enterprise>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

> <defiant> [2004-09-11@13:54:07] ~ -> modprobe w83781d
>=20
> =3D> /var/log/syslog <=3D
> Sep 11 13:54:10 defiant kernel: i2c-core: driver w83781d registered.
> Sep 11 13:54:10 defiant kernel: i2c_adapter i2c-0: found normal isa
> entry for adapter 9191, addr 0290
> Sep 11 13:54:10 defiant kernel: i2c_adapter i2c-0: Detection of
> w83781d chip failed at step 2 (0x61 !=3D 0x60)

Odd. I wonder how this is even possible. What's more, I made the error
on-fatal so I would have expected some more messages after that. No
extra message means that either a critical failure occured (out of
memory or similar), or the end of the detection was fine - but then why
would sensors not show the chip?

An even more verbose patch is attached, please try.

> > Alternatively, you can try to load the w83781d module with the
> > "force=9191,0x290" parameter and see how it goes. This should skip
> > all the detection steps.
>=20
> Tried  this, "sensors" still says "No sensors found!"  First two
> syslog lines are same as above, minus the third "failed" line.

Please double-check. The second line should read "found force parameter"
instead of "found normal isa entry". If it doesn't, this would mean that
the driver didn't understand your request. Either you didn't formulate
it correctly, or this has to be another bug in the i2c subsystem.

Thanks.

--=20
Jean "Khali" Delvare
http://khali.linux-fr.org/
-------------- next part --------------
--- linux-2.6.8/drivers/i2c/chips/w83781d.c.orig	2004-08-24 18:42:40.000000=
000 +0200
+++ linux-2.6.8/drivers/i2c/chips/w83781d.c	2004-09-11 21:30:51.000000000 +=
0200
@@ -1064,6 +1064,9 @@
 	if (is_isa)
 		if (!request_region(address, W83781D_EXTENT, "w83781d")) {
 			err =3D -EBUSY;
+			dev_dbg(&adapter->dev, "Request of region "
+				"0x%x-0x%x for w83781d failed\n", address,
+				address + W83781D_EXTENT - 1);
 			goto ERROR0;
 		}
=20
@@ -1076,16 +1079,12 @@
 			/* We need the timeouts for at least some LM78-like
 			   chips. But only if we read 'undefined' registers. */
 			i =3D inb_p(address + 1);
-			if (inb_p(address + 2) !=3D i) {
-				err =3D -ENODEV;
-				goto ERROR1;
-			}
-			if (inb_p(address + 3) !=3D i) {
-				err =3D -ENODEV;
-				goto ERROR1;
-			}
-			if (inb_p(address + 7) !=3D i) {
+			if (inb_p(address + 2) !=3D i
+			 || inb_p(address + 3) !=3D i
+			 || inb_p(address + 7) !=3D i) {
 				err =3D -ENODEV;
+				dev_dbg(&adapter->dev, "Detection of w83781d "
+					"chip failed at step 1\n");
 				goto ERROR1;
 			}
 #undef REALLY_SLOW_IO
@@ -1093,10 +1092,15 @@
 			/* Let's just hope nothing breaks here */
 			i =3D inb_p(address + 5) & 0x7f;
 			outb_p(~i & 0x7f, address + 5);
-			if ((inb_p(address + 5) & 0x7f) !=3D (~i & 0x7f)) {
+			val2 =3D inb_p(address + 5) & 0x7f;
+			if (val2 !=3D (~i & 0x7f)) {
 				outb_p(i, address + 5);
-				err =3D -ENODEV;
-				goto ERROR1;
+				dev_dbg(&adapter->dev, "Detection of w83781d "
+					"chip failed at step 2 (0x%x !=3D "
+					"0x%x at 0x%x)\n", val2, ~i & 0x7f,
+					address + 5);
+				/* err =3D -ENODEV;
+				goto ERROR1; */
 			}
 		}
 	}
@@ -1106,6 +1110,7 @@
 	   But it allows us to access w83781d_{read,write}_value. */
=20
 	if (!(data =3D kmalloc(sizeof(struct w83781d_data), GFP_KERNEL))) {
+		dev_dbg(&adapter->dev, "Not enough memory for w83781d\n");
 		err =3D -ENOMEM;
 		goto ERROR1;
 	}
@@ -1126,8 +1131,10 @@
 	   force_*=3D... parameter, and the Winbond will be reset to the right
 	   bank. */
 	if (kind < 0) {
-		if (w83781d_read_value(new_client, W83781D_REG_CONFIG) & 0x80){
+		if (w83781d_read_value(new_client, W83781D_REG_CONFIG) & 0x80) {
 			err =3D -ENODEV;
+			dev_dbg(&new_client->dev, "Detection failed at step "
+				"3\n");
 			goto ERROR2;
 		}
 		val1 =3D w83781d_read_value(new_client, W83781D_REG_BANK);
@@ -1137,6 +1144,8 @@
 		    (((!(val1 & 0x80)) && (val2 !=3D 0xa3) && (val2 !=3D 0xc3))
 		     || ((val1 & 0x80) && (val2 !=3D 0x5c) && (val2 !=3D 0x12)))) {
 			err =3D -ENODEV;
+			dev_dbg(&new_client->dev, "Detection failed at step "
+				"4\n");
 			goto ERROR2;
 		}
 		/* If Winbond SMBus, check address at 0x48.
@@ -1146,6 +1155,8 @@
 			if (w83781d_read_value
 			    (new_client, W83781D_REG_I2C_ADDR) !=3D address) {
 				err =3D -ENODEV;
+				dev_dbg(&new_client->dev, "Detection failed "
+					"at step 5\n");
 				goto ERROR2;
 			}
 		}
@@ -1168,6 +1179,8 @@
 			vendid =3D asus;
 		else {
 			err =3D -ENODEV;
+			dev_dbg(&new_client->dev, "Chip was made by neither "
+				"Winbond nor Asus?\n");
 			goto ERROR2;
 		}
=20
@@ -1221,8 +1234,10 @@
 	init_MUTEX(&data->update_lock);
=20
 	/* Tell the I2C layer a new client has arrived */
-	if ((err =3D i2c_attach_client(new_client)))
+	if ((err =3D i2c_attach_client(new_client))) {
+		dev_dbg(&new_client->dev, "Attach failed\n");
 		goto ERROR2;
+	}
=20
 	/* attach secondary i2c lm75-like clients */
 	if (!is_isa) {
@@ -1309,6 +1324,7 @@
 	}
 #endif
=20
+	dev_dbg(&new_client->dev, "Detect OK\n");
 	return 0;
=20
 ERROR3:
