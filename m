From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Mon, 14 Apr 2008 18:37:58 +0000
Subject: Re: [lm-sensors] [PATCH 4/4]: sensors: Automatically scale
Message-Id: <20080414183758.GB7191@tree.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080331235441.GH7191@tree.beaverton.ibm.com>
In-Reply-To: <20080331235441.GH7191@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Apr 02, 2008 at 04:20:54PM +0200, Jean Delvare wrote:
> > Index: lm-sensors-3.0.0/lib/sysfs.c
> > =================================> > --- lm-sensors-3.0.0.orig/lib/sysfs.c	2008-03-31 16:35:30.000000000 -0700
> > +++ lm-sensors-3.0.0/lib/sysfs.c	2008-03-31 16:35:46.000000000 -0700
> > @@ -155,10 +155,6 @@
> >  		return 1000;
> >  	case SENSORS_SUBFEATURE_FAN_INPUT:
> >  		return 1;
> > -	case SENSORS_SUBFEATURE_POWER_AVERAGE:
> > -		return 1000000;
> > -	case SENSORS_SUBFEATURE_ENERGY_INPUT:
> > -		return 1000000;
> >  	case SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL:
> >  		return 1000;
> >  	}
> 
> This revert was certainly not meant to be.

Actually, it was--my intent for the autoscale functionality was that
this static translation goes away and programs are left to scale the raw
value as they see fit.

That said, I can see that it would be better for libsensors to export
values in a prefix-less unit and _then_ programs can autoscale as they
desire.  I'll make it do that.

> I'm a bit surprised, I expected 1e-6 for uW, 1e-3 for mW, 0 for W, etc?
> Does your code actually output correct values? Or course you would then
> have to adjust your algorithm as you would no longer be able to use 0
> as a terminator - but that's easy to work around.

The numeric figure is the upper bound for using that unit--if the number
you're trying to autoscale is less than the upper bound, you can use the
unit; otherwise, keep going.  Hence 1e-3 for uW, 1 for mW, and 1e3 for W
once libsensors starts exporting raw values again.

Also, zero works as a terminator as long as all entries in the
table represent numeric powers.

> This table is really the same as power_scales with just W becoming J. I
> think it would be better to have a single table for all units, and to
> add the unit symbol on the fly. That way we won't need to add another
> table if we ever want to automatically scale values expressed in
> another unit.

I'll move the table into the scale function, then.  That will enable me
to ensure that zero works as a terminator.

--D

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
