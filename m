From: Manuel Lauss <mano@roarinelk.homelinux.net>
Date: Thu, 23 Oct 2008 13:30:30 +0000
Subject: Re: [lm-sensors] [PATCH RESEND] hwmon: lm70: TI TMP121 support.
Message-Id: <20081023133030.GB20521@roarinelk.homelinux.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081022080423.GB11169@roarinelk.homelinux.net>
In-Reply-To: <20081022080423.GB11169@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Oct 23, 2008 at 03:20:30PM +0200, Jean Delvare wrote:
> On Thu, 23 Oct 2008 15:13:23 +0200, Manuel Lauss wrote:
> > On Thu, Oct 23, 2008 at 02:57:10PM +0200, Jean Delvare wrote:
> > > I don't know much about the SPI side of things so I would like someone
> > > else to comment on that aspect of the patch (in particular the way
> > > different device types are supported by the same driver.) David, can
> > > you please take a look and let us know if you have any objection?
> > 
> > I'd be more than happy to just use a number cast to void * for 
> > spi platform_data and get rid of this header.  I'm not sure however
> > whether this is acceptable style for kernel code.
> 
> Err, no, that's not what I was suggesting. Abusing pointers to store
> integers is bad, please don't do that.
> 
> I was more curious about the need to have such arbitrary numbers to
> differentiate between chip types. For i2c, we can just tell a driver to
> support several chip names. But maybe the spi subsystem doesn't support
> that.

Ah, yes, the lack of an i2c_driver.id_table parameter was why I originally
wrote a separate driver.  I suppose I could add another struct spi_driver
for the TMP121 and sort out chip types internally.

Thanks!
	Manuel Lauss

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
