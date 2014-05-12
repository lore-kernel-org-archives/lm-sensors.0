From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 12 May 2014 18:47:27 +0000
Subject: Re: [lm-sensors] [PATCH] drivers/hwmon/emc1403.c: add support for emc14x2
Message-Id: <20140512184727.GA9003@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140512123409.GB16252@dashie>
 <20140512161415.GA16770@roeck-us.net>
 <20140512190327.4f65c90a@endymion.delvare>
In-Reply-To: <20140512190327.4f65c90a@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <jdelvare@suse.de>
Cc: Josef Gajdusek <atx@atx.name>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Mon, May 12, 2014 at 07:03:27PM +0200, Jean Delvare wrote:
> On Mon, 12 May 2014 09:14:15 -0700, Guenter Roeck wrote:
> > On Mon, May 12, 2014 at 02:34:09PM +0200, Josef Gajdusek wrote:
> > >  static const struct i2c_device_id emc1403_idtable[] = {
> > > -	{ "emc1403", 0 },
> > > -	{ "emc1404", 1 },
> > > -	{ "emc1423", 0 },
> > > -	{ "emc1424", 1 },
> > > +	{ "emc1402", emc1402 },
> > > +	{ "emc1403", emc1403 },
> > > +	{ "emc1404", emc1404 },
> > > +	{ "emc1422", emc1402 },
> > > +	{ "emc1423", emc1403 },
> > > +	{ "emc1424", emc1404 },
> > 
> > Wonder if we should list the emc141x chips here. Jean, any thoughts ?
> 
> Yes we should, so that people can declare the right chip in platform
> files, device tree etc. We can map the additional names to existing
> types if the chips are fully compatible.
> 
The chips are not only compatible, the even have the same device IDs.
Maybe I missed it, but I did not find a difference.

I'll add another patch to my list.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
