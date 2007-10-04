From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 04 Oct 2007 14:02:47 +0000
Subject: Re: [lm-sensors] [patch 2.6.23-rc6] lm75 should handle I/O errors
Message-Id: <20071004160247.0f035193@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070918165107.7C0D2239772@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
In-Reply-To: <20070918165107.7C0D2239772@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

On Wed, 03 Oct 2007 12:58:37 -0700, David Brownell wrote:
> And in fact, I noticed that the comment for the I2C_RETRIES ioctl
> is explicit that it only applies to the address.  If any driver
> retries anything more, that'd be incorrect ...

Yes, I noticed that comment yesterday too. At least this somewhat
clarifies the original intent of I2C_RETRIES.

> Also:  given that definition, SMBus devices shouldn't be retried,
> since they must always acknowledge their addresses.  If this retry
> mechanism sticks around, maybe it should be coupled with a flag
> like I2C_CLIENT_SMBUS, with SMBus devices never getting retries.

Just because they "must" do it, doesn't mean it happens in practice.
And the transaction could have failed before the end of the address
byte, for example due to a bus collision, arbitration loss, noise on
the lines, anything. My guess is that the original intent of
I2C_RETRIES was to workaround these cases, rather than addressing the
(legitimate, according to you) possibility that an I2C device wouldn't
ack its own address temporarily. But I may be wrong...

> (...)
> > We have i2c_adapter.retries for that already, however it seems that the
> > code to handle retries is missing in most bus drivers. Only
> > i2c-algo-bit, i2c-algo-pcf, i2c-pxa and i2c-s3c2410 appear to implement
> > it, and not even the same way: the former two only retry if the address
> > byte is not acked, while the latter two retry on any failure.
> 
> So it seems like i2c-pxa and i2c-s3c2410 should at least be
> bugfixed to match the I2C_RETRIES semantics (address only).

Agreed. OTOH, it could be that some users of these drivers rely on this
deviant implementation, so this will need testing.

> (...)
> > Admittedly, if you are doing reads and expect them to fail (which is
> > also the case when we use zero-byte messages to probe for chip
> > presence) the retry mechanism is not so desirable and only slows things
> > down.
> 
> When you're probing for an SMBus device with a QUICK zero-byte
> message, a lack of response should be definitive.  I2C devices
> are allowed ignore the address stage if they're too busy.

We are not only probing for SMBus devices with zero-byte messages, but
also I2C devices (e.g. EEPROMs.) Still, I agree that we shouldn't retry
the probe. Either the device always replies to the probe and once is
enough to tell if it's there or not, or it may sometimes not reply and
no amount of retries is guaranteed to be sufficient. Such devices
should not be probed at all.

This alone is probably a good argument to get rid of the "automatic"
retry mechanism.

> (...)
> > There is a way: we can make this an i2c_client attribute or flag. just
> > like I2C_CLIENT_TEN sets I2C_M_TEN, I2C_CLIENT_RETRIES (2-bit flag)
> > could set I2C_M_RETRIES.
> 
> If the mechanism is needed, yes.  But as you noted, it's hardly
> supported at all ... so it's not being relied on, and thus wouldn't
> seem to need a replacement.

It is implemented in some drivers, including i2c-algo-bit which is
being used by many I2C bus drivers. So you can't say that's it's not
relied upon, it might as well be. Still, we can attempt to drop it and
see if users complain.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
