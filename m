From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Thu, 06 Jan 2011 15:39:32 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add humidity attribute to sysfs ABI
Message-Id: <4D25E234.6020007@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1294329642-9282-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1294329642-9282-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 01/06/11 16:00, Guenter Roeck wrote:
> The humidity attribute is already supported by the sht15 driver, and another
> driver supporting it is about to be added. Make it official.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  Documentation/hwmon/sysfs-interface |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
> index 5997b5e..033fe76 100644
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
> +				Unit: percent
> +				RO
> +
> +
>  **********
>  * Alarms *
>  **********


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
