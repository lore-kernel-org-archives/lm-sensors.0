From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Sep 2010 14:34:07 +0000
Subject: Re: [lm-sensors] [PATCH v2 7/7] hwmon: (lm90) Add support for
Message-Id: <20100915163407.47e8de54@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1284038750-8833-1-git-send-email-guenter.roeck@ericsson.com>
	<1284038750-8833-8-git-send-email-guenter.roeck@ericsson.com>
	<20100915132029.4c708c7d@hyperion.delvare>
	<20100915142927.GB9707@ericsson.com>
In-Reply-To: <20100915142927.GB9707@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Wed, 15 Sep 2010 07:29:27 -0700, Guenter Roeck wrote:
> On Wed, Sep 15, 2010 at 07:20:29AM -0400, Jean Delvare wrote:
> > Would it be possible to simply place these functions at the right
> > location so that forward declarations are not needed? Ideally I would
> > like to get rid of all these forward declarations.
> > 
> I moved lm90_select_remote_channel() so the lm90_read_reg() declaration
> is no longer needed.
> 
> Code structure is such that sensor show/set functions come first, followed by
> "real" code. Unfortunately, that implies that local functions called from
> those functions have to be forward declarated.
> 
> We can move that around to avoid forward declarations, but I would prefer
> to do that in a separate patch if we decide to go that way.

Sure, fine with me.

> [...]
> > > +/*
> > > + * Additional attributes for devices with 3 temperature sensors
> > > + */
> > > +static SENSOR_DEVICE_ATTR_2(temp3_input, S_IRUGO, show_temp11, NULL, 0, 5);
> > > +static SENSOR_DEVICE_ATTR_2(temp3_min, S_IWUSR | S_IRUGO, show_temp11,
> > > +     set_temp11, 3, 6);
> > > +static SENSOR_DEVICE_ATTR_2(temp3_max, S_IWUSR | S_IRUGO, show_temp11,
> > > +     set_temp11, 4, 7);
> > > +static SENSOR_DEVICE_ATTR(temp3_crit, S_IWUSR | S_IRUGO, show_temp8,
> > > +     set_temp8, 6);
> > > +static SENSOR_DEVICE_ATTR(temp3_crit_hyst, S_IRUGO, show_temphyst, NULL, 4);
> > 
> > 4, really? Remote 2 critical limit is 6.
> > 
> I am impressed. Good catch.

Now you understand why it takes me so long to review patches. I
actually read them ;)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
