From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Sep 2010 14:56:09 +0000
Subject: Re: [lm-sensors] [PATCH] HWMON: Make s3c-hwmon depend on S3C_ADC
Message-Id: <20100915165609.38ee922c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4c8b9f31.097b0e0a.0cd0.ffffe66b@mx.google.com>
In-Reply-To: <4c8b9f31.097b0e0a.0cd0.ffffe66b@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 12 Sep 2010 09:24:39 -0700, Guenter Roeck wrote:
> On Sat, Sep 11, 2010 at 11:24:31AM -0400, Maurus Cuelenaere wrote:
> > This way we don't need to modify Kconfig every time a new SoC comes along to
> > make this driver support it. Also fix some typos while I'm at it.
> > 
> > Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
> 
> Reviewed-by: Guenter Roeck <guenter.roeck@ericsson.com>
> 
> > ---
> >  drivers/hwmon/Kconfig |    8 ++++----
> >  1 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index 4d4d09b..3cbdc3d 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -743,14 +743,14 @@ config SENSORS_SHT15
> >  	  will be called sht15.
> >  
> >  config SENSORS_S3C
> > -	tristate "S3C24XX/S3C64XX Inbuilt ADC"
> > -	depends on ARCH_S3C2410
> > +	tristate "Samsung built-in ADC"
> > +	depends on S3C_ADC
> >  	help
> >  	  If you say yes here you get support for the on-board ADCs of
> > -	  the Samsung S3C24XX or S3C64XX series of SoC
> > +	  the Samsung S3C24XX, S3C64XX and other series of SoC
> >  
> >  	  This driver can also be built as a module. If so, the module
> > -	  will be called s3c-hwmo.
> > +	  will be called s3c-hwmon.
> >  
> >  config SENSORS_S3C_RAW
> >  	bool "Include raw channel attributes in sysfs"

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
