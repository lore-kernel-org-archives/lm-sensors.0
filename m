From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 04 Nov 2005 11:26:29 +0000
Subject: [lm-sensors] PEC support in i2c/lm_sensors CVS
Message-Id: <8g9OcsGg.1131099242.2561290.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051030171335.34da6461.khali@linux-fr.org>
In-Reply-To: <20051030171335.34da6461.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Mark,

On 2005-11-04, Mark M. Hoffman wrote:
> Since you insist, heh... there was this bit from lm90.c for ADM1032 PEC:
>
> +/* The ADM1032 supports PEC but not on write byte transactions, so we need
> +   to explicitely ask for a transaction without PEC. */
> +static inline s32 adm1032_write_byte(struct i2c_client *client, u8 value)
> +{
> +	return i2c_smbus_xfer(client->adapter, client->addr,
> +			      client->flags & ~I2C_CLIENT_PEC,
> +			      I2C_SMBUS_WRITE, value, I2C_SMBUS_BYTE, NULL);
> +}
>
> It's a bit of a hack, but in practice I hope it won't be necessary very
> often.  Although, here we have the very first PEC capable device requiring
> that.  But I don't have a better idea, so I wasn't going to mention it.

I have to agree it's not exactly elegant, and I totally share your
analysis. I am waiting to see more chips implementing PEC to decide what
to do with this case and similar ones.

I fear that all chips will have the problem with this one transaction
type, because SMBus Send Byte with PEC is the same as SMBus Write Byte
without PEC. I consider this a specification weakness. Due to the fact
that PEC must always be optional as per the same specification, any chip
supporting SMBus Write Byte and SMBus Send Byte with the same
"command" value can obviously not support the latter with PEC.

Anyway, this is a side problem. The old PEC implementation would not have
handled this case better as far as I can see, so this is no regression.

> No worries - I don't see anything glaring.  And there's one user for which
> it works, right?  Not that I think it will, but if it did need to be
> reworked again later, so be it.

That one user is me, so I'm not sure if it counts ;) I am still waiting
for a "works for me too" type of report.

> (Except that, by this time next year, maybe we should deep-freeze the I2C
> CVS tree, delete all the kernel 2.4 bits in lm_sensors2, and advance the
> version to 3.0.0)

This implies that, by that time, the sysfs interface in Linux 2.6 will
have been fully stabilized and completed in a totally chip-independant
way, and we will have a brand new, essentially chip-independant library
to interface with it. I wish it really happens, but it doesn't sound
too realistic with the little manpower we have available at the moment.

Thanks,
--
Jean Delvare
