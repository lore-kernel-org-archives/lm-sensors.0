From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 17 Mar 2010 07:51:44 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: asc7621 Add X58 entry in Kconfig
Message-Id: <20100317085144.54998559@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1268808892.2006.3.camel@i7.satnam>
In-Reply-To: <1268808892.2006.3.camel@i7.satnam>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 17 Mar 2010 12:24:52 +0530, Jaswinder Singh Rajput wrote:
> 
> Intel X58 have asc7621a chip. So added X58 entry in Kconfig for asc7621.
> Also arranged existing models in ascending order.
> 
> Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>
> ---
>  drivers/hwmon/Kconfig |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index e4595e6..9be8e17 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -217,8 +217,8 @@ config SENSORS_ASC7621
>  	depends on HWMON && I2C
>  	help
>  	  If you say yes here you get support for the aSC7621
> -	  family of SMBus sensors chip found on most Intel X48, X38, 975,
> -	  965 and 945 desktop boards.  Currently supported chips:
> +	  family of SMBus sensors chip found on most Intel X38, X48, X58,
> +	  945, 965 and 975 desktop boards.  Currently supported chips:
>  	  aSC7621
>  	  aSC7621a
>  

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
