From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 25 Jun 2006 14:04:36 +0000
Subject: [lm-sensors] [PATCH] W83627EHF driver update
Message-Id: <20060625160436.97a4c2bf.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4485CB7A.9050209@sh.cvut.cz>
In-Reply-To: <4485CB7A.9050209@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

> Here comes fixed patch, I left the macro there because it will be used in future
> update. Rest was fixed.

I am happy with the code now, but there is a problem with the sysfs file
names, see below.

> I'm attaching the documentation patch too. David, please can you read it and
> check it? (I will sign that off when we know that there are no mistakes)

My review of it:

> diff -uprN a/Documentation/hwmon/w83627ehf linux-2.6.17-rc6/Documentation/hwmon/w83627ehf
> --- a/Documentation/hwmon/w83627ehf	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.17-rc6/Documentation/hwmon/w83627ehf	2006-06-24 18:33:31.839223250 +0200
> @@ -0,0 +1,75 @@
> +Kernel driver w83627ehf
> +===========> +
> +Supported chips:
> +  * Winbond W83627EHF/EHG/EF/EG (ISA accesses ONLY)

s/accesses/access/

EF and EG verions are not actually supported, see below.

> +    Prefix: 'w83627ehf'
> +    Addresses scanned: ISA address retrieved from Super I/O registers
> +    Datasheet: http://www.winbond-usa.com/products/winbond_products/pdfs/
> +                      /PCIC/W83627EHF_%20W83627EHGb.pdf

Please don't split the URL.

Weird file name, BTW :(

> +
> +Authors:
> +        Jean Delvare <khali at linux-fr.org>,
> +        Yuan Mu <Ymu at Winbond.com.tw>,
> +        Rudolf Marek <r.marek at sh.cvut.cz>
> +
> +Description
> +-----------
> +
> +This driver implements support for the Winbond W83627EF, W83627EHF,
> +W83627EHG and W83627EG super I/O chips. We will refer to them
> +collectively as Winbond chips.

Not correct. The W83627EF and W83627EG do not have the hardware
monitoring features so the driver is useless for them.

> +
> +The chips implement three temperature sensors, five fan rotation 
> +speed sensors, ten analog voltage sensors, alarms with beep warnings (control
> +unimplemented), and some automatic fan regulation strategies.

And manual fan speed control too.

> +
> +Temperatures are measured in degrees Celsius and measurement resolution is 1
> +degC for temp1 and 0.5 degC for temp2 and temp3. An alarm is triggered when
> +the temperature gets higher than the Overtemperature Shutdown value; it stays
> +on until the temperature falls below the Hysteresis value.

"Overtemperature Shutdown" is an old term, I think it was used in the
LM75 datasheet, but doesn't make much sense here. The system is usually
NOT going to shutdown if this limit is crossed.

> +
> +Fan rotation speeds are reported in RPM (rotations per minute). An alarm is
> +triggered if the rotation speed has dropped below a programmable limit. Fan
> +readings can be divided by a programmable divider (1, 2, 4, 8, 16, 32, 64 or
> +128) to give the readings more range or accuracy. Some fans might not
> +be present because they share pins with other funtions.

This driver implements automatic fan clock divider switching, so the
divider values are hidden from the user.

> +
> +Voltage sensors (also known as IN sensors) report their values in millivolts.
> +An alarm is triggered if the voltage has crossed a programmable minimum
> +or maximum limit.
> +
> +The driver supports automatic fan control mode known as Thermal Cruise.
> +This mode works for fan1-fan4. Programmable mapping of the temperatures
> +to fans is not implemented, BIOS should have done it.

We should at least have read-only files to let the user know the
mapping.

It would be nice to describe what is the "thermal cruise" mode.

> +
> +/sys files
> +----------
> +
> +pwm[1-4] - this file stores PWM duty cycle or DC value (fan speed) in range:
> +	0 (stop) to 255 (full)
> +
> +pwm[1-4]_enable - this file controls mode of fan/temperature control:
> +	* 1 Manual Mode, write to pwm file any value 0-255 (fullspeed)

s/fullspeed/full speed/

> +        * 2 Thermal Cruise

Broken indentation.

> +
> +Thermal Cruise mode
> +--------------------
> +
> +If the temperature is in its range, defined with:

s/its/the/

> +
> +temp[1-4]_target    - set target temperature, unit miliC (range 0 - 127000)
> +temp[1-4]_tolerance - tolerance, unit miliC (range 0 - 15000)

Unknown unit "miliC".

I'm just realizing that these names are quite wrong. For example
temp1_target may not be related to temp1 but to a different temperature
sensor depending on the temp/fan mapping. The "1" here really means
pwm1, not temp1. So these files should be named pwm[1-4]_target_temp
and pwm[1-4]_tolerance_temp, respectively.

BTW, these file names should also be added to sysfs-interface.

> +
> +There are no changes to fan speed. Once the temperature leaves the interval,
> +fan speed increases (temp is higher) or decreases if lower than desired. 
> +There are defined steps and times, but not exported by the driver yet.
> +
> +fan[1-4]_min_output - minimum fan speed (range 1 - 255), when the temperature
> +                      is bellow defined range.

Should be named pwm[1-4]_min.

s/bellow/below/

> +fan[1-4]_stop_time  - how many milliseconds [ms] must elapse to switch
> +                      corresponding fan off. (when the temperature was bellow
> +                      defined range).
> +

Should be named pwm[1-4]_stop_time.

> +It seems last two funtions are exclusive, and are controlled with register 0x12.
> +(Should be programed by BIOS)
> 

But the driver uncondionally creates both files? This needs to be
investigated, and fixed (either the driver or the documentation.)

Thanks,
-- 
Jean Delvare

