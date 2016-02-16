From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 16 Feb 2016 01:41:00 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (scpi) add energy meter support
Message-Id: <56C27E2C.5030506@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1455028377-12728-1-git-send-email-sudeep.holla@arm.com>
 <1455028377-12728-2-git-send-email-sudeep.holla@arm.com>
In-Reply-To: <1455028377-12728-2-git-send-email-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lm-sensors@lm-sensors.org, Jean Delvare <jdelvare@suse.com>, Punit Agrawal <punit.agrawal@arm.com>

On 02/09/2016 06:32 AM, Sudeep Holla wrote:
> SCPI specification v1.1 adds support for energy sensors. This patch
> adds support for the same.
>
> Cc: Punit Agrawal <punit.agrawal@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/hwmon/scpi-hwmon.c    | 8 ++++++++
>   include/linux/scpi_protocol.h | 1 +
>   2 files changed, 9 insertions(+)
>
> diff --git a/drivers/hwmon/scpi-hwmon.c b/drivers/hwmon/scpi-hwmon.c
> index 7101b14b5137..912b449c8303 100644
> --- a/drivers/hwmon/scpi-hwmon.c
> +++ b/drivers/hwmon/scpi-hwmon.c
> @@ -114,6 +114,7 @@ static int scpi_hwmon_probe(struct platform_device *pdev)
>   {
>   	u16 nr_sensors, i;
>   	int num_temp = 0, num_volt = 0, num_current = 0, num_power = 0;
> +	int num_energy = 0;
>   	struct scpi_ops *scpi_ops;
>   	struct device *hwdev, *dev = &pdev->dev;
>   	struct scpi_sensors *scpi_sensors;
> @@ -182,6 +183,13 @@ static int scpi_hwmon_probe(struct platform_device *pdev)
>   				 "power%d_label", num_power + 1);
>   			num_power++;
>   			break;
> +		case ENERGY:
> +			snprintf(sensor->input, sizeof(sensor->input),
> +				 "energy%d_input", num_energy + 1);
> +			snprintf(sensor->label, sizeof(sensor->input),
> +				 "energy%d_label", num_energy + 1);
> +			num_energy++;
> +			break;
>   		default:
>   			continue;
>   		}
> diff --git a/include/linux/scpi_protocol.h b/include/linux/scpi_protocol.h
> index ecd248d46281..35de50a65665 100644
> --- a/include/linux/scpi_protocol.h
> +++ b/include/linux/scpi_protocol.h
> @@ -33,6 +33,7 @@ enum scpi_sensor_class {
>   	VOLTAGE,
>   	CURRENT,
>   	POWER,
> +	ENERGY,
>   };
>
>   struct scpi_sensor_info {
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
