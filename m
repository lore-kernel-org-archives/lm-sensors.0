From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 26 Jun 2006 21:30:27 +0000
Subject: [lm-sensors] Patch: hwmon-abituguru-override-bank1detect.patch
Message-Id: <20060626233027.0170262b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <449E7AD5.4060908@hhs.nl>
In-Reply-To: <449E7AD5.4060908@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

> Now that the abituguru driver is seeing some more widespread testing it
> has turned out that one the first generation of Abit uGuru motherboards,
> with uGuru revision 1, the autodetect bank1 sensor type code doesn't
> (always) work.
> 
> Thispatch adds a module param to override the autodetect, and it adds
> validity checks for the value of the 2 other autodetection override
> module params. An example of howto use the new param can be found here:
> http://lm-sensors.org/wiki/Configurations/Abit/AN7
> 
> It would be nice if this patch could be merged before 2.6.18, as without
> it the uguru driver is useless for people with the affected motherboards.

Fine with me, except for:

> --- linux-2.6.17-rc4-mm1.orig/drivers/hwmon/abituguru.c	2006-06-25 13:49:18.000000000 +0200
> +++ linux-2.6.17-rc4-mm1/drivers/hwmon/abituguru.c	2006-06-25 13:51:17.000000000 +0200
> @@ -142,6 +142,14 @@
>  static int force;
>  module_param(force, bool, 0);
>  MODULE_PARM_DESC(force, "Set to one to force detection.");
> +static int bank1_types[16] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
> +	-1, -1, -1, -1 };

This "16" is actually ABIT_UGURU_MAX_BANK1_SENSORS, right?

> +module_param_array(bank1_types, int, NULL, 0);
> +MODULE_PARM_DESC(bank1_types, "Bank1 sensortype autodetection override:\n"
> +	"   -1 autodetect\n"
> +	"    0 volt sensor\n"
> +	"    1 temp sensor\n"
> +	"    2 not connected");

The "-1" is a detail implementation, user-space doesn't need to know
about it.

-- 
Jean Delvare

