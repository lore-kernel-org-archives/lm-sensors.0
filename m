From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 21 May 2011 07:51:16 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: Remove pkgtemp driver
Message-Id: <20110521095116.2ed677e5@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1305902880-11414-2-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1305902880-11414-2-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 20 May 2011 07:47:59 -0700, Guenter Roeck wrote:
> After the merge of pkgtemp functionality into the coretemp driver,
> the pkgtemp driver is no longer necessary. Remove it.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> ---
>  Documentation/hwmon/pkgtemp |   36 ----
>  drivers/hwmon/Kconfig       |    7 -
>  drivers/hwmon/Makefile      |    1 -
>  drivers/hwmon/pkgtemp.c     |  444 -------------------------------------------
>  4 files changed, 0 insertions(+), 488 deletions(-)
>  delete mode 100644 Documentation/hwmon/pkgtemp
>  delete mode 100644 drivers/hwmon/pkgtemp.c

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
