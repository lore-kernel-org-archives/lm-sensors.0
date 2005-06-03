From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Fri, 03 Jun 2005 06:00:44 +0000
Subject: [lm-sensors] Re: [PATCH 2.6.12-rc5-mm1 3/3] i2c: modify sensors
Message-Id: <20050603040007.GC21665@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050602033727.GD4906@jupiter.solarsys.private>
In-Reply-To: <20050602033727.GD4906@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg:

* Greg KH <greg@kroah.com> [2005-06-01 23:13:06 -0700]:
> On Wed, Jun 01, 2005 at 11:37:27PM -0400, Mark M. Hoffman wrote:
> > @@ -37,6 +39,8 @@ static unsigned int normal_isa[] = { I2C
> >  /* Insmod parameters */
> >  SENSORS_INSMOD_8(adm1021, adm1023, max1617, max1617a, thmc10, lm84, gl523sm, mc1066);
> >  
> > +static int id;	/* increment once for every chip found */
> > +
> 
> You duplicate this logic in every driver.  Is it really needed?  How
> about having the "bus id" be unique for all hwmon devices?  That way, no
> id varible is needed, and just the name of the device.  Then, in the
> hwmon core, you add the unique number to the front of the name.
> Something like:
> 	01-adm1021
> 	02-adm1025
> and so on.
> 
> Any thoughts?

Yeah, that looks reasonable [1].  Ultimately, libsensors isn't going to care
about that name; it will grab all the info it needs through the device link.
It also renders the first patch in the set unnecessary - you can apply that
seperately if you want it at all.

Again, hold up on sending through to -mm and I'll fix this up.

[1] I personally prefer more leading zeros, or better yet none at all.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

