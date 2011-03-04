From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 04 Mar 2011 08:43:12 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: Add tachometer pulses per fan
Message-Id: <20110304094312.5658b6df@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1299204264-10435-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1299204264-10435-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 3 Mar 2011 18:04:24 -0800, Guenter Roeck wrote:
> Some fan control chips support a configuration register to set the number of
> tachometer pulses per fan revolution. Add an ABI attribute to support this
> configuration register.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>

Acked-by: Jean Delvare <khali@linux-fr.org>

> ---
> v2: Added more details to attribute description
> 
>  Documentation/hwmon/sysfs-interface |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
> index c6559f1..83a6987 100644
> --- a/Documentation/hwmon/sysfs-interface
> +++ b/Documentation/hwmon/sysfs-interface
> @@ -187,6 +187,17 @@ fan[1-*]_div	Fan divisor.
>  		Note that this is actually an internal clock divisor, which
>  		affects the measurable speed range, not the read value.
>  
> +fan[1-*]_pulses	Number of tachometer pulses per fan revolution.
> +		Integer value, typically between 1 and 4.
> +		RW
> +		This value is a characteristic of the fan connected to the
> +		device's input, so it has to be set in accordance with the fan
> +		model.
> +		Should only be created if the chip has a register to configure
> +		the number of pulses. In the absence of such a register (and
> +		thus attribute) the value assumed by all devices is 2 pulses
> +		per fan revolution.
> +
>  fan[1-*]_target
>  		Desired fan speed
>  		Unit: revolution/min (RPM)


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
