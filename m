From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 08 Sep 2010 10:28:16 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add support for max6695 and max6696
Message-Id: <20100908102816.GA10676@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1283639675-31714-1-git-send-email-guenter.roeck@ericsson.com>
 <20100906181229.2e25db07@hyperion.delvare>
In-Reply-To: <20100906181229.2e25db07@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Jean,

On Mon, Sep 06, 2010 at 12:12:29PM -0400, Jean Delvare wrote:
> Hi Guenter,
> 
> On Sat, 4 Sep 2010 15:34:35 -0700, Guenter Roeck wrote:
> > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > ---
> > To apply this patch, the previously submitted lm90 cleanup patch has to be
> > applied first.
> >
> > My main concern with this patch is the chip detection code, specifically if it
> > is able to safely distinguish between MAX6680/81 and MAX6695/96.
> > Would be great to get some test coverage from a system with one of those chips.
> 
> Unfortunately I don't have any of these Maxim chips at hand. I have an
> ADM1032 but it won't offer much coverage obviously. And I have dumps of
> Maxim chips, but the real chips behave differently, so it's of little
> help.
> 
Do you by any chance have register dumps of max6657/58/59 ?

max6659 also supports a 3rd upper limit. Turns out it is convenient to add support
for this limit first before adding support for max6696. To do that, I'll need
to be able to distinguish between max6657/58 and max6659. My thought is to check
for the address and if register 0x16 exists.

Also, do you happen to remember why address 0x4e for max6659 is not supported by the driver ?
The code only says that it isn't supported, and it does not detect it, but there
is not reason. sensors-detect does detect it at address 0x4e.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
