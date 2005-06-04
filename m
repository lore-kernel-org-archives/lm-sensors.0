From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 04 Jun 2005 18:23:56 +0000
Subject: [lm-sensors] Re: [PATCH 2.6.12-rc5-mm1 3/3] i2c: modify sensors
Message-Id: <20050604182428.0e55eb4d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050602033727.GD4906@jupiter.solarsys.private>
In-Reply-To: <20050602033727.GD4906@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark, Greg,

> On Wed, Jun 01, 2005 at 11:37:27PM -0400, Mark M. Hoffman wrote:
> > @@ -37,6 +39,8 @@ static unsigned int normal_isa[] = { I2C
> >  /* Insmod parameters */
> >  SENSORS_INSMOD_8(adm1021, adm1023, max1617, max1617a, thmc10, lm84,
> >  gl523sm, mc1066);
> >  
> > +static int id;	/* increment once for every chip found */
> > +
> 
> You duplicate this logic in every driver.  Is it really needed?  How
> about having the "bus id" be unique for all hwmon devices?  That way,
> no id varible is needed, and just the name of the device.  Then, in
> the hwmon core, you add the unique number to the front of the name.
> Something like:
> 	01-adm1021
> 	02-adm1025
> and so on.
> 
> Any thoughts?

I totally second Greg on that. I have been working hard to get the
i2c_client.id mess out of each i2c chip driver, let's not reintroduce it
again here.

Also, this original approach was dangerous, as it relied on the
cooperation of each driver for uniqueness of the IDs. This can easily
fail. We want the uniqueness guaranted by the hwmon class itself.

I am not even sure we want to display the name of the chips here, as it
is redundant with the "name" file in the target directory. I would go
with a simple number, this is the easiest and does the job.

Last, it would be nice if the IDs were reused on driver cycling, just
like the i2c bus IDs are. You should be able to pick the code in i2c-dev
and reuse it in the hwmon class.

Thanks,
-- 
Jean Delvare
