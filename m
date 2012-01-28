From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 28 Jan 2012 17:04:28 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (w83627ehf) Fix number of fans for NCT6776F
Message-Id: <20120128170428.GA3861@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327672138-5224-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1327672138-5224-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Sat, Jan 28, 2012 at 04:07:59AM -0500, Jean Delvare wrote:
> Hi Guenter,
> 
> On Fri, 27 Jan 2012 05:48:58 -0800, Guenter Roeck wrote:
> > NCT6776F can select fan input pins for fans 3 to 5 with a secondary set of
> > chip register bits. Check that second set of bits in addition to the first set
> > to detect if fans 3..5 are monitored.
> > 
> > Reported-by: C. Comren <ccomren@@gmail.com>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/hwmon/w83627ehf.c |   11 +++++++++++
> >  1 files changed, 11 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
> > index 0e0af04..c0ef1a3 100644
> > --- a/drivers/hwmon/w83627ehf.c
> > +++ b/drivers/hwmon/w83627ehf.c
> > @@ -1914,9 +1914,20 @@ w83627ehf_check_fan_inputs(const struct w83627ehf_sio_data *sio_data,
> >  		fan4min = 0;
> >  		fan5pin = 0;
> >  	} else if (sio_data->kind = nct6776) {
> > +		u8 val;
> 
> Please just use regval which is already declared.
> 
Sure.

> > +
> >  		fan3pin = !(superio_inb(sio_data->sioreg, 0x24) & 0x40);
> >  		fan4pin = !!(superio_inb(sio_data->sioreg, 0x1C) & 0x01);
> >  		fan5pin = !!(superio_inb(sio_data->sioreg, 0x1C) & 0x02);
> 
> A blank line here would improve readability.
> 
Ok.

> > +		/* Test secondary set of fan input select registers */
> > +		superio_select(sio_data->sioreg, W83627EHF_LD_HWM);
> > +		val = superio_inb(sio_data->sioreg, SIO_REG_ENABLE);
> > +		if (!fan3pin && (val & 0x80))
> > +			fan3pin = true;
> > +		if (!fan4pin && (val & 0x40))
> > +			fan4pin = true;
> > +		if (!fan5pin && (val & 0x20))
> > +			fan5pin = true;
> 
> I don't quite get the point of testing for !fan3pin, !fan4pin
> and !fan5pin. This adds code without changing the result.
> 
Logic was that I only need to check if the fans are connected to 90..92 if they are
not connected to 3..5. However, it looks like 90..92 take precedence, so
I think I have to check if the fans are connected to 90..92 first, and only
check if they are connected to 3..5 if they are not connected to 90..92.

Something like:

	fan3pin = 0;
	fan4pin = 0;
	fan5pin = 0;
	if (superio_inb(sio_data->sioreg, 0x27) & 0x80) {
                superio_select(sio_data->sioreg, W83627EHF_LD_HWM);
                regval = superio_inb(sio_data->sioreg, SIO_REG_ENABLE);
                fan3pin = !!(regval & 0x80);
                fan4pin = !!(regval & 0x40);
                fan5pin = !!(regval & 0x20);
        }
	if (!fan3pin)
		fan3pin = !(superio_inb(sio_data->sioreg, 0x24) & 0x40);
	if (!fan4pin)
		fan4pin = !!(superio_inb(sio_data->sioreg, 0x1C) & 0x01);
	if (!fan5pin)
  		fan5pin = !!(superio_inb(sio_data->sioreg, 0x1C) & 0x02);

Does that make sense ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
