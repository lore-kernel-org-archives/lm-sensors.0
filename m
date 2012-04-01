From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 01 Apr 2012 17:05:22 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/3] hwmon: (it87) Add support for IT8782F and IT8783E/F
Message-Id: <20120401170522.GA31875@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1332651633-23560-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1332651633-23560-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Sun, Apr 01, 2012 at 08:54:29AM -0400, Jean Delvare wrote:
> Hi Guenter,
> 
> On Sat, 24 Mar 2012 22:00:31 -0700, Guenter Roeck wrote:
> >  		reg = superio_inb(IT87_SIO_GPIO3_REG);
> > -		if (sio_data->type = it8721 || sio_data->type = it8728) {
> > +		if (sio_data->type = it8721 || sio_data->type = it8728 ||
> > +		    sio_data->type = it8782) {
> >  			/*
> > -			 * The IT8721F/IT8758E doesn't have VID pins at all,
> > -			 * not sure about the IT8728F.
> > +			 * IT8721F, IT8758E, and IT8782F don't have VID pins
> 
> "IT8721F/IT8758E" is written this way on purpose throughout the whole
> driver and documentation, because they are "the same chip" (same device
> ID.)
> 
> > +			 * at all, not sure about the IT8728F.
> >  			 */
> >  			sio_data->skip_vid = 1;
> >  		} else {
> > @@ -1733,8 +1793,12 @@ static int __init it87_find(unsigned short *address,
> >  		 * configured, even though the IT8720F datasheet claims
> >  		 * that the internal routing of VCCH to VIN7 is the default
> >  		 * setting. So we force the internal routing in this case.
> > +		 *
> > +		 * On IT8782F, VIN7 is multiplexed with one of the UART6 pins.
> > +		 * If UART6 is enabled, re-route VIN7 to the internal divider.
> >  		 */
> > -		if (sio_data->type = it8720 && !(reg & (1 << 1))) {
> > +		if ((sio_data->type = it8720 && !(reg & (1 << 1))) ||
> > +		    (sio_data->type = it8782 && (reg & (1 << 2)))) {
> 
> I'd like to see this done a little differently. Here you'll output the
> notice message even if VIN7 was already properly routed. That's not
> fair. I'd prefer:
> 
> 		if ((sio_data->type = it8720 ||
> 		    (sio_data->type = it8782 && (reg & (1 << 2))))
> 		    && !(reg & (1 << 1))) {
> 
> so you only write to the register and print the notice when needed.
> 
> >  			reg |= (1 << 1);
> >  			superio_outb(IT87_SIO_PINX2_REG, reg);
> >  			pr_notice("Routing internal VCCH to in7\n");
> > @@ -1823,6 +1887,8 @@ static int __devinit it87_probe(struct platform_device *pdev)
> >  		"it8720",
> >  		"it8721",
> >  		"it8728",
> > +		"it8782",
> > +		"it8783",
> >  	};
> >  
> >  	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
> 
> Other than these two minor things, patch looks good (the few remarks I
> had happen to be addressed by the later patches in the series.) So you
> can add:
> 
> Acked-by: Jean Delvare <khali@linux-fr.org>
> 
Thanks a lot for the review.

Fixed, and applied.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
