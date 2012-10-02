From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 02 Oct 2012 02:55:04 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/2] hwmon: (ads7828) driver cleanup
Message-Id: <20121002025504.GA3108@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1349133384-5181-1-git-send-email-vivien.didelot@savoirfairelinux.com>
 <20121002010705.GB2437@roeck-us.net>
 <1349144167.5876.13.camel@trivette>
In-Reply-To: <1349144167.5876.13.camel@trivette>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc: lm-sensors@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org, Steve Hardy <shardy@redhat.com>

On Mon, Oct 01, 2012 at 10:16:07PM -0400, Vivien Didelot wrote:
> Hi Guenter,
> 
[ ... ]
> > >  
> > > -/* Each client has this additional data */
> > > +/**
> > > + * struct ads7828_data - client specific data
> > > + * @hwmon_dev:		The hwmon device.
> > > + * @update_lock:	Mutex protecting updates.
> > > + * @valid:		Validity flag.
> > > + * @last_updated:	Last updated time (in jiffies).
> > > + * @adc_input:		ADS7828_NCH samples.
> > > + */
> > This isn't really an externally visible API, so I wonder if it provides value to
> > document it this way. No strong opinion, just wondering.
> I found the version below a bit cluttered, that's why I used the
> KernelDoc notation. Would you prefer something else, like right-aligned
> comments?

Tab aligned, maybe ? Not sure if that works out, though.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
