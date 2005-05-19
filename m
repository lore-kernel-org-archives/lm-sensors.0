From: vsu@altlinux.ru (Sergey Vlasov)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: [BUG] i2c-viapro oops on bad SMBus Block Read
Message-Id: <20030806151031.3451d91a.vsu@altlinux.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030805210754.457c1946.vsu@altlinux.ru>
In-Reply-To: <20030805210754.457c1946.vsu@altlinux.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 6 Aug 2003 08:47:49 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> > > I have found a reproducible bug in i2c-viapro (lm_sensors-2.8.0).
> > > When the device replies to SMBus Block Read with an absurdly large
> > > length, this driver accepts it without checking and overruns the
> > > data buffer. Tried with VT8325 and VT82C686.
> > (...)
> > I'll commit this patch now.
> 
> The fix should use I2C_SMBUS_BLOCK_MAX as defined in linux/i2c.h.

Then the block write case should be modified too.

> Also, I think I'd prefer to return an error than to truncate silently,
> but that may be discussed.

I also think it would be better - I just followed the example in the
block write handling, which truncates the block.

> Also (just in case), isn't it possible to fix that at a lower level (in
> i2c-core maybe) so that we don't have to check it later in all drivers?

For reads, no - only the driver can check the length returned by the
controller before copying data into the buffer. For writes the check
can be made in i2c-core.
