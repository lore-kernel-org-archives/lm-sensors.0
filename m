From: atull <atull@opensource.altera.com>
Date: Sat, 23 Aug 2014 00:31:12 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/2] pmbus: add regulator support
Message-Id: <alpine.DEB.2.10.1408221927370.2334@shineypoop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1408741894-24879-1-git-send-email-atull@opensource.altera.com> <1408741894-24879-2-git-send-email-atull@opensource.altera.com> <20140822214417.GC24407@sirena.org.uk>
In-Reply-To: <20140822214417.GC24407@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: linux@roeck-us.net, jdelvare@suse.de, lm-sensors@lm-sensors.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, delicious.quinoa@gmail.com, dinguyen@opensource.altera.com, yvanderv@opensource.altera.com

On Fri, 22 Aug 2014, Mark Brown wrote:

> On Fri, Aug 22, 2014 at 04:11:33PM -0500, atull@opensource.altera.com wrote:
> 
> > +	if (pdata && pdata->reg_init_data) {
> > +		config.init_data = pdata->reg_init_data;
> > +	} else {
> > +		config.init_data = of_get_regulator_init_data(dev, np);
> > +		if (!config.init_data)
> > +			return -ENOMEM;
> > +	}
> 
> It should be fine to start with no init data - just let the regulator
> core worry about it.  This will allow users to read back the state even
> if they can't change anything which is useful for system bringup or
> general debugging.
> 

of_get_regulator_init_data() will only have an error if it cannot alloc 
the regulator_init_data struct.  That's why I did -ENOMEM.  If there
is no platform data and nothing about the regulator in the device tree, we 
should end up with a zeroed out regulator_init_data.

Thanks for the review.

Alan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
