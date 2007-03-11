From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 11 Mar 2007 11:31:25 +0000
Subject: [lm-sensors] [PATCH] build fix for W83793
Message-Id: <20070311123125.c58bda0c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070310130402.1d7f90fd@localhost>
In-Reply-To: <20070310130402.1d7f90fd@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Stefano,

On Sat, 10 Mar 2007 13:04:02 +0100, Stefano Brivio wrote:
> We need vid_which_vrm and vid_from_reg in w83793 module.
> 
> 
> Signed-off-by: Stefano Brivio <stefano.brivio at polimi.it>
> ----
> 
> --- drivers/hwmon/Kconfig.orig	2007-03-10 12:54:14.126633998 +0100
> +++ drivers/hwmon/Kconfig	2007-03-10 12:55:07.443500176 +0100
> @@ -516,6 +516,7 @@
>  config SENSORS_W83793
>  	tristate "Winbond W83793"
>  	depends on HWMON && I2C && EXPERIMENTAL
> +	select HWMON_VID
>  	help
>  	  If you say yes here you get support for the Winbond W83793
>  	  hardware monitoring chip.

Good catch! Applied, thanks.

-- 
Jean Delvare

