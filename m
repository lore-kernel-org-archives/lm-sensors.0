From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 08 Jan 2016 12:34:17 +0000
Subject: Re: [lm-sensors] [patch] hwmon: (emc2103) Fix typo in MODULE_PARM_DESC
Message-Id: <20160108133417.3312f22f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20160108110321.GK32195@mwanda>
In-Reply-To: <20160108110321.GK32195@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Steve Glendinning <steve.glendinning@shawell.net>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Dan,

On Fri, 8 Jan 2016 14:03:21 +0300, Dan Carpenter wrote:
> "apd" was intended here instead of "init".
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/hwmon/emc2103.c b/drivers/hwmon/emc2103.c
> index 952fe69..24e395c 100644
> --- a/drivers/hwmon/emc2103.c
> +++ b/drivers/hwmon/emc2103.c
> @@ -58,7 +58,7 @@ static const u8 REG_TEMP_MAX[4] = { 0x34, 0x30, 0x31, 0x32 };
>   */
>  static int apd = -1;
>  module_param(apd, bint, 0);
> -MODULE_PARM_DESC(init, "Set to zero to disable anti-parallel diode mode");
> +MODULE_PARM_DESC(apd, "Set to zero to disable anti-parallel diode mode");
>  
>  struct temperature {
>  	s8	degrees;

Applied, thanks.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
