From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 19 Aug 2008 14:03:27 +0000
Subject: Re: [lm-sensors] [PATCH] lm90: Support MAX6646, MAX6647 and MAX6649
Message-Id: <20080819160327.64f89763@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080818192318.GF7908@solarflare.com>
In-Reply-To: <20080818192318.GF7908@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ben,

On Mon, 18 Aug 2008 20:23:20 +0100, Ben Hutchings wrote:
> These Maxim chips are similar to MAX6657 but use unsigned temperature
> values to allow for readings up to 145 degrees.
> 
> Signed-off-by: Ben Hutchings <bhutchings@solarflare.com>
> ---
>  Documentation/hwmon/lm90 |   15 +++++++++
>  drivers/hwmon/Kconfig    |    3 +-
>  drivers/hwmon/lm90.c     |   77 ++++++++++++++++++++++++++++++++++++++-------
>  3 files changed, 82 insertions(+), 13 deletions(-)

Looks good, I've added this patch to my queue of hwmon patches for
kernel 2.6.28:
http://khali.linux-fr.org/devel/linux-2.6/jdelvare-hwmon/

I've updated the wiki as well.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
