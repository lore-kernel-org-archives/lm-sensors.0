From: ericb@aspsys.com (Eric J. Bowersox)
Date: Wed, 03 Aug 2005 01:09:45 +0000
Subject: [lm-sensors] [PATCH] lm93 driver for 2.6, second try
Message-Id: <1123024125.14749.41.camel@wiz.dev.aspsys.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1122934191.32459.18.camel@wiz.dev.aspsys.com>
In-Reply-To: <1122934191.32459.18.camel@wiz.dev.aspsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2005-08-02 at 16:33, Mark M. Hoffman wrote:
> "Hosation" - that's a new one.  You from up north eh? ;)

No, actually, a coworker of mine came up with that many years ago, in
the phrase "Enable hosation without representation." :-)

> CVS/lm93.c, line 450:
> 
> 	result = i2c_smbus_read_block_data(client,
> 
> Your patch, at the equivalent place:
> 
> 	result = i2c_smbus_read_i2c_block_data(client,
> 
> Those two aren't synonyms - you changed the transaction type.  Why?

Well, for one thing, the function i2c_smbus_read_block_data doesn't seem
to exist anymore, though its twin, i2c_smbus_write_block_data, does. 
(See: include/linux/i2c.h, lines 99-103, in 2.6.13-rc3-mm3.)

You're right that there is a difference in the underlying
implementations, but the old (and presumably correct, in this instance)
function appears to have been removed sometime between 2.6.5 and
2.6.13-rc3-mm3.  Anyone have any idea why that was done?  As a
workaround, should I basically create my own implementation of the old
i2c_smbus_read_block_data by calling i2c_smbus_xfer myself?

> (You also reminded me that i2c-i801.c in 2.6.x should get synced up
> a bit with its twin in lm-sensors CVS.  I'll do that later.)

Yeah, in particular, in the "prochot" reporting, I noticed that you
seemed to be reporting the "average" return value twice.  In
kernel/chips/lm93.c, lines 1113-1115, it reads:

                results[0] = data->prochot_max[nr];
                results[1] = data->block4[nr].avg;
                results[2] = data->block4[nr].avg;

I'm thinking that middle line (1114) should be more like:

                results[1] = data->block4[nr].cur;

At least if it's to be consistent with what the docs say that /proc file
should report.  (That actually threw me for awhile, and it's only in
this version of my own patch that I think I've got that reporting
correctly.  Not that it really concerns us here; we're more focused on
getting the basic sensor readings.)

					Eric

-- 
Eric J. Bowersox, Software Engineer     Aspen Systems, Inc.
<ericb@aspsys.com>                      3900 Youngfield Street
Tel: +01 303 431 4606 x113              Wheat Ridge, CO  80033, USA
Fax: +01 303 431 7196                   <http://www.aspsys.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: This is a digitally signed message part
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050803/e88fd670/attachment.bin
