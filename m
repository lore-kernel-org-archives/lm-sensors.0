From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: Preliminary version of the sis5595 driver for Linux 2.6
Message-Id: <7NGb8miO.1106668919.6306260.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050125003630.GA21545@bode.aurel32.net>
In-Reply-To: <20050125003630.GA21545@bode.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Aurelien,

> Here is a new version of the patch. As some of the changes you suggested
> also apply to the lm78 driver, you will also find a patch for it.

That's great. Comments about your lm78 patch:

> @@ -83,7 +83,6 @@
>  {
>  	if (rpm = 0)
>  		return 255;
> -	rpm = SENSORS_LIMIT(rpm, 1, 1000000);
>  	return SENSORS_LIMIT((1350000 + rpm * div / 2) / (rpm * div), 1, 254);
>  }

I don't think it is sufficient, as negative rpm values will now return
undetermined values. Replacing the "= 0" test with "<= 0" should
fix that, right?

>  {
>  	int nval = SENSORS_LIMIT(val, -128000, 127000) ;
> -	return nval<0 ? (nval-500)/1000+0x100 : (nval+500)/1000;
> +	return nval<0 ? -(nval-500)/1000 : (nval+500)/1000;
>  }

Hm, why did you add a "-" here? Looks fine without it (and broken with
it).

> -		if (!request_region(address, LM78_EXTENT, "lm78")) {
> +		if (!request_region(address, LM78_EXTENT, lm78_driver.name)) {

This one is already in 2.6.11-rc2, so don't do it or it'll collide.

About sis5595, I missed a detail:

> +      ERROR2:
> +	kfree(data);
> +      ERROR1:
> +	release_region(address, SIS5595_EXTENT);
> +      ERROR0:
> +	return err;

labels should be left-aligned. Also I think that labels named
"exit_free", "exit_release" and "exit" would be prefered.

And of course my comments on the lm78 patch apply to sis5595 also. Other
than that I'm fine with your code, feel free to send it to Greg once it
is generated against and tested with 2.6.11-rc2-mm1 (or wherever the
latest i2c subsystem is when you do it).

> > +int sis5595_detect(struct i2c_adapter *adapter, int address, int kind)
> >
> > With the current i2c_detect() implementation, detect function are not
> > supposed to return an error (non-zero value) on non-fatal errors such as
> > a missing device. Thus you should get rid of all "err = -ENODEV;".
>
> It seems almost all other i2c drivers do that, so I havent changed my
> patch yet. I have checked in the 2.6.11-rc2-mm1 patch, and it seems no
> change have been made about that. Is there something that is still to be
> done?

This was discussed some times ago, after Benjamin Judas reported a
problem when several chips are connected to a given bus and two or more
belong to the address range of a given driver. When the driver's detect
function returns -ENODEV on misdetection, i2c_detect() will stop there
and the other chips have no chance to ever get probed. Mark Hoffman
identified the problem here:

http://archives.andrew.net.au/lm-sensors/msg28237.html

I have since fixed all i2c drivers in lm_sensors/CVS, but for 2.6 Mark
has a plan to change the way i2c_detect() works, so I left the drivers
untouched for now - but this *are* not correct at the moment for these
drivers, as you suspected. It just happens not to affect to many people,
which is why we disn't rush on fixing them.

Note that ISA-only chip drivers (such as the sis5595) are almost
unaffected because they always have a single address anyway - so it
admittedly doesn't matter much what you do here (except for the initial
i2c_is_isa_bus() test which should really NOT return an error.)

Thanks,
--
Jean Delvare
