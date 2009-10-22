From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 22 Oct 2009 07:27:53 +0000
Subject: Re: [lm-sensors] [PATCH] acpi_power_meter: Don't leak ACPI error
Message-Id: <20091022092753.1b4b9706@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091022010137.GB21723@tux1.beaverton.ibm.com>
In-Reply-To: <20091022010137.GB21723@tux1.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: djwong@us.ibm.com
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Wed, 21 Oct 2009 18:01:37 -0700, Darrick J. Wong wrote:
> acpi-power-meter: Don't leak ACPI error codes to userspace
> 
> If the ACPI methods return an error code, we must return -EINVAL to userspace
> to flag the error.  Right now we pass the (positive) number right through,
> which causes echo to keep writing bogus values.
> 
> Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>

Acked-by: Jean Delvare <khali@linux-fr.org>

> ---
> 
>  drivers/acpi/power_meter.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> 
> diff --git a/drivers/acpi/power_meter.c b/drivers/acpi/power_meter.c
> index e6bfd77..2ef7030 100644
> --- a/drivers/acpi/power_meter.c
> +++ b/drivers/acpi/power_meter.c
> @@ -294,7 +294,11 @@ static int set_acpi_trip(struct acpi_power_meter_resource *resource)
>  		return -EINVAL;
>  	}
>  
> -	return data;
> +	/* _PTP returns 0 on success, nonzero otherwise */
> +	if (data)
> +		return -EINVAL;
> +
> +	return 0;
>  }
>  
>  static ssize_t set_trip(struct device *dev, struct device_attribute *devattr,

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
