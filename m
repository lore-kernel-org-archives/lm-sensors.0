From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 12 Nov 2008 20:39:49 +0000
Subject: Re: [lm-sensors] [PATCH RESEND] hwmon: lm70: TI TMP121 support.
Message-Id: <20081112213949.5cd82906@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081022080423.GB11169@roarinelk.homelinux.net>
In-Reply-To: <20081022080423.GB11169@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Manuel,

On Thu, 23 Oct 2008 16:00:32 +0200, Manuel Lauss wrote:
> > Ah, yes, the lack of an i2c_driver.id_table parameter was why I originally
> > wrote a separate driver.  I suppose I could add another struct spi_driver
> > for the TMP121 and sort out chip types internally.
> 
> Does this look acceptable?
> 
> --- 
> 
> From: Manuel Lauss <mano@roarinelk.homelinux.net>
> Subject: [PATCH] hwmon: Extend LM70 with TMP121/TMP123 support.
> 
> The Texas Instruments TMP121 is a SPI temperature sensor very similar
> to the LM70, with slightly higher resolution.  This patch extends the
> LM70 driver to support the TMP121.
> 
> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
> ---
>  Documentation/hwmon/lm70 |    7 +++-
>  drivers/hwmon/Kconfig    |    5 ++-
>  drivers/hwmon/lm70.c     |   85 +++++++++++++++++++++++++++++++++++++++-------
>  3 files changed, 81 insertions(+), 16 deletions(-)

Yes, this version of the patch looks all OK to me. It simply needed
some fixes to apply properly on top of Kaiwan's lm70 fixes.

Can you please test the following two patches:
http://khali.linux-fr.org/devel/linux-2.6/jdelvare-hwmon/hwmon-lm70-01-fix-byte-order.patch
http://khali.linux-fr.org/devel/linux-2.6/jdelvare-hwmon/hwmon-lm70-02-ti-tmp121-support.patch

and confirm that things work fine for you with them applied?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
