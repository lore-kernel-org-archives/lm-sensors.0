From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 14 Aug 2010 16:20:29 +0000
Subject: Re: [lm-sensors] [PATCH 4/6] hwmon: (pc87427) Add support for the
Message-Id: <20100814162029.GA11414@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100811171154.40b1ade5@hyperion.delvare>
In-Reply-To: <20100811171154.40b1ade5@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Aug 14, 2010 at 08:40:05AM -0400, Jean Delvare wrote:
> Hi Guenter,
> 
> On Thu, 12 Aug 2010 10:28:44 -0700, Guenter Roeck wrote:
> > On Wed, 2010-08-11 at 11:11 -0400, Jean Delvare wrote:
> > > The second logical device contains the voltage and temperature
> > > registers. We have to extend the driver to support a second logical
> > > device before we can add support for these features.
> > > 
> > > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > 
> > Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > 
> > Minor question below.
> 
> Thanks again for the detailed review!
> 
> > > @@ -675,16 +716,13 @@ static int __devinit pc87427_probe(struc
> > >  		goto exit;
> > >  	}
> > >  
> > > -	/* This will need to be revisited when we add support for
> > > -	   temperature and voltage monitoring. */
> > > -	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
> > > -	if (!request_region(res->start, resource_size(res), DRVNAME)) {
> > > -		err = -EBUSY;
> > > -		dev_err(&pdev->dev, "Failed to request region 0x%lx-0x%lx\n",
> > > -			(unsigned long)res->start, (unsigned long)res->end);
> > > +	data->address[0] = sio_data->address[0];
> > > +	data->address[1] = sio_data->address[1];
> > > +	res_count = (data->address[0] != 0) + (data->address[1] != 0);
> > > +
> > 
> > Is it well defined that the numerical result of a comparison is either 0
> > or 1 ?
> 
> Honestly, I didn't know for sure, but a colleague of mine (thanks
> Lars!) confirmed it, quoting ISO/IEC 9899:
> 
> 6.5.9 Equality operators
> 	The = (equal to) and != (not equal to) operators are analogous
> 	to the relational operators except for their lower precedence.
> 	Each of the operators yields 1 if the specified relation is true
> 	and 0 if it is false. The result has type int.  For any pair of
> 	operands, exactly one of the relations is true.
> 
> So my code should be OK, even if it may not have the stylistic
> preference of all developers out there ;)
> 
Nice. Something to keep in mind...

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
