From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 13 Jan 2012 08:50:03 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (sysfs-interface) Update tempX_type attribute to be more generic
Message-Id: <20120113095003.7b9b5037@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326440035-1316-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1326440035-1316-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 12 Jan 2012 23:33:55 -0800, Guenter Roeck wrote:
> The temp[1-*]_type attribute reports the temperature sensor type. Sensor type 1
> is described as "PII/Celeron Diode", which is quite restrictive; other CPUs
> may also have an embedded temperature sensor diode with similar characteristics.
> Change description to "CPU embedded diode" to be more generic.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  Documentation/hwmon/sysfs-interface |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
> index a4aa8f6..1f4dd85 100644
> --- a/Documentation/hwmon/sysfs-interface
> +++ b/Documentation/hwmon/sysfs-interface
> @@ -304,7 +304,7 @@ value (fastest fan speed) wins.
>  temp[1-*]_type	Sensor type selection.
>  		Integers 1 to 6
>  		RW
> -		1: PII/Celeron Diode
> +		1: CPU embedded diode
>  		2: 3904 transistor
>  		3: thermal diode
>  		4: thermistor

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
