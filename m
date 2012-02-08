From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 08 Feb 2012 22:18:18 +0000
Subject: Re: [lm-sensors] [PATCH V2] hwmon: Add MCP3021 hardware monitoring driver
Message-Id: <1328739498.2261.357.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1328445218-17226-1-git-send-email-X.Xie@freescale.com>
In-Reply-To: <1328445218-17226-1-git-send-email-X.Xie@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2012-02-08 at 17:00 -0500, Jean Delvare wrote:
> Hi Xie,
> 
> On Sun, 5 Feb 2012 20:33:38 +0800, Xie Xiaobo wrote:
> > Add I2C driver for MCP3021 that is an ADC chip from Microchip.
> > The MCP3021 is a successive approximation A/D converter (ADC)
> > with 10-bit resolution.
> > The driver export the value of Vin to sysfs, the voltage unit is
> > mV. Through the sysfs interface, lm-sensors tool can also display
> > Vin voltage.
> > 
> > Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
> > Signed-off-by: Xie Xiaobo <X.Xie@freescale.com>
> > ---
> > ---
> 
Odd, I didn't get a copy of this patch. Guess I am fighting with the
corporate e-mail system again :(. Thanks for looking into it.

Additional minor comment below.

[ ... ]

> > +
> > +static int __init mcp3021_init(void)
> > +{
> > +	return i2c_add_driver(&mcp3021_driver);
> > +}
> > +
> > +static void __exit mcp3021_exit(void)
> > +{
> > +	i2c_del_driver(&mcp3021_driver);
> > +}
> > +
> > +MODULE_AUTHOR("Mingkai Hu <Mingkai.hu@freescale.com>");
> > +MODULE_DESCRIPTION("Microchip MCP3021 driver");
> > +MODULE_LICENSE("GPL");
> > +
> > +module_init(mcp3021_init);
> > +module_exit(mcp3021_exit);
> 

The init/exit functions and module_init/module_exit can now be replaced
with module_i2c_driver(mcp3021_driver);

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
