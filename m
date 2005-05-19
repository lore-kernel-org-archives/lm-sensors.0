From: mporter@kernel.crashing.org (Matt Porter)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: Fix for i2c-ibm_iic.c
Message-Id: <20040412110956.B21071@home.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1081771172.11592.268.camel@uganda>
In-Reply-To: <1081771172.11592.268.camel@uganda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Apr 12, 2004 at 10:43:06AM -0700, Eugene Surovegin wrote:
> On Mon, Apr 12, 2004 at 03:59:32PM +0400, Evgeniy Polyakov wrote:
> > Attached diff against 2.4 kernel fixes "new" (for i2c-ibm_iic) i2c
> > initalization path.
> > This i2c adapter can't understand commands with zero length so it
> > doesn't recognize SMBUS_QUICK command and none chip can be attached to
> > this. Patch fixes this cruft.
> > Tested on ppc32 with max663x chip attached.
> > 
> > Please review and commit.
> 
> Well, this doesn't look correct.
> Could you explain what are you trying to do? Also, why did you change debugging 
> macros?
> 
> Chip doesn't support 0-length transactions, and your code trying to start 1-byte 
> transaction without writing any data to the output FIFO.
> 
> IBM IIC is broken enough and I don't see any point in such hacks.
> 
> There is another patch I made for MV guys a month ago 
> (http://kernel.ebshome.net/iic_0_len-2.4.diff, 
> http://kernel.ebshome.net/iic_0_len-2.6.diff). 
> 
> It restores _incorrect_ old driver behavior and most probably I'll send that 
> version upstream (I'm still waiting for OK from them).

I just re-pinged the folks that are supposed to test this out on their
lm75 equipped 4xx board...they never replied to my previous request
for feedback. Hopefully, I'll hear something back soon.  In any case,
if this works for Evgeniy, then it should be ok since he is hitting
the same problem.

-Matt
