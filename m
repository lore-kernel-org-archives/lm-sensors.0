From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 12 Mar 2013 05:38:54 +0000
Subject: Re: [lm-sensors] [PATCH v4 2/3] ab8500: re-arrange ab8500 power and temperature data tables
Message-Id: <20130312053854.GC20995@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1362730411-11112-3-git-send-email-hongbo.zhang@linaro.org>
In-Reply-To: <1362730411-11112-3-git-send-email-hongbo.zhang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Mar 08, 2013 at 04:13:30PM +0800, Hongbo Zhang wrote:
> This patch moves the data tables from driver/power/ab8500_bmdata.c to a common
> header file include/linux/power/ab8500.h, so that other modules such as ab8500
> hwmon can use these data. This patch also renames these variable names to
> eliminate CamelCase warnings from checkpatch.pl, and adds const attribute to
> these data.
> 
> Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>

[ ... ]

>  /**
> diff --git a/include/linux/power/ab8500.h b/include/linux/power/ab8500.h
> new file mode 100644
> index 0000000..3916b12
> --- /dev/null
> +++ b/include/linux/power/ab8500.h
> @@ -0,0 +1,189 @@
> +/*
> + * Copyright (C) ST-Ericsson 2013
> + * Author: Hongbo Zhang <hongbo.zhang@linaro.com>
> + * License terms: GNU General Public License v2
> + */
> +
> +#ifndef PWR_AB8500_H
> +#define PWR_AB8500_H
> +
> +#include <linux/mfd/abx500.h>
> +#include <linux/mfd/abx500/ab8500-bm.h>
> +
> +/*
> + * These are the defined batteries that uses a NTC and ID resistor placed
> + * inside of the battery pack.
> + * Note that the res_to_temp table must be strictly sorted by falling
> + * resistance values to work.
> + */
> +static const struct abx500_res_to_temp ab8500_temp_tbl_a[] = {
> +	{-5, 53407},
> +	{ 0, 48594},
> +	{ 5, 43804},
> +	{10, 39188},
> +	{15, 34870},
> +	{20, 30933},
> +	{25, 27422},
> +	{30, 24347},
> +	{35, 21694},
> +	{40, 19431},
> +	{45, 17517},
> +	{50, 15908},
> +	{55, 14561},
> +	{60, 13437},
> +	{65, 12500},
> +};
> +
> +static const struct abx500_res_to_temp ab8500_temp_tbl_b[] = {
> +	{-5, 200000},
> +	{ 0, 159024},
> +	{ 5, 151921},
> +	{10, 144300},
> +	{15, 136424},
> +	{20, 128565},
> +	{25, 120978},
> +	{30, 113875},
> +	{35, 107397},
> +	{40, 101629},
> +	{45,  96592},
> +	{50,  92253},
> +	{55,  88569},
> +	{60,  85461},
> +	{65,  82869},
> +};
> +
> +static const struct abx500_v_to_cap ab8500_cap_tbl_a[] = {
> +	{4171,	100},
> +	{4114,	 95},
> +	{4009,	 83},
> +	{3947,	 74},
> +	{3907,	 67},
> +	{3863,	 59},
> +	{3830,	 56},
> +	{3813,	 53},
> +	{3791,	 46},
> +	{3771,	 33},
> +	{3754,	 25},
> +	{3735,	 20},
> +	{3717,	 17},
> +	{3681,	 13},
> +	{3664,	  8},
> +	{3651,	  6},
> +	{3635,	  5},
> +	{3560,	  3},
> +	{3408,    1},
> +	{3247,	  0},
> +};
> +
> +static const struct abx500_v_to_cap ab8500_cap_tbl_b[] = {
> +	{4161,	100},
> +	{4124,	 98},
> +	{4044,	 90},
> +	{4003,	 85},
> +	{3966,	 80},
> +	{3933,	 75},
> +	{3888,	 67},
> +	{3849,	 60},
> +	{3813,	 55},
> +	{3787,	 47},
> +	{3772,	 30},
> +	{3751,	 25},
> +	{3718,	 20},
> +	{3681,	 16},
> +	{3660,	 14},
> +	{3589,	 10},
> +	{3546,	  7},
> +	{3495,	  4},
> +	{3404,	  2},
> +	{3250,	  0},
> +};
> +
> +static const struct abx500_v_to_cap ab8500_cap_tbl[] = {
> +	{4186,	100},
> +	{4163,	 99},
> +	{4114,	 95},
> +	{4068,	 90},
> +	{3990,	 80},
> +	{3926,	 70},
> +	{3898,	 65},
> +	{3866,	 60},
> +	{3833,	 55},
> +	{3812,	 50},
> +	{3787,	 40},
> +	{3768,	 30},
> +	{3747,	 25},
> +	{3730,	 20},
> +	{3705,	 15},
> +	{3699,	 14},
> +	{3684,	 12},
> +	{3672,	  9},
> +	{3657,	  7},
> +	{3638,	  6},
> +	{3556,	  4},
> +	{3424,	  2},
> +	{3317,	  1},
> +	{3094,	  0},
> +};
> +
> +/*
> + * Note that the res_to_temp table must be strictly sorted by falling
> + * resistance values to work.
> + */
> +static const struct abx500_res_to_temp ab8500_temp_tbl[] = {
> +	{-5, 214834},
> +	{ 0, 162943},
> +	{ 5, 124820},
> +	{10,  96520},
> +	{15,  75306},
> +	{20,  59254},
> +	{25,  47000},
> +	{30,  37566},
> +	{35,  30245},
> +	{40,  24520},
> +	{45,  20010},
> +	{50,  16432},
> +	{55,  13576},
> +	{60,  11280},
> +	{65,   9425},
> +};
> +
> +/*
> + * Note that the batres_vs_temp table must be strictly sorted by falling
> + * temperature values to work.
> + */
> +static const struct batres_vs_temp ab8500_temp_to_batres_tbl[] = {
> +	{ 40, 120},
> +	{ 30, 135},
> +	{ 20, 165},
> +	{ 10, 230},
> +	{ 00, 325},
> +	{-10, 445},
> +	{-20, 595},
> +};
> +
> +/*
> + * Note that the batres_vs_temp table must be strictly sorted by falling
> + * temperature values to work.
> + */
> +static const struct batres_vs_temp ab8500_temp_to_batres_tbl_ext[] = {
> +	{ 60, 300},
> +	{ 30, 300},
> +	{ 20, 300},
> +	{ 10, 300},
> +	{ 00, 300},
> +	{-10, 300},
> +	{-20, 300},
> +};
> +
> +/* battery resistance table for LI ION 9100 battery */
> +static const struct batres_vs_temp ab8500_temp_to_batres_tbl_9100[] = {
> +	{ 60, 180},
> +	{ 30, 180},
> +	{ 20, 180},
> +	{ 10, 180},
> +	{ 00, 180},
> +	{-10, 180},
> +	{-20, 180},
> +};
> +

I don't think it is a good idea to define static variables in an include
file.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
