From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 14 Sep 2010 16:08:13 +0000
Subject: Re: [lm-sensors] [PATCH v2 6/7] hwmon: (lm90) Add support for
Message-Id: <20100914160813.GC5371@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1284038750-8833-1-git-send-email-guenter.roeck@ericsson.com>
 <1284038750-8833-7-git-send-email-guenter.roeck@ericsson.com>
 <20100914135253.6f218514@hyperion.delvare>
In-Reply-To: <20100914135253.6f218514@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Jean,

On Tue, Sep 14, 2010 at 07:52:53AM -0400, Jean Delvare wrote:
> Hi Guenter,
> 
> On Thu, 9 Sep 2010 06:25:49 -0700, Guenter Roeck wrote:
> > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > ---
> >  Documentation/hwmon/lm90 |   13 ++++++-----
> >  drivers/hwmon/lm90.c     |   51 ++++++++++++++++++++++++++++++++++-----------
> >  2 files changed, 45 insertions(+), 19 deletions(-)
> > (...)
> > @@ -94,7 +94,7 @@ static const unsigned short normal_i2c[] = {
> >  	0x18, 0x19, 0x1a, 0x29, 0x2a, 0x2b, 0x4c, 0x4d, 0x4e, I2C_CLIENT_END };
> >  
> >  enum chips { lm90, adm1032, lm99, lm86, max6657, adt7461, max6680, max6646,
> > -	w83l771 };
> > +	w83l771, max6659 };
> 
> As the numbers are internal only, it might make sense to group max6657
> and max6659 together for better readability.
> 
> No other comment, other than the patch ordering (or merging) issue
> already pointed out in patch 5/7.
> 
I made all changes as suggested, and tested the resulting code. Looks good so far.

Once I get your comments for patch #7, I'll send you another set of patches.
It will be the complete set for consistency; also I had a couple of conflicts
due to the changes in #2.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
