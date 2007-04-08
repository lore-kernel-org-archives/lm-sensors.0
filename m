From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 08 Apr 2007 08:58:40 +0000
Subject: Re: [lm-sensors] What about i2c_smbus_read_block_data() ?
Message-Id: <20070408105840.53188b16.khali@linux-fr.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Multipart=_Sun__8_Apr_2007_10_58_40_+0200_0chHD1o1qdjVelY."
List-Id: <lm-sensors.vger.kernel.org>
References: <200704042149.21264.hjk@linutronix.de>
In-Reply-To: <200704042149.21264.hjk@linutronix.de>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Sun__8_Apr_2007_10_58_40_+0200_0chHD1o1qdjVelY.
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Mark, Hans-J=FCrgen,

On Wed, 4 Apr 2007 22:42:18 -0400, Mark M. Hoffman wrote:
> * Hans-J=FCrgen Koch <hjk@linutronix.de> [2007-04-04 23:32:34 +0200]:
> > Am Mittwoch, 4. April 2007 21:49 schrieb Hans-J=FCrgen Koch:
> > > I'm working on a driver for LM93. I've got some code by Mark Hoffman,=
 (c)2004.=20
> > > It doesn't compile on a recent kernel, because it heavily uses a func=
tion called
> > > i2c_smbus_read_block_data(). Googling for that, I found this old mail=
 in the
> > > archives (October 2005):
> > >=20
> > > http://lists.lm-sensors.org/pipermail/lm-sensors/2005-October/013971.=
html
> > >=20
> > > Jean, what do you say to that today? Can we have that function back in
> > > mainline, or do I have to find another solution?
> > > If you agree to add it, I could prepare a patch for it, if you don't =
have
> > > a recent version handy.
> >=20
> > Answering my own question: After looking at i2c-core.c et al., I find i=
t quite
> > obvious that this function should be added, if a driver needs it.=20

True.

> > I attached a patch that does this. Would that be acceptable? I can rese=
nd it
> > when I have the LM93 patch ready.
>=20
> I think if you put it in the same patchset with lm93.c, that will be fine.

I have a different variant of this patch in my local tree, which takes
the i2c-core changes that happened in the meantime into account. I'm
attaching it to this post if someone want to take a look and/or
comment. In fact I think I'll schedule this patch for merge into 2.6.22
regardless of the state of the lm93 driver patch. I'm a bit tired to
have to maintain that patch off-tree and to see people waste their time
wondering where that function has gone, searching the mailing list for
explanations, finding the patch and resubmitting it. We all have better
things to do.

Anyway, the key point for Hans-J=FCrgen is: you can assume that function
i2c_smbus_read_block_data() will be available to you when your lm93
driver patch is merged upstream.

> Jean: I can do the initial review of this one for you when it's ready.

Great, thanks!

--=20
Jean Delvare

--Multipart=_Sun__8_Apr_2007_10_58_40_+0200_0chHD1o1qdjVelY.
Content-Type: text/plain;
 name="i2c-add-smbus-block-read.patch"
Content-Disposition: attachment;
 filename="i2c-add-smbus-block-read.patch"
Content-Transfer-Encoding: quoted-printable

Subject: i2c: Restore i2c_smbus_read_block_data

Add back the i2c_smbus_read_block_data function, it is needed by the
upcoming lm93 driver.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/i2c/i2c-core.c |   16 ++++++++++++++++
 include/linux/i2c.h    |    3 +++
 2 files changed, 19 insertions(+)

--- linux-2.6.21-rc6.orig/drivers/i2c/i2c-core.c	2007-04-08 10:23:22.000000=
000 +0200
+++ linux-2.6.21-rc6/drivers/i2c/i2c-core.c	2007-04-08 10:48:48.000000000 +=
0200
@@ -1300,6 +1300,22 @@ s32 i2c_smbus_write_word_data(struct i2c
 }
 EXPORT_SYMBOL(i2c_smbus_write_word_data);
=20
+/* Returns the number of read bytes */
+s32 i2c_smbus_read_block_data(struct i2c_client *client, u8 command,
+			      u8 *values)
+{
+	union i2c_smbus_data data;
+
+	if (i2c_smbus_xfer(client->adapter, client->addr, client->flags,
+	                   I2C_SMBUS_READ, command,
+	                   I2C_SMBUS_BLOCK_DATA, &data))
+		return -1;
+
+	memcpy(values, &data.block[1], data.block[0]);
+	return data.block[0];
+}
+EXPORT_SYMBOL(i2c_smbus_read_block_data);
+
 s32 i2c_smbus_write_block_data(struct i2c_client *client, u8 command,
 			       u8 length, const u8 *values)
 {
--- linux-2.6.21-rc6.orig/include/linux/i2c.h	2007-04-08 10:23:22.000000000=
 +0200
+++ linux-2.6.21-rc6/include/linux/i2c.h	2007-04-08 10:33:45.000000000 +0200
@@ -82,6 +82,9 @@ extern s32 i2c_smbus_write_byte_data(str
 extern s32 i2c_smbus_read_word_data(struct i2c_client * client, u8 command=
);
 extern s32 i2c_smbus_write_word_data(struct i2c_client * client,
                                      u8 command, u16 value);
+/* Returns the number of read bytes */
+extern s32 i2c_smbus_read_block_data(struct i2c_client *client,
+				     u8 command, u8 *values);
 extern s32 i2c_smbus_write_block_data(struct i2c_client * client,
 				      u8 command, u8 length,
 				      const u8 *values);

--Multipart=_Sun__8_Apr_2007_10_58_40_+0200_0chHD1o1qdjVelY.
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--Multipart=_Sun__8_Apr_2007_10_58_40_+0200_0chHD1o1qdjVelY.--
