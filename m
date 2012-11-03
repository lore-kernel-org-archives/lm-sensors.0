From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 03 Nov 2012 21:46:54 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (it87) Add support for AMDTSI, and restrict sensor type configura
Message-Id: <20121103214654.GA23384@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1351960184-23005-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1351960184-23005-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Nov 03, 2012 at 09:11:52PM +0100, Jean Delvare wrote:
> On Sat,  3 Nov 2012 09:29:44 -0700, Guenter Roeck wrote:
> > Add support to detect and report AMDTSI temperature sensor types.
> > Only enable PECI and AMDTSI sensor selection if the chip is configured
> > for it.
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > Applies on top of the previously submitted patches.
> > Only tested with IT8728F and Intel CPU.
> > 
> > v2: Add AMDTSI support to IT8728F.
> > 
> >  drivers/hwmon/it87.c |   68 +++++++++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 62 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
> > index 6a1410b..ab5a8c5 100644
> > --- a/drivers/hwmon/it87.c
> > +++ b/drivers/hwmon/it87.c
> > (...)
> > @@ -2030,6 +2036,56 @@ static int __devinit it87_probe(struct platform_device *pdev)
> >  		break;
> >  	}
> >  
> > +	if (data->features & FEAT_TEMP_OLD_PECI) {
> > +		reg = it87_read_value(data, IT87_REG_VID);
> > +		switch ((reg >> 4) & 0x07) {
> > +		case 0x0:
> > +		default:
> > +			data->features &> > +			  ~(FEAT_TEMP_OLD_PECI | FEAT_TEMP_PECI);
> > +			break;
> > +		case 0x3:	/* PCH (IT8721F) */
> > +			if (data->features & FEAT_TEMP_PECI) {
> > +				data->features &= ~FEAT_TEMP_PECI;
> > +				data->ext_temp_type = 6;
> > +			} else {
> > +				data->features &= ~FEAT_TEMP_OLD_PECI;
> > +			}
> > +			break;
> > +		case 0x4:	/* AMDTSI */
> > +			data->ext_temp_type = 5;
> > +			break;
> > +		case 0x5:	/* SST slave */
> > +		case 0x6:	/* PECI */
> > +		case 0x7:	/* SST host */
> > +			if (data->features & FEAT_TEMP_PECI)
> > +				data->features &= ~FEAT_TEMP_OLD_PECI;
> > +			data->ext_temp_type = 6;
> > +			break;
> > +		}
> > +	} else if (data->features & FEAT_TEMP_PECI) {
> > +		reg = it87_read_value(data, IT87_REG_VID);
> > +		switch ((reg >> 4) & 0x03) {
> > +		case 0x0:	/* disabled */
> > +			/* Check if AMDTSI is enabled */
> > +			if (reg & 0x40) {
> > +				reg = it87_read_value(data,
> > +						      IT87_REG_AMDTSI_HSR);
> > +				if (reg & 0x40) {
> > +					data->ext_temp_type = 5;
> 
> I admit I don't quite get why ITE made these separate configuration
> bits when all it brings is the possibility to select a non-working
> combination...
> 
> I will also admit I'm kind of lost with the IT8728F. The datasheet
> suggests that the PCH temperature can be retrieved but there is no
> configuration bit to actually select it? Or if bit 6 of IT87_REG_VID
> supposed to do exactly that? And if so, where does the reading go?
> 
Oh, there is. Bit 6 of IT87_REG_VID = 1, and bit 6 of register 0x98
(IT87_REG_AMDTSI_HSR) = 0, and then there are a couple additional bits in
register 0x9e (as I just noticed, meaning this patch is incomplete and I'll
have to send you another version for AMDTSI support on IT8728F).
Bit 4/5 of register 0xa are irrelevant for PCH on IT8728F.

Or at least that is how I think it works. I can not test it on my board, 
so I did not even bother trying to add support for it. It gets tricky, since
there are now, at least potentially, two separate "external" temperature
sensors, so we would have to change the code structure for it. Maybe sometime
later, if someone has a board supporting it and we can test if it actually
works.

> BTW maybe we should come up with a different name for register 0x0A for
> newer chips, otherwise the code gets a little confusing. IT87_REG_IFSEL
> maybe?
> 
Ok with me. Since I have to create another version of the patch anyway,
I'll merge that in, unless you want a separate patch for it.

Thanks,
Guenter

> 
> > +					break;
> > +				}
> > +			}
> > +			data->features &= ~FEAT_TEMP_PECI;
> > +			break;
> > +		case 0x1:	/* SST slave */
> > +		case 0x2:	/* PECI */
> > +		case 0x3:	/* SST host */
> > +			data->ext_temp_type = 6;
> > +			break;
> > +		}
> > +	}
> 
> 
> -- 
> Jean Delvare
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
