From: Jean Delvare <jdelvare@suse.de>
Date: Mon, 12 May 2014 17:03:27 +0000
Subject: Re: [lm-sensors] [PATCH] drivers/hwmon/emc1403.c: add support for emc14x2
Message-Id: <20140512190327.4f65c90a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140512123409.GB16252@dashie>
	<20140512161415.GA16770@roeck-us.net>
In-Reply-To: <20140512161415.GA16770@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Josef Gajdusek <atx@atx.name>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Mon, 12 May 2014 09:14:15 -0700, Guenter Roeck wrote:
> On Mon, May 12, 2014 at 02:34:09PM +0200, Josef Gajdusek wrote:
> >  static const struct i2c_device_id emc1403_idtable[] = {
> > -	{ "emc1403", 0 },
> > -	{ "emc1404", 1 },
> > -	{ "emc1423", 0 },
> > -	{ "emc1424", 1 },
> > +	{ "emc1402", emc1402 },
> > +	{ "emc1403", emc1403 },
> > +	{ "emc1404", emc1404 },
> > +	{ "emc1422", emc1402 },
> > +	{ "emc1423", emc1403 },
> > +	{ "emc1424", emc1404 },
> 
> Wonder if we should list the emc141x chips here. Jean, any thoughts ?

Yes we should, so that people can declare the right chip in platform
files, device tree etc. We can map the additional names to existing
types if the chips are fully compatible.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
