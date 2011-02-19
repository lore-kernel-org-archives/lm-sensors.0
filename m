From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 19 Feb 2011 20:46:40 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] Let Kconfig handle lis3lv02d
Message-Id: <20110219204640.GA1728@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110219182207.GB1038@ericsson.com>
In-Reply-To: <20110219182207.GB1038@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Feb 19, 2011 at 02:15:16PM -0500, Jean Delvare wrote:
[ ... ]
> >
> > Looks good, only I wonder if there would be a means to specify that only one of 
> > SENSORS_LIS3_SPI, SENSORS_LIS3_I2C, or HP_ACCEL is valid at any given time.
> 
> SENSORS_LIS3_SPI and HP_ACCEL are already mutually exclusive (they
> depend on !ACPI and ACPI respectively, and ACPI is a boolean.) I am not
> sure if they should also be exclusive with SENSORS_LIS3_I2C... In fact I
> don't think the exclusive access should be handled at build time, it
> would better be handled at run-time, and preferably on a per-device
> basis.
> 
> But more importantly, my patches do _not_ change anything here. I left
> things the way they were.
> 
Makes sense.

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
