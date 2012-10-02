From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 02 Oct 2012 04:35:00 +0000
Subject: Re: [lm-sensors] [PATCH v2 2/2] hwmon: (ads7828) add support for ADS7830
Message-Id: <20121002043500.GA3247@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1349133384-5181-1-git-send-email-vivien.didelot@savoirfairelinux.com>
 <1349133384-5181-2-git-send-email-vivien.didelot@savoirfairelinux.com>
 <20121002012007.GC2437@roeck-us.net>
 <1349148501.5876.22.camel@trivette>
In-Reply-To: <1349148501.5876.22.camel@trivette>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc: lm-sensors@lm-sensors.org, Guillaume Roguez <guillaume.roguez@savoirfairelinux.com>, Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org, Steve Hardy <shardy@redhat.com>

On Mon, Oct 01, 2012 at 11:28:21PM -0400, Vivien Didelot wrote:
> Hi Guenter,
> 
Hi Vivien,

[ ... ]

> > > +			} else {
> > > +				dev_dbg(&client->dev, "doesn't look like an "
> > > +					"ADS7828 compatible device\n");
> > 
> > WARNING: quoted string split across lines
> > #190: FILE: drivers/hwmon/ads7828.c:196:
> > +                               dev_dbg(&client->dev, "doesn't look like an "
> > +                                       "ADS7828 compatible device\n");
> Hum ok, so the reason for that is that it breaks the ability to grep a
> string... Makes sense.
> > 
> > Better:
> > 				dev_dbg(&client->dev,
> > 					"doesn't look like an ADS7828 compatible device\n");
> This exceeds 80 chars, but I'll find a shorter message.

That is ok nowadays if it is due to a quoted string.

Guenter 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
