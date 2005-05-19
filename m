From: ben-i2c@fluff.org (Ben Dooks)
Date: Thu, 19 May 2005 06:25:18 +0000
Subject: S3C2410 I2C driver
Message-Id: <20041012095425.GA4970@home.fluff.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041008130842.GK12218@home.fluff.org>
In-Reply-To: <20041008130842.GK12218@home.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Oct 12, 2004 at 11:29:53AM +0200, Jean Delvare wrote:
> 
> Hi Ben, hi Greg,
> 
> This is my quick review of Ben's code. Please note that my knowledge
> about I2C adapters and embedded systems is limited, so you should not
> consider it as absolute as you could do when I comment on I2C chip
> drivers. I would like another person to review the code as well (Greg?)
> since I am likely to miss important points.
> 
> >+config I2C_S3C2410
> >+	tristate "S3C2410 I2C Driver"
> 
> "I2C" and "Driver" are redundant here. You are in the I2C menu, and
> each time is a driver.
> 
> >+	depends on I2C && ARCH_S3C2410
> >+	help
> >+	  Say Y to this to enable the I2C controller inbuilt into the
> >+	  Samsung S3C2410 based System-on-Chip devices
> 
> s/to this// or s/to this/here/
> I also doubt that "inbuilt into" is correct. "embedded into" or
> "built into" sounds better.
> 
> I'd suggest that you depend on EXPERIMENTAL in a first time.
> 
> >+ * Copyright (c) 2004 Simtec Electronics
> >+ *	Ben Dooks <ben@simtec.co.uk>
> 
> (C), not (c).

ok, will add to list of things to change
 
> (BTW, Greg, did you verify this? I remember of a confusion last time we
> talked about this.)
> 
> >+ * Changelog
> >+ *	29-Sep-2004	BJD	Initial version
> >+ *	04-Oct-2004	BJD	Fixed ignore ACK on last read
> >+ *	08-Oct-2004	BJD	Fixed stop if zero length message
> 
> Changelogs don't belong to the driver code. Bug fixes are documented in
> BK, functionality changes would better belong to Documentation/i2c/*.

I find at least summary changelogs in the driver very useful, as they
can't get seperated from the code, and this is pretty much the style i've
used everywhere ese.

> >+#define PFX "s3c-i2c: "
> 
> Shoudln't it be i2c-s3c (so as to match the driver file name)?
> 
> >+#define XFER_RETRY (-2000)
> 
> couldn't it be -EAGAIN?

ok, good point.
 
> >+enum s3c24xx_i2c_state {
> >+	STATE_IDLE,
> >+	STATE_START,
> >+	STATE_READ,
> >+	STATE_WRITE,
> >+	STATE_STOP
> >+};
> 
> Additional comma after last item. Sane is true for all enums and struct
> instances.
> 
> >+/* */
> >+static inline struct s3c2410_platform_i2c 
> 
> That was an interesting comment ;)
> 
> >+static void s3c24xx_i2c_showmsg(struct i2c_msg *parent, struct i2c_msg *msg)
> >+{
> >+	DBG(0, PFX "%p [%2d: A %04x F 0x%04x L 0x%04x %p ]\n",
> >+	    parent, parent-msg, msg->addr, msg->flags, msg->len, msg->buf);
> >+}
> >+
> >+static void s3c24xx_i2c_showmsgs(struct i2c_msg *msgs, int num)
> >+{
> >+	struct i2c_msg *msgp = msgs;
> >+	int msg;
> >+
> >+	for (msg = 0; msg < num; msg++, msgp++)
> >+		s3c24xx_i2c_showmsg(msgs, msgp);
> >+}
> 
> BTW, shouldn't all this debug stuff be conditioned by DEBUG being
> defined? Including code that doesn't have a chance to ever get called
> is not great.
> 
> >+	ret = i2c_add_adapter(&i2c->adap);
> >+	if (ret < 0) {
> >+		printk(KERN_INFO "I2C: Failed to add bus\n");
> >+		goto out;
> >+	}
> 
> Should be KERN_ERR, methinks.


> Remember... I couldn't possibly comment on the technical side, so
> someone else will have to do it. I hope my comments did help a bit
> though.

thanks for looking.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
