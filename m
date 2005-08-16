From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 16 Aug 2005 14:13:02 +0000
Subject: [lm-sensors] Re: [PATCH 1/5] call i2c_probe from i2c core
Message-Id: <20050816141308.23bd2956.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050815175106.GA24959@litech.org>
	<20050815175257.GB24959@litech.org>
	<20050815235531.2a7d2bb6.khali@linux-fr.org>
	<20050816031454.GH24959@litech.org>
In-Reply-To: <20050816031454.GH24959@litech.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nathan Lutchansky <lutchann@litech.org>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>, Greg KH <greg@kroah.com>

Hi Nathan,

> > >  	if (driver->flags & I2C_DF_NOTIFY) {
> > >  		list_for_each(item,&adapters) {
> > >  			adapter = list_entry(item, struct i2c_adapter, list);
> > > -			driver->attach_adapter(adapter);
> > > +			if (driver->attach_adapter)
> > > +				driver->attach_adapter(adapter);
> > > +			if (driver->detect_client && driver->address_data &&
> > > +					((driver->class & adapter->class) ||
> > > +						driver->class = 0))
> > > +				i2c_probe(adapter, driver->address_data,
> > > +						driver->detect_client);
> > >  		}
> > >  	}
> > 
> > Couldn't we check for the return value of driver->attach_adapter()?
> > That way this function could conditionally prevent i2c_probe() from
> > being run. This is just a random proposal, I don't know if some
> > drivers would have an interest in doing that.
> 
> Yeah, I was thinking about that too, but I can't think of a reasonable
> return code to use.  -1 for "don't probe"?  Or <0 for "fatal error,
> don't touch this bus any more"?  Anyway, client drivers will probably
> only use one of the two detection methods because if they need to
> implement attach_adapter they can just call i2c_probe from there.

Oh well, on second thought you are probably right, there is little
benefit in implementing my proposal, and this will make the code more
complex. Let's just forget about it until someone actually needs it.

> I didn't think anybody was porting client drivers any more, but if
> you're still updating that doc, I can too.  :-)

I count 15 drivers [1] of the lm_sensors project that are still missing
from Linux 2.6. Maybe some of these will never be ported due to a lack
of interest, but I believe a good half will be (five ports are in
progress already.) So we need to keep the i2c/porting-client document
up-to-date for a few more months.

Thanks.

[1] adm1024, bmcsensors, ds1307, fscscy, lm93, matorb, max6650,
maxilife, mic74, mtp008, saa1064, smartbatt, thmc50, vt1211, vt8231.

-- 
Jean Delvare
