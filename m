From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 02 Jun 2006 13:50:32 +0000
Subject: [lm-sensors] PATCH: libsensors and sensors prog support for
Message-Id: <20060602155032.ac9a633c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4470B176.5000703@hhs.nl>
In-Reply-To: <4470B176.5000703@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

> Here is a new version of the Abit uGuru userspace support, I fixed 
> everything from Jean's review.
> 
> I did this patch against 2.10.0 not CVS, but I checked that it applies 
> against CVS too.

Sorry by I'd have one more objection:

> +void print_abituguru(const sensors_chip_name *name)
> +{
> +  int i;
> +
> +  for (i=0;i<11;i++)
> +    print_abituguru_in(name, SENSORS_ABITUGURU_IN(i),
> +      SENSORS_ABITUGURU_IN_MIN(i), SENSORS_ABITUGURU_IN_MIN_ALARM(i),
> +      SENSORS_ABITUGURU_IN_MAX(i), SENSORS_ABITUGURU_IN_MAX_ALARM(i));
> +
> +  for (i=1;i<=7;i++)
> +    print_abituguru_temp(name, SENSORS_ABITUGURU_TEMP(i),
> +      SENSORS_ABITUGURU_TEMP_ALARM(i), SENSORS_ABITUGURU_TEMP_MAX(i),
> +      SENSORS_ABITUGURU_TEMP_CRIT(i));
> +
> +  for (i=1;i<=6;i++)
> +    print_abituguru_fan(name, SENSORS_ABITUGURU_FAN(i),
> +      SENSORS_ABITUGURU_FAN_ALARM(i), SENSORS_ABITUGURU_FAN_MIN(i));
> +}

This looks inefficient to me. You could pass only name and i as
parameters to the three sub-functions. What do you think?

Thanks,
-- 
Jean Delvare

