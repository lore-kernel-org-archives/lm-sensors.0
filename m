From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 08 Jul 2012 10:21:10 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon: (acpi_power_meter) Fix unintentional integer overflow
Message-Id: <20120708122110.54fbf3a6@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1340287015-14008-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1340287015-14008-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Sat, 7 Jul 2012 21:48:57 -0700, Guenter Roeck wrote:
> On Sat, Jul 07, 2012 at 04:48:34PM +0200, Jean Delvare wrote:
> > On Thu, 21 Jun 2012 06:56:53 -0700, Guenter Roeck wrote:
> > > Expression with two integer variables is calculated as integer before it is
> > > converted to u64. This may result in an integer overflow. Fix by declaring
> > > the constant as ULL.
> > > 
> > > This patch addresses Coverity #200596: Unintentional integer overflow.
> > > 
> > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > ---
> > >  drivers/hwmon/acpi_power_meter.c |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
> > > index 9a0821f1..c8ac1c6 100644
> > > --- a/drivers/hwmon/acpi_power_meter.c
> > > +++ b/drivers/hwmon/acpi_power_meter.c
> > > @@ -434,7 +434,7 @@ static ssize_t show_val(struct device *dev,
> > >  		if (resource->trip[attr->index - 7] < 0)
> > >  			return sprintf(buf, "unknown\n");
> > >  
> > > -		val = resource->trip[attr->index - 7] * 1000;
> > > +		val = resource->trip[attr->index - 7] * 1000ULL;
> > >  		break;
> > >  	default:
> > >  		BUG();
> > 
> > That's one way to fix it... Me, I wonder why resource->trip is an
> > arrays of ints, when every other power value handled by the driver is a
> > u64. The trip values end up feeding acpi objects in set_acpi_trip,
> > where 64-bit values would be handled properly. So I don't know much
> > about this driver and I'm not using it, but maybe making trip values
> > 64-bit would be a better fix. Then you still have the problem of signed
> > vs. unsigned, as currently trip = -1 means unset, but this is probably
> > easy to solve.
> 
> It is not needed and would just consume memory,

I don't know how you can be sure of that, but if this is the case then
I agree your patch is good to go.

> and having to add even more code
> and maybe variables to handle the not-set case does not sound very compelling
> to me either.

You could use s64 and keep -1 for unset, or u64 and 0 or ULLONG_MAX for
unset; no need for extra variables. But if you're sure it's not needed,
we can keep the code as it is.

> > Also note that the trip values are gathered from sysfs using kstrtoul,
> > so a value between 0x80000000 and 0xffffffff would be silently stored
> > as a negative number. Maybe worth fixing...
> 
> The code in set_trip ensures that stored values are not larger than INT_MAX.
> Am I missing something ?

No, I was. I hadn't seen the patch "hwmon: (acpi_power_meter) Cleanup
and optimizations" in your hwmon-staging tree. This indeed solves my
above concern.

> > And I also see that kstrtoul is used for cap and avg_interval, while
> > they are stored as u64 in struct acpi_power_meter_resource. No overflow
> > here, but an arbitrary limitation on what values the user can set.
> 
> My understanding is that acpi_evaluate_integer() actually enforces "real"
> limits. Maybe I am wrong, though. Either case, that would be a separate patch.

Not sure what you call "real" limits in this context, but anyway, if
64-bit values are supposed to be possible, then kstrtoull should be
used instead of kstrtoul. There's no way acpi_evaluate_integer() can
work around this afterward. Still, I agree it would be a separate
patch, if anyone cares.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
