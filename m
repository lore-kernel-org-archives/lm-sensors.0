From: Andreas Herrmann <andreas.herrmann3@amd.com>
Date: Fri, 18 Jun 2010 08:01:26 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (k8temp) Bypass core swapping on
Message-Id: <20100618080126.GK4458@loge.amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100527163317.5b7c627d@hyperion.delvare>
In-Reply-To: <20100527163317.5b7c627d@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Thu, May 27, 2010 at 10:33:17AM -0400, Jean Delvare wrote:
> Commit a2e066bba2aad6583e3ff648bf28339d6c9f0898 introduced core
> swapping for CPU models 64 and later. I recently had a report about
> a Sempron 3200+, model 95, for which this patch broke temperature
> reading. It happens that this is a single-core processor, so the
> effect of the swapping was to read the temperature value for a core
> that didn't exist, leading to an incorrect value (-49 degrees C.)
> 
> Disabling core swapping on singe-core processors should fix this.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Tested-by: Rick Moritz <rhavin@gmx.net>
> Cc: Andreas Herrmann <andreas.herrmann3@amd.com>
> Cc: stable@kernel.org
> ---
> Andreas, please comment on this. Is my fix correct for all single-core
> processors? I have to admit I am surprised that nobody reported this
> bug in well over a year if it affects all AM2 and AM3 socket Sempron
> processors.

Acked-by: Andreas Herrmann <andreas.herrmann3@amd.com>

The BKDG says

  Thermal Sensor Core Select (ThermSenseCoreSel)—Bit 2. This bit selects the CPU whose
     temperature is reported in the CurTemp field. This bit only applies to dual core processors.
     For single core processors CPU0 Thermal Sensor is always selected. ...

k8temp_probe() correctly detected that SEL_CORE can't be used on single
core CPU. Thus k8temp did never update the temperature values stored
in temp[1][x] and -49 degrees was reported. For single core CPUs we
must use the values read into temp[0][x].

Your patch fixes this.


Thanks,

Andreas


>  drivers/hwmon/k8temp.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-2.6.35-rc0.orig/drivers/hwmon/k8temp.c	2010-05-17 18:42:27.000000000 +0200
> +++ linux-2.6.35-rc0/drivers/hwmon/k8temp.c	2010-05-27 16:01:02.000000000 +0200
> @@ -120,7 +120,7 @@ static ssize_t show_temp(struct device *
>  	int temp;
>  	struct k8temp_data *data = k8temp_update_device(dev);
>  
> -	if (data->swap_core_select)
> +	if (data->swap_core_select && (data->sensorsp & SEL_CORE))
>  		core = core ? 0 : 1;
>  
>  	temp = TEMP_FROM_REG(data->temp[core][place]) + data->temp_offset;
> 
> 
> -- 
> Jean Delvare
> 

-- 
Operating | Advanced Micro Devices GmbH
  System  | Einsteinring 24, 85609 Dornach b. München, Germany
 Research | Geschäftsführer: Alberto Bozzo, Andrew Bowd
  Center  | Sitz: Dornach, Gemeinde Aschheim, Landkreis München
  (OSRC)  | Registergericht München, HRB Nr. 43632



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
