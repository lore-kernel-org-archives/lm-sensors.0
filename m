From: =?iso-8859-1?q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
Date: Wed, 04 Apr 2007 21:32:34 +0000
Subject: Re: [lm-sensors] What about i2c_smbus_read_block_data() ?
Message-Id: <200704042332.34959.hjk@linutronix.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Boundary-00=_ylBFG9WdLv/Jv2z"
List-Id: <lm-sensors.vger.kernel.org>
References: <200704042149.21264.hjk@linutronix.de>
In-Reply-To: <200704042149.21264.hjk@linutronix.de>
To: lm-sensors@vger.kernel.org

--Boundary-00=_ylBFG9WdLv/Jv2z
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Mittwoch, 4. April 2007 21:49 schrieb Hans-J=FCrgen Koch:
> I'm working on a driver for LM93. I've got some code by Mark Hoffman, (c)=
2004.=20
> It doesn't compile on a recent kernel, because it heavily uses a function=
 called
> i2c_smbus_read_block_data(). Googling for that, I found this old mail in =
the
> archives (October 2005):
>=20
> http://lists.lm-sensors.org/pipermail/lm-sensors/2005-October/013971.html
>=20
> Jean, what do you say to that today? Can we have that function back in
> mainline, or do I have to find another solution?
> If you agree to add it, I could prepare a patch for it, if you don't have
> a recent version handy.

Answering my own question: After looking at i2c-core.c et al., I find it qu=
ite
obvious that this function should be added, if a driver needs it.=20

I attached a patch that does this. Would that be acceptable? I can resend it
when I have the LM93 patch ready.

Thanks,
Hans

--Boundary-00=_ylBFG9WdLv/Jv2z
Content-Type: text/x-diff; charset="iso-8859-1";
	name="add-i2c_smbus_read_block_data.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="add-i2c_smbus_read_block_data.patch"

Index: linux-2.6.21-rc/drivers/i2c/i2c-core.c
===================================================================
--- linux-2.6.21-rc.orig/drivers/i2c/i2c-core.c	2007-04-04 22:40:55.000000000 +0200
+++ linux-2.6.21-rc/drivers/i2c/i2c-core.c	2007-04-04 23:01:40.000000000 +0200
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
--- linux-2.6.21-rc.orig/include/linux/i2c.h	2007-04-04 22:46:15.000000000 +0200
+++ linux-2.6.21-rc/include/linux/i2c.h	2007-04-04 22:47:19.000000000 +0200
@@ -87,6 +87,8 @@
 extern s32 i2c_smbus_read_word_data(struct i2c_client * client, u8 command);
 extern s32 i2c_smbus_write_word_data(struct i2c_client * client,
                                      u8 command, u16 value);
+extern s32 i2c_smbus_read_block_data(struct i2c_client *client, u8 command,
+				     u8 *values);
 extern s32 i2c_smbus_write_block_data(struct i2c_client * client,
 				      u8 command, u8 length,
 				      const u8 *values);

--Boundary-00=_ylBFG9WdLv/Jv2z
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--Boundary-00=_ylBFG9WdLv/Jv2z--
