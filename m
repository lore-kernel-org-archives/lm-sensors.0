From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 13 Oct 2011 14:33:16 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/2] hwmon: Add unspecified temperature
Message-Id: <20111013163316.5bbfb87c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 27 Sep 2011 15:33:50 -0700, Guenter Roeck wrote:
> Some recent temperature sensor chips provide thresholds which are not associated
> with lower or upper limits. The use of those thresholds is application specific.
> 
> Provide sysfs ABI attributes to support such thresholds.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
>  Documentation/hwmon/sysfs-interface |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
> index a4aa8f6..42eeec0 100644
> --- a/Documentation/hwmon/sysfs-interface
> +++ b/Documentation/hwmon/sysfs-interface
> @@ -394,6 +394,22 @@ temp_reset_history
>  		Reset temp_lowest and temp_highest for all sensors
>  		WO
>  
> +temp[1-*]_threshold[1-*]
> +		Unspecified threshold. Use if the chip provides temperature
> +		thresholds which are not associated with lower or upper limits.
> +		RW
> +		Unit: millidegree Celsius
> +
> +temp[1-*]_threshold[1-*]_triggered
> +		Channel trigger information.
> +		0: Temperature did not cross threshold.
> +		1: Temperature crossed threshold in either direction.
> +		RW
> +		Contrary to regular alarm flags which clear themselves
> +		automatically when read, this one sticks until cleared by
> +		the user. This is done by writing 0 to the file. Writing
> +		other values is unsupported.
> +
>  Some chips measure temperature using external thermistors and an ADC, and
>  report the temperature measurement as a voltage. Converting this voltage
>  back to a temperature (or the other way around for limits) requires

Looks good, assuming that we actually want to implement this in hwmon
drivers and not somewhere else in the kernel. See my reply to patch 2/2.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
