From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 22 Feb 2012 18:51:52 +0000
Subject: Re: [lm-sensors] [PATCH V5] hwmon: Add MCP3021 ADC driver
Message-Id: <1329936712.23014.93.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1329897332-18383-1-git-send-email-X.Xie@freescale.com>
In-Reply-To: <1329897332-18383-1-git-send-email-X.Xie@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2012-02-22 at 13:00 -0500, Jean Delvare wrote:
> On Wed, 22 Feb 2012 09:46:20 -0800, Guenter Roeck wrote:
> > On Wed, 2012-02-22 at 02:55 -0500, Xie Xiaobo wrote:
> > > Add I2C driver for MCP3021 that is an ADC chip from Microchip.
> > > The MCP3021 is a successive approximation A/D converter (ADC)
> > > with 10-bit resolution.
> > > The driver export the value of Vin to sysfs, the voltage unit is
> > > mV. Through the sysfs interface, lm-sensors tool can also display
> > > Vin voltage.
> > > 
> > > Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
> > > Signed-off-by: Xie Xiaobo <X.Xie@freescale.com>
> > 
> > [ ... ]
> > 
> > > +
> > > +	if (reg < 0) {
> > > +		printk(KERN_ERR "%s encountered error %d\n", __func__, reg);
> > 
> > You should use dev_err() here.
> 
> I don't think there's any point in printing an error message in the
> first place. I/O errors over I2C can happen, and the caller will get an
> error when it happens. "sensors" will display an error message and
> other monitoring applications would do too. Logging an error message is
> redundant IMHO.
> 
> If Xie agrees, I'll just remove the message, no need to resent. We've
> gone through 4 reviews, it's probably enough for such a small driver,
> it's about time to accept it for the next merge window. Patch applied
> (with minor changes), thanks.
> 
Ok with me. I am not a friend of such error messages.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
