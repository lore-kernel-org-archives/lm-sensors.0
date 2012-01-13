From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 13 Jan 2012 11:40:32 +0000
Subject: Re: [lm-sensors] [PATCH v2 2/2] hwmon: (lm63) Add sensor type attribute for external sensor on LM961
Message-Id: <20120113114032.GA22249@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326407015-7181-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1326407015-7181-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Jan 13, 2012 at 03:47:10AM -0500, Jean Delvare wrote:
> On Thu, 12 Jan 2012 14:23:35 -0800, Guenter Roeck wrote:
> > On LM96163, the external temperature sensor type is configurable to
> > either a thermal diode or a 3904 transistor. The chip reports a wrong
> > temperature if misconfigured. Add writable attribute to support it.
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > v2:
> > - snprintf -> sprintf
> > - set temp sensor type to 1(CPU diode) instead of 3 (thermal diode) if trutherm
> >   is enabled
> > - return error code from kstrtoul()
> > - When configuring the diode type, only set trutherm enable bit
> > - When detecting configured diode type, only check trutherm enable bit
> > - Document that configuring the thermal sensor type is supported for LM96163
> 
> I don't see such documentation addition. Forgot to add the file to the
> patch?
> 
That I did.

> >  drivers/hwmon/lm63.c |   50 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 50 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
> > (...)
> > +	reg = i2c_smbus_read_byte_data(client, LM96163_REG_TRUTHERM) & ~0x02;
> > +	i2c_smbus_write_byte_data(client, LM96163_REG_TRUTHERM,
> > +				  reg | data->trutherm ? 0x02 : 0x00);
> 
> This lacks parentheses to do the right thing. | has higher precedence
> than ?:. It works by chance because reg has value 0 in practice.
> 
Sigh. You'll get another one in a minute.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
