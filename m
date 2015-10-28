From: Punit Agrawal <punit.agrawal@arm.com>
Date: Wed, 28 Oct 2015 15:39:57 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (scpi) skip unsupported sensors properly
Message-Id: <9hhio5rato2.fsf@e105922-lin.cambridge.arm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1446041283-19702-1-git-send-email-sudeep.holla@arm.com>
In-Reply-To: <1446041283-19702-1-git-send-email-sudeep.holla@arm.com> (Sudeep
	Holla's message of "Wed, 28 Oct 2015 14:08:03 +0000")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org, Jean Delvare <jdelvare@suse.com>

Hi Sudeep,

Sudeep Holla <sudeep.holla@arm.com> writes:

> Currently it's assumed that firmware exports only the class of sensors
> supported by the driver. However with newer firmware or SCPI protocol
> revision, support for newer classes of sensors can be present.
>
> The driver fails to probe with the following warning if an unsupported
> class of sensor is encountered in the firmware.
>
> sysfs: cannot create duplicate filename
> 	'/devices/platform/scpi/scpi:sensors/hwmon/hwmon0/'
> ------------[ cut here ]------------
> WARNING: at fs/sysfs/dir.c:31
> Modules linked in:
>
> CPU: 0 PID: 6 Comm: kworker/u12:0 Not tainted 4.3.0-rc7 #137
> Hardware name: ARM Juno development board (r0) (DT)
> Workqueue: deferwq deferred_probe_work_func
> PC is at sysfs_warn_dup+0x54/0x78
> LR is at sysfs_warn_dup+0x54/0x78
>

Thanks for spotting the issue and the fix below. Some comments below.


> This patch fixes the above issue by skipping through the unsupported
> class of SCPI sensors.
>
> Fixes: 68acc77a2d51 ("hwmon: Support thermal zones registration for SCP temperature sensors")
> Fixes: ea98b29a05e9 ("hwmon: Support sensors exported via ARM SCP interface")
> Cc: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>


> ---
>  drivers/hwmon/scpi-hwmon.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/hwmon/scpi-hwmon.c b/drivers/hwmon/scpi-hwmon.c
> index 2c1241bbf9af..5b80cd7f5c86 100644
> --- a/drivers/hwmon/scpi-hwmon.c
> +++ b/drivers/hwmon/scpi-hwmon.c

[...]

> @@ -234,9 +235,9 @@ static int scpi_hwmon_probe(struct platform_device *pdev)
>  			goto unregister_tzd;
>  		}
>
> -		zone->sensor_id = i;
> +		zone->sensor_id = sensor->info.sensor_id;

This shouldn't be changed . The zone->sensor_id is used to access the sensor
data in scpi_read_temp and will use the wrong index with the above
change. Which means...

>  		zone->scpi_sensors = scpi_sensors;
> -		zone->tzd = thermal_zone_of_sensor_register(dev, i, zone,
> +		zone->tzd = thermal_zone_of_sensor_register(dev, zone->sensor_id, zone,
>  							    &scpi_sensor_ops);

... the thermal zone registration should use sensor->info.sensor_id
instead of zone->sensor_id.

With these two changes, feel free to add

     Reviewed-by: Punit Agrawal <punit.agrawal@arm.com>

>  		/*
>  		 * The call to thermal_zone_of_sensor_register returns
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
