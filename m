From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Date: Tue, 04 Sep 2012 19:42:16 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: add Maxim MAX197 support
Message-Id: <1346787736.17786.5.camel@trivette>
List-Id: <lm-sensors.vger.kernel.org>
References: <1346377377-24717-1-git-send-email-vivien.didelot@savoirfairelinux.com>
	 <20120831160439.GA5756@roeck-us.net> <5041D5DF.7060402@metafoo.de>
	 <20120902145101.GA8306@roeck-us.net>
	 <1346770948.6243.3.camel@anish-Inspiron-N5050>
	 <20120904172034.GA17884@roeck-us.net>
In-Reply-To: <20120904172034.GA17884@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: anish kumar <anish198519851985@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, lm-sensors@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org

Hi,

On Tue, 2012-09-04 at 10:20 -0700, Guenter Roeck wrote:
> > > > > Applied to -next.
> > > > > 
> > > > 
> > > > Hm, now it's probably to late, but for this kind of general
> purpose ADC the IIO
> > > > framework is in my opinion the better place to add support for
> it.
> > > > 
> > > Possibly. If someone writes an iio driver for it, and everyone
> agrees,
> > > we can drop it from hwmon at that time.
> > I can write one but unfortunately need some testing as I don't have
> this
> > hardware.
> 
> Vivien, any thoughts/comments/feedback ? 

I don't see any particular advantage of including it in the IIO
subsystem. However, if everyone agrees that it should be in the IIO
subsystem, and someone writes a driver for it, I might be able to test
it. Given my current schedule, it's likely to take some time though.

Thanks,
Vivien


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
