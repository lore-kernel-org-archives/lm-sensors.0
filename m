From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 11 Sep 2012 20:24:24 +0000
Subject: Re: [lm-sensors] [PATCH 2/4] hwmon: (max1111) Add support for MAX1110, MAX1112, and MAX1113
Message-Id: <20120911202424.GA22941@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1347336566-32662-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1347336566-32662-3-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Sep 11, 2012 at 10:09:36PM +0200, Jean Delvare wrote:
> On Tue, 11 Sep 2012 08:55:49 -0700, Guenter Roeck wrote:
> > Hi Jean,
> > 
> > On Tue, Sep 11, 2012 at 09:56:40AM +0200, Jean Delvare wrote:
> > > Hi Guenter,
> > > 
> > > On Mon, 10 Sep 2012 21:09:24 -0700, Guenter Roeck wrote:
> > > > MAX1110 is similar to MAX1111, with 8 instead of 4 channels. MAX1112 and MAX1113
> > > > are similar to MAX1110 and MAX1111, with 4.096V reference voltage instead of
> > > > 2.048V.
> > > > 
> > > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > [ ... ]
> > > >  
> > > > @@ -93,12 +100,15 @@ EXPORT_SYMBOL(max1111_read_channel);
> > > >  static ssize_t show_name(struct device *dev,
> > > >  			 struct device_attribute *attr, char *buf)
> > > >  {
> > > > -	return sprintf(buf, "max1111\n");
> > > > +	struct max1111_data *data = dev_get_drvdata(dev);
> > > > +
> > > > +	return sprintf(buf, "%s\n", data->name);
> > > 
> > > Can't you use dev_name(dev) instead?
> > > 
> > Would be nice, but dev_name(dev) is the name of the SPI device, eg spi0.0.
> > If I use dev_name, sensors output is:
> > 
> > spi0.0-spi-0-0
> > Adapter: SPI adapter
> > in0:          +0.00 V
> > in1:          +0.00 V
> > in2:          +0.00 V
> > in3:          +0.00 V
> 
> No good indeed.
> 
> > Other drivers all use the data->name approach as far as I can see.
> 
> Fair enough. It simply seems odd that you have to duplicate a string
> which is necessarily available somewhere else. Maybe
> to_spi_device(dev)->modalias. But feel free to leave the code as is if

That works. I'll use it, and probably submit patches for the other SPI hwmon drivers
to do the same.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
