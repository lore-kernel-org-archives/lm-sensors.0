From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Fri, 04 Nov 2005 05:28:46 +0000
Subject: [lm-sensors] PEC support in i2c/lm_sensors CVS
Message-Id: <20051104042830.GA30472@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051030171335.34da6461.khali@linux-fr.org>
In-Reply-To: <20051030171335.34da6461.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

> On 2005-11-03, Mark M. Hoffman wrote:
> > I finally reviewed those patches; one suggestion, to apply if you like...
> >
> > This patch tweaks i2c-i801.c so that the driver always sets the SMBAUXCTL
> > register (which enables/disables PEC) explicitly before each transaction.

* Jean Delvare <khali@linux-fr.org> [2005-11-03 11:15:20 +0100]:
> I agree, I prefer it that way too. I'll apply that patch, and I'll test
> it on my ICH3M too. My testing possibilities are limited though, as I
> only have EEPROMs on that bus.
> 
> I was expecting more comments from your review, about the PEC core code
> rewrite itself. Inidivual SMBus drivers can always be tweaked, it isn't
> really related to the core rework. Do you have any kind of objection to
> the rewrite itself? My implementation is completely different from what
> we had before. It also has slightly different expectations from both bus
> and chip drivers. Just because I think it is better doesn't mean

Since you insist, heh... there was this bit from lm90.c for ADM1032 PEC:

+/* The ADM1032 supports PEC but not on write byte transactions, so we need
+   to explicitely ask for a transaction without PEC. */
+static inline s32 adm1032_write_byte(struct i2c_client *client, u8 value)
+{
+	return i2c_smbus_xfer(client->adapter, client->addr,
+			      client->flags & ~I2C_CLIENT_PEC,
+			      I2C_SMBUS_WRITE, value, I2C_SMBUS_BYTE, NULL);
+}

It's a bit of a hack, but in practice I hope it won't be necessary very
often.  Although, here we have the very first PEC capable device requiring
that.  But I don't have a better idea, so I wasn't going to mention it.

> everyone has to agree. I might have missed something. I would hate it if
> people will come and complain one year from now that this rewrite was a
> bad idea, for a reason I failed to think of.

No worries - I don't see anything glaring.  And there's one user for which
it works, right?  Not that I think it will, but if it did need to be reworked
again later, so be it.

> Given that the new implementation is already in Linus' tree for Linux
> 2.6, it's there to stay unless someone complains. The point about
> i2c/lm_sensors CVS is still open though. I will have to interpret the
> lack of objection as a green light for me to merge my rewrite in there.
> Much like everything else I do anyway, but this time the effects are
> much broader.

As for backporting this to 2.4: I have no opinion about that anymore.

(Except that, by this time next year, maybe we should deep-freeze the I2C
CVS tree, delete all the kernel 2.4 bits in lm_sensors2, and advance the
version to 3.0.0)

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

