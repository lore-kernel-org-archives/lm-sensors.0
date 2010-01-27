From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 27 Jan 2010 07:49:35 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] HWMON: Add s3c64xx support to s3c-hwmon
Message-Id: <20100127084935.5e146ce5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <b2e8f9f71001260316h7fe29effn290648178ff42397@mail.gmail.com>
	<20100127010747.GI9153@trinity.fluff.org>
In-Reply-To: <20100127010747.GI9153@trinity.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org
Cc: Maurus Cuelenaere <mcuelenaere@gmail.com>, linux-samsung-soc@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, linux-arm-kernel@lists.infradead.org, lm-sensors@lm-sensors.org

On Wed, 27 Jan 2010 01:07:48 +0000, Ben Dooks wrote:
> On Tue, Jan 26, 2010 at 12:16:17PM +0100, Maurus Cuelenaere wrote:
> > Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
> Acked-by: Ben Dooks <ben-linux@fluff.org>
> > ---
> >  drivers/hwmon/Kconfig |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index 68cf877..a8a267c 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -702,7 +702,7 @@ config SENSORS_SHT15
> > 
> >  config SENSORS_S3C
> >  	tristate "S3C24XX/S3C64XX Inbuilt ADC"
> > -	depends on ARCH_S3C2410
> > +	depends on ARCH_S3C2410 || ARCH_S3C64XX
> >  	help
> >  	  If you say yes here you get support for the on-board ADCs of
> >  	  the Samsung S3C24XX or S3C64XX series of SoC

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
