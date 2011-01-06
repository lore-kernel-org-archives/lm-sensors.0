From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 06 Jan 2011 19:21:03 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: Add humidity attribute to sysfs
Message-Id: <20110106202103.61b40ba7@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1294339617-12308-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1294339617-12308-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 6 Jan 2011 10:46:57 -0800, Guenter Roeck wrote:
> The humidity attribute is already supported by the sht15 driver, and another
> driver supporting it is about to be added. Make it official.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>

Acked-by: Jean Delvare <khali@linux-fr.org>

> ---
> v2: Updated humidity units to be reported in milli-percent
> 
>  Documentation/hwmon/sysfs-interface |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
> index 5997b5e..79411cb 100644
> --- a/Documentation/hwmon/sysfs-interface
> +++ b/Documentation/hwmon/sysfs-interface
> @@ -505,6 +505,15 @@ energy[1-*]_input		Cumulative energy use
>  				RO
>  
>  
> +************
> +* Humidity *
> +************
> +
> +humidity[1-*]_input		Humidity
> +				Unit: milli-percent (per cent mille, pcm)
> +				RO
> +
> +
>  **********
>  * Alarms *
>  **********


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
