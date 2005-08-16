From: lutchann@litech.org (Nathan Lutchansky)
Date: Tue, 16 Aug 2005 05:15:33 +0000
Subject: [lm-sensors] Re: [PATCH 1/5] call i2c_probe from i2c core
Message-Id: <20050816031454.GH24959@litech.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050815175106.GA24959@litech.org> <20050815175257.GB24959@litech.org> <20050815235531.2a7d2bb6.khali@linux-fr.org>
In-Reply-To: <20050815235531.2a7d2bb6.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>, Greg KH <greg@kroah.com>

On Mon, Aug 15, 2005 at 11:55:31PM +0200, Jean Delvare wrote:
> You should probably be using the --no-index option of quilt 0.42 (if you
> are using quilt as I presumed), as I heard Linus doesn't like these
> index lines in the patches he receives.

Ooh, thanks!

> >  	if (driver->flags & I2C_DF_NOTIFY) {
> >  		list_for_each(item,&adapters) {
> >  			adapter = list_entry(item, struct i2c_adapter, list);
> > -			driver->attach_adapter(adapter);
> > +			if (driver->attach_adapter)
> > +				driver->attach_adapter(adapter);
> > +			if (driver->detect_client && driver->address_data &&
> > +					((driver->class & adapter->class) ||
> > +						driver->class = 0))
> > +				i2c_probe(adapter, driver->address_data,
> > +						driver->detect_client);
> >  		}
> >  	}
> 
> Couldn't we check for the return value of driver->attach_adapter()? That
> way this function could conditionally prevent i2c_probe() from being
> run. This is just a random proposal, I don't know if some drivers would
> have an interest in doing that.

Yeah, I was thinking about that too, but I can't think of a reasonable
return code to use.  -1 for "don't probe"?  Or <0 for "fatal error,
don't touch this bus any more"?  Anyway, client drivers will probably
only use one of the two detection methods because if they need to
implement attach_adapter they can just call i2c_probe from there.

> Also, maybe we can put this new code in a separate function to be called
> from both i2c_add_adapter and i2c_add_driver, so as to not duplicate
> code? Or would this be too much overhead? It could be made inline then.
> Again, just a random thought.

Sure, I can do that.

> > --- linux-2.6.13-rc6+gregkh.orig/Documentation/i2c/writing-clients
> > +++ linux-2.6.13-rc6+gregkh/Documentation/i2c/writing-clients
> 
> Thanks for the documentation update. However, you didn't update
> i2c/porting-clients accordingly. Could you please?

I didn't think anybody was porting client drivers any more, but if
you're still updating that doc, I can too.  :-)  -Nathan
