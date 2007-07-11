From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 11 Jul 2007 12:47:00 +0000
Subject: Re: [lm-sensors] [PATCH] First cut of a adt7470 driver
Message-Id: <4694D144.3030909@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070706211144.GI3435@tree.beaverton.ibm.com>
In-Reply-To: <20070706211144.GI3435@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Darrick J. Wong wrote:

I just realized I failed to respond to this point, here is my response:

>> Why use read_byte twice in read16, but write_word in write16?
> 
> A "16 bit" register is really two 8 bit register reads/writes, and the
> register with the lower address has to be read/written first.  Hence the
> weird helper functions.
> 

Here is the code you use for this:

+static inline int adt7470_read_word_data(struct i2c_client *client, u8 reg)
+{
+	u16 foo;
+	foo = i2c_smbus_read_byte_data(client, reg);
+	foo |= ((u16)i2c_smbus_read_byte_data(client, reg + 1) << 8);
+	return foo;
+}
+
+static inline int adt7470_write_word_data(struct i2c_client *client, u8 reg,
+					  u16 value)
+{
+	u16 x = cpu_to_le16(value);
+
+	return i2c_smbus_write_word_data(client, reg, x & 0xFF)
+	       && i2c_smbus_write_word_data(client, reg + 1, x >> 8);
+}
+

I understand that you need to somehow read / write a byte 2 times to get a 
word, but why in adt7470_read_word_data() call i2c_smbus_read_byte_data twice? 
while in adt7470_write_word_data() you use cpu_to_le16() and then 
i2c_smbus_write_word_data(). Why not use i2c_smbus_read_word_data() in 
adt7470_read_word_data() instead of calling i2c_smbus_read_byte_data twice?

BTW I have serious doubts about you calling cpu_to_le16(), I would expect that 
i2c_smbus_write_word_data() wants the data to be in cpu endianness.

Regards,

Hans



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
