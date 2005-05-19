From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: Support DB Entry 1770
Message-Id: <20040911091846.58bf3bb6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <007201c49733$ef934970$0a01a8c0@enterprise>
In-Reply-To: <007201c49733$ef934970$0a01a8c0@enterprise>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

> i2c-isa loads fine.  w83781d fails at step 2.
>=20
> =3D> /var/log/syslog <=3D
> Sep 10 19:15:10 defiant kernel: i2c_adapter i2c-0: registered as
> adapter
> #0
>=20
> <defiant> [2004-09-10@19:15:17] ~ -> modprobe w83781d
>=20
> =3D> /var/log/syslog <=3D
> Sep 10 19:15:25 defiant kernel: i2c-core: driver w83781d registered.
> Sep 10 19:15:25 defiant kernel: i2c_adapter i2c-0: found normal isa
> entry for adapter 9191, addr 0290
> Sep 10 19:15:25 defiant kernel: i2c_adapter i2c-0: Detection of
> w83781d chip failed at step 2

OK, at least we now know where it breaks. The strange thing is that the
very same detection trick is used in sensors-detect, where it seems to
work fine for you. I admit I don't quite understand what's going on.

Attached is a modified patch that will make the failure more verbose.
Please revert the previous patch, apply this one, and test again.

The patch will also ignore the step 2 error, so that we can see whether
or not this is the only step failing.

Alternatively, you can try to load the w83781d module with the
"force=9191,0x290" parameter and see how it goes. This should skip all
the detection steps.

> > I would also appreciate the output of "isadump 0x295 0x296".
>=20
> Here's the output before I loaded any modules.
>=20
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 20: 7e 7d de b5 c7 d7 ca 1c ff 5c ff ff 00 ff 00 ed
> 30: b0 80 24 00 c2 08 24 00 00 c0 a1 00 20 06 00 00
> 40: 01 d8 0f ff 7f 00 40 a0 2d 01 01 40 01 95 80 5c
> 50: 00 7f 80 ff ff ff 00 80 11 ff ff ff ff ff ff ff
> 60: 7e 7d de b5 c7 d7 ca 1c ff 5c ff ff 00 ff 00 ed
> 70: b0 80 24 00 c2 08 24 00 00 c0 a1 00 20 06 00 00
> 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> a0: 7e 7d de b5 c7 d7 ca 1c ff 5c ff ff 00 ff 00 ed
> b0: b0 80 24 00 c2 08 24 00 00 c0 a1 00 20 06 00 00
> c0: 01 00 00 ff 7f 00 40 a0 2d 01 01 40 01 95 80 5c
> d0: 01 75 80 ff ff ff 00 80 11 ff ff ff ff ff ff ff
> e0: 7e 7d de b5 c7 d7 ca 1c ff 5c ff ff 00 ff 00 ed
> f0: b0 80 24 00 c2 08 24 00 00 c0 a1 00 20 06 00 00
>=20
> Here's the output after I loaded i2c-isa and w83781d.
>=20
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 20: 7d 7d df b5 c7 d7 ca 1c ff 5c ff ff 00 ff 00 ed
> 30: b0 80 24 00 c2 08 24 00 00 c0 a1 00 20 06 00 00
> 40: 01 c8 0f ff 7f 00 40 a0 2d 01 01 40 01 95 80 5c
> 50: 02 56 80 ff ff ff 00 80 11 ff ff ff ff ff ff ff
> 60: 7d 7d df b5 c7 d7 ca 1c ff 5c ff ff 00 ff 00 ed
> 70: b0 80 24 00 c2 08 24 00 00 c0 a1 00 20 06 00 00
> 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> a0: 7d 7d df b5 c7 d7 ca 1c ff 5c ff ff 00 ff 00 ed
> b0: b0 80 24 00 c2 08 24 00 00 c0 a1 00 20 06 00 00
> c0: 01 00 00 ff 7f 00 40 a0 2d 01 01 40 01 95 80 5c
> d0: 03 45 80 ff ff ff 00 80 11 ff ff ff ff ff ff ff
> e0: 7d 7d df b5 c7 d7 ca 1c ff 5c ff ff 00 ff 00 ed
> f0: b0 80 24 00 c2 08 24 00 00 c0 a1 00 20 06 00 00
>=20
> I tried another isadump later and diff'ed the results and some lines
> were different.  I guess it's constantly changing?  This is the sensor
> data?

True. Registers containing measured values are likely to change, not by
much but very often. Nothing to be afraid of. You can also notice that
the chip registers are addressed over 7 bits, not 8. Thus 0x00-0x7F and
0x80-0xFF are "the same" (modulo the changes in measured values).

--=20
Jean "Khali" Delvare
http://khali.linux-fr.org/
-------------- next part --------------
--- linux-2.6.8/drivers/i2c/chips/w83781d.c.orig	2004-08-24 18:42:40.000000=
000 +0200
+++ linux-2.6.8/drivers/i2c/chips/w83781d.c	2004-09-11 09:08:34.000000000 +=
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
@@ -1093,10 +1092,14 @@
 			/* Let's just hope nothing breaks here */
 			i =3D inb_p(address + 5) & 0x7f;
 			outb_p(~i & 0x7f, address + 5);
-			if ((inb_p(address + 5) & 0x7f) !=3D (~i & 0x7f)) {
+			val2 =3D inb_p(address + 5) & 0x7f;
+			if (val2 !=3D (~i & 0x7f)) {
 				outb_p(i, address + 5);
-				err =3D -ENODEV;
-				goto ERROR1;
+				/* err =3D -ENODEV; */
+				dev_dbg(&adapter->dev, "Detection of w83781d "
+					"chip failed at step 2 (0x%x !=3D "
+					"0x%x)\n", val2, ~i & 0x7f);
+				/* goto ERROR1;*/
 			}
 		}
 	}
@@ -1126,8 +1129,10 @@
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
@@ -1137,6 +1142,8 @@
 		    (((!(val1 & 0x80)) && (val2 !=3D 0xa3) && (val2 !=3D 0xc3))
 		     || ((val1 & 0x80) && (val2 !=3D 0x5c) && (val2 !=3D 0x12)))) {
 			err =3D -ENODEV;
+			dev_dbg(&new_client->dev, "Detection failed at step "
+				"4\n");
 			goto ERROR2;
 		}
 		/* If Winbond SMBus, check address at 0x48.
@@ -1146,6 +1153,8 @@
 			if (w83781d_read_value
 			    (new_client, W83781D_REG_I2C_ADDR) !=3D address) {
 				err =3D -ENODEV;
+				dev_dbg(&new_client->dev, "Detection failed "
+					"at step 5\n");
 				goto ERROR2;
 			}
 		}
@@ -1168,6 +1177,8 @@
 			vendid =3D asus;
 		else {
 			err =3D -ENODEV;
+			dev_dbg(&new_client->dev, "Chip was made by neither "
+				"Winbond nor Asus?\n");
 			goto ERROR2;
 		}
=20
