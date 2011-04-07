From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 07 Apr 2011 14:52:05 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: Driver for MAX16065/MAX16066
Message-Id: <20110407145205.GA31369@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302135933-29561-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1302135933-29561-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Apr 06, 2011 at 08:25:33PM -0400, Guenter Roeck wrote:
> This patch adds hardware monitoring support for Maxim MAX16065, MAX16066,
> MAX16067, MAX16068, MAX16070, and MAX16071 flash-configurable system managers
> and monitors with nonvolatile fault registers.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
> v2:
> 
> - Added support for MAX16067, MAX16068, MAX16070, and MAX16070 (untested).

	... and MAX16071, not MAX16070 twice ;)

> - Refer to Documentation/i2c/instantiating-devices for details about device
>   instantiation.
> - Define and use MAX16065_SCALE(x) instead of MAX16065_SCALE_BASE + x.
> - Replace MAX16065_SECONDARY(x), MAX16065_CRIT(x), and MAX16065_LCRIT(x) with
>   MAX16065_LIMIT(l, x), where l is 0, 1, or 2.
> - Removed several unused / duplicate defines.
> - Replaced function macros with inline functions.
> - Replaced secondary[], lcrit[], and crit[] arrays in max16065_data with
>   two-dimensional array limit[nLimit][nAdc].
> - In max16065_read_adc(), use single 16-bit read instead of two 8-bit read
>   operations to ensure that data is consistent.
> - In max16065_update_device(), only read device registers if the device supports
>   it. Specifically, use data->num_adc instead of MAX16065_NUM_ADC, and only read
>   current sense information if supported and enabled.
> - In max16065_show_alarm(), use to_i2c_client(dev) directly and drop 'client'
>   variable.
> - Use unlikely() for all error checks.
> - Use single function to read and set all limits.
> - When setting a limit, ensure that limit range is valid.
> - In sensor groups, remove unnecessary ',' after NULL entries.
> - Rearranged sensor groups to be more flexible regarding the number of supported
>   sensors. Use sysfs_create_file() instead of sysfs_create_group() to create
>   sysfs entries for groups supporting a variable number of sensors (voltages and
>   voltage limits).
> 
Should have mentioned: Platform data to configure the current sense resistor value
is not there yet. Right now I have no means to test that (I use a test board, not
the real HW). Plan is to add that with a patch once I get real HW (with its own 
kernel and platform files) to play with.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
