From: =?iso-8859-15?q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
Date: Fri, 13 Apr 2007 16:09:06 +0000
Subject: Re: [lm-sensors] [PATCH] Add LM93 support
Message-Id: <200704131809.06743.hjk@linutronix.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Boundary-00=_is6HGciiUsaIAaw"
List-Id: <lm-sensors.vger.kernel.org>
References: <200704131723.42773.hjk@linutronix.de>
In-Reply-To: <200704131723.42773.hjk@linutronix.de>
To: lm-sensors@vger.kernel.org

--Boundary-00=_is6HGciiUsaIAaw
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Freitag, 13. April 2007 17:23 schrieb Hans-J=FCrgen Koch:
> This patch adds support for the LM93 Hardware Monitor/Fan Controller.
> Be warned, this is a monster that adds about 160 sysfs attributes.
> However, it compiles without warnings (patch is against 2.6.21-rc5)
> and I tested it on an Intel dual Xeon board. Looks alright to me.
>=20
> Please review.
>=20
> Thanks,
> Hans
>=20

Just one note: As discussed in a thread ("What about i2c_smbus_read_block_d=
ata() ?")
a few days ago (April 4/5), this driver needs the i2c_smbus_read_block_data=
()
function. Jean said he will add this function.=20

Anyway, if you want to test this on a standard kernel, you probably don't h=
ave that
function yet. For your convenience, I attached the patch I currently use.

BIG NOTE: This patch is _NOT_ meant to be applied to mainline, Jean already=
 has
his own version!

Thanks,
Hans


--Boundary-00=_is6HGciiUsaIAaw
Content-Type: text/x-diff; charset="iso-8859-15";
	name="add-i2c_smbus_read_block_data.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="add-i2c_smbus_read_block_data.patch"

Index: linux-2.6.21-rc/drivers/i2c/i2c-core.c
===================================================================
--- linux-2.6.21-rc.orig/drivers/i2c/i2c-core.c	2007-04-04 23:07:39.000000000 +0200
+++ linux-2.6.21-rc/drivers/i2c/i2c-core.c	2007-04-04 23:10:12.000000000 +0200
@@ -994,6 +994,22 @@
 	                      I2C_SMBUS_WORD_DATA,&data);
 }
 
+s32 i2c_smbus_read_block_data(struct i2c_client *client, u8 command,
+			      u8 *values)
+{
+	union i2c_smbus_data data;
+	int i;
+	if (i2c_smbus_xfer(client->adapter, client->addr, client->flags,
+	    I2C_SMBUS_READ, command,
+	    I2C_SMBUS_BLOCK_DATA, &data))
+		return -1;
+	else {
+		for (i = 1; i <= data.block[0]; i++)
+			values[i-1] = data.block[i];
+		return data.block[0];
+	}
+}
+
 s32 i2c_smbus_write_block_data(struct i2c_client *client, u8 command,
 			       u8 length, const u8 *values)
 {
@@ -1238,6 +1254,7 @@
 EXPORT_SYMBOL(i2c_smbus_write_byte_data);
 EXPORT_SYMBOL(i2c_smbus_read_word_data);
 EXPORT_SYMBOL(i2c_smbus_write_word_data);
+EXPORT_SYMBOL(i2c_smbus_read_block_data);
 EXPORT_SYMBOL(i2c_smbus_write_block_data);
 EXPORT_SYMBOL(i2c_smbus_read_i2c_block_data);
 EXPORT_SYMBOL(i2c_smbus_write_i2c_block_data);
Index: linux-2.6.21-rc/include/linux/i2c.h
===================================================================
--- linux-2.6.21-rc.orig/include/linux/i2c.h	2007-04-04 23:07:39.000000000 +0200
+++ linux-2.6.21-rc/include/linux/i2c.h	2007-04-04 23:10:12.000000000 +0200
@@ -87,6 +87,8 @@
 extern s32 i2c_smbus_read_word_data(struct i2c_client * client, u8 command);
 extern s32 i2c_smbus_write_word_data(struct i2c_client * client,
                                      u8 command, u16 value);
+extern s32 i2c_smbus_read_block_data(struct i2c_client *client, u8 command,
+				     u8 *values);
 extern s32 i2c_smbus_write_block_data(struct i2c_client * client,
 				      u8 command, u8 length,
 				      const u8 *values);

--Boundary-00=_is6HGciiUsaIAaw
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--Boundary-00=_is6HGciiUsaIAaw--
