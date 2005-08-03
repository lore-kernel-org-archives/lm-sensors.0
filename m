From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Wed, 03 Aug 2005 02:08:56 +0000
Subject: [lm-sensors] [PATCH] lm93 driver for 2.6, second try
Message-Id: <20050803000840.GA24464@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <1122934191.32459.18.camel@wiz.dev.aspsys.com>
In-Reply-To: <1122934191.32459.18.camel@wiz.dev.aspsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Eric:

> On Tue, 2005-08-02 at 16:33, Mark M. Hoffman wrote:
> > CVS/lm93.c, line 450:
> > 
> > 	result = i2c_smbus_read_block_data(client,
> > 
> > Your patch, at the equivalent place:
> > 
> > 	result = i2c_smbus_read_i2c_block_data(client,
> > 
> > Those two aren't synonyms - you changed the transaction type.  Why?

* Eric J. Bowersox <ericb@aspsys.com> [2005-08-02 17:08:45 -0600]:
> Well, for one thing, the function i2c_smbus_read_block_data doesn't seem
> to exist anymore, though its twin, i2c_smbus_write_block_data, does. 
> (See: include/linux/i2c.h, lines 99-103, in 2.6.13-rc3-mm3.)
>
> You're right that there is a difference in the underlying
> implementations, but the old (and presumably correct, in this instance)
> function appears to have been removed sometime between 2.6.5 and
> 2.6.13-rc3-mm3.  Anyone have any idea why that was done?  As a

Yes, I remembered that just as your message was coming in.  It was
removed because there were no in-kernel users, so it was considered
bloat.

> workaround, should I basically create my own implementation of the old
> i2c_smbus_read_block_data by calling i2c_smbus_xfer myself?

No, please create a separate patch that puts it back into i2c-core
where it belongs.

> > (You also reminded me that i2c-i801.c in 2.6.x should get synced up
> > a bit with its twin in lm-sensors CVS.  I'll do that later.)
> 
> Yeah, in particular, in the "prochot" reporting, I noticed that you
> seemed to be reporting the "average" return value twice.  In
> kernel/chips/lm93.c, lines 1113-1115, it reads:
> [...]

I really meant the i2c-i801 driver, not the lm93.  But, if you found
some bug in CVS/lm93.c then by all means send me a patch and I'll 
commit it.  I still haven't been able to review your port closely
yet, sorry.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

