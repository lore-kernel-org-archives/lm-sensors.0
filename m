From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:17 +0000
Subject: W83L785 for 2.6 is written
Message-Id: <20040927142440.M24694@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0409032110560.19686@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0409032110560.19686@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 27 Sep 2004 15:19:56 +0200 (CEST), Rudolf Marek wrote
> Anyone knows anyone with same chip ?
> Please and who has W83L785TS ?

I don't own one myself but the TS-S is known to be found on several popular
Asus motherboards, as a companion to the ASB100.

> The TS chip can be included in this driver (TS is subset of this 
> chip) what will be the procedure? First include this one and merge later?

Please note that you will need to implement the retry-on-failure method that
the w83l785ts driver has if you want to include TS-S support into your driver.

Merging is probably a good idea. You indeed need to include support first,
then the old driver gets deprecated and after some times it gets deleted. You
will need to port your driver to Linux 2.4 before the two latter steps occur
though, since we do not want to have to point people to one driver under 2.4
and another under 2.6 (this is technically possible but has proven to confuse
the users).

> I guess I can start preparing the driver to inclusion in main kernel.
> I attached to the end of this email userspace part. I think it looks 
> quite OK. Jean please could you review? (and apply maybe :)?

I cannot apply anything now as we are in feature freeze mode until the
upcoming 2.8.8 release.

> +/* W83L785R chips */
> +
> +#define SENSORS_W83L785R_PREFIX "w83l785r"
> +
> +#define SENSORS_W83L785R_TEMP1		51 /* R */
> +#define SENSORS_W83L785R_TEMP1_MAX	52 /* RW */
> +#define SENSORS_W83L785R_TEMP1_CRIT	53 /* RW */
> +#define SENSORS_W83L785R_TEMP1_HYST_MIN	54 /* RW */
> +#define SENSORS_W83L785R_TEMP1_SENS	55 /* RW */

What is HYST_MIN? The name is non-standard, and I can't imagine what it is
for. Please explain.
> +++ lm_sensors2_my/prog/sensors/chips.c	2004-09-23 
> 17:28:51.000000000 +0200 @@ -4852,10 +4852,10 @@   } }
> 
> -/* print_asb100_in()
> +/* print_in()
>   *   where in, in_min, and in_max are sensors feature IDs
>   */
> -static void print_asb100_in(const sensors_chip_name *name, int alarm,
> +static void print_in(const sensors_chip_name *name, int alarm,

This change belongs to a separate (and obviously preliminary) patch.

> +#define PRINT_W83L785R_IN(num, name, alarms) \
> +	print_in((name), (alarms), \
> +		(SENSORS_W83L785R_IN##num), \
> +		(SENSORS_W83L785R_IN##num##_MIN), \
> +		(SENSORS_W83L785R_IN##num##_MAX))
> +
> +#define PRINT_W83L785R_FAN(num, name, alarms) \
> +	print_fan((name), (alarms), \
> +		(SENSORS_W83L785R_FAN##num), \
> +		(SENSORS_W83L785R_FAN##num##_DIV), \
> +		(SENSORS_W83L785R_FAN##num##_MIN))
> +
> +#define PRINT_W83L785R_TEMP(num, name, alarms) \
> +	w83l785r_print_temp((name), (alarms), \
> +		(SENSORS_W83L785R_TEMP##num), \
> +		(SENSORS_W83L785R_TEMP##num##_MAX), \
> +		(SENSORS_W83L785R_TEMP##num##_HYST_MIN), \
> +		(SENSORS_W83L785R_TEMP##num##_CRIT), \
> +		(SENSORS_W83L785R_TEMP##num##_SENS))

This sucks. Just pick the numbers for SENSORS_W83L785R_* in such a way that
you then can use for() loops to handle them and avoid code duplication.

Rest looks OK, at a quick glance at least.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
