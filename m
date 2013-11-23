From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 23 Nov 2013 13:01:58 +0000
Subject: Re: [lm-sensors] [PATCH 5/5] ixgbe: Start temperature sensor attribute index with 1
Message-Id: <20131123140158.47ce529d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1385186881-7931-1-git-send-email-linux@roeck-us.net>
	<1385186881-7931-6-git-send-email-linux@roeck-us.net>
In-Reply-To: <1385186881-7931-6-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: netdev@vger.kernel.org, Nithin Nayak Sujir <nsujir@broadcom.com>, e1000-devel@lists.sourceforge.net, Don Skidmore <donald.c.skidmore@intel.com>, Bruce Allan <bruce.w.allan@intel.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, lm-sensors@lm-sensors.org, Greg Rose <gregory.v.rose@intel.com>, Jeff Kirsher <jeffrey.t.kirsher@intel.com>, Michael Chan <mchan@broadcom.com>, Carolyn Wyborny <carolyn.wyborny@intel.com>, "David S. Miller" <davem@davemloft.net>

On Fri, 22 Nov 2013 22:08:01 -0800, Guenter Roeck wrote:
> Per hwmon ABI, temperature sensor attribute index starts with 1, not 0.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sysfs.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sysfs.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sysfs.c
> index 3081974..e74ae36 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sysfs.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sysfs.c
> @@ -118,22 +118,22 @@ static int ixgbe_add_hwmon_attr(struct ixgbe_adapter *adapter,
>  	case IXGBE_HWMON_TYPE_LOC:
>  		ixgbe_attr->dev_attr.show = ixgbe_hwmon_show_location;
>  		snprintf(ixgbe_attr->name, sizeof(ixgbe_attr->name),
> -			 "temp%u_label", offset);
> +			 "temp%u_label", offset + 1);
>  		break;
>  	case IXGBE_HWMON_TYPE_TEMP:
>  		ixgbe_attr->dev_attr.show = ixgbe_hwmon_show_temp;
>  		snprintf(ixgbe_attr->name, sizeof(ixgbe_attr->name),
> -			 "temp%u_input", offset);
> +			 "temp%u_input", offset + 1);
>  		break;
>  	case IXGBE_HWMON_TYPE_CAUTION:
>  		ixgbe_attr->dev_attr.show = ixgbe_hwmon_show_cautionthresh;
>  		snprintf(ixgbe_attr->name, sizeof(ixgbe_attr->name),
> -			 "temp%u_max", offset);
> +			 "temp%u_max", offset + 1);
>  		break;
>  	case IXGBE_HWMON_TYPE_MAX:
>  		ixgbe_attr->dev_attr.show = ixgbe_hwmon_show_maxopthresh;
>  		snprintf(ixgbe_attr->name, sizeof(ixgbe_attr->name),
> -			 "temp%u_crit", offset);
> +			 "temp%u_crit", offset + 1);
>  		break;
>  	default:
>  		rc = -EPERM;

Reviewed-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
