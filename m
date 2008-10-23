From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 23 Oct 2008 08:34:13 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add LTC4245 driver
Message-Id: <20081023103413.7fe8e39a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081020160308.GA22915@ovro.caltech.edu>
In-Reply-To: <20081020160308.GA22915@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 22 Oct 2008 16:21:29 -0700, Ira Snyder wrote:
> Add Linux support for the Linear Technology LTC4245 Multiple Supply Hot
> Swap controller I2C monitoring interface.
> 
> Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
> ---
> 
> Yet another revision of the ltc4245 driver. :)
> 
> Changes v5 -> v6:
>   * handle errors consistently
> 
> Changes v4 -> v5:
>   * rename the variable "current" to "curr" to workaround brokenness
>     in asm/current.h on x86, powerpc64, etc.
>   * check for errors when reading from i2c
>   * disable probing, add example usage of force param to documentation
>   * add missing #include <linux/kernel.h>
>   * use i2c_smbus_read_byte_data() rather than ltc4245_read_reg()
>   * const-ify some variables
> 
> Changes v3 -> v4:
>   * simplify ltc4245_get_voltage(), removing special casing for -12v
>   * power should always be a positive value
> 
> Changes v2 -> v3:
>   * fix units (power?_input in uW, curr?_input in mA)
>   * combine all alarm functions
>   * rename power[1-4]_alarm to in[5-8]_min_alarm, per suggestions
> 
> Changes v1 -> v2:
>   * fixed checkpatch warnings
>   * removed raw register access, per suggestions
>   * changed sysfs interface, per suggestions (current, power, alarms)
> 
>  Documentation/hwmon/ltc4245 |   81 ++++++
>  drivers/hwmon/Kconfig       |   11 +
>  drivers/hwmon/Makefile      |    1 +
>  drivers/hwmon/ltc4245.c     |  567 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 660 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/hwmon/ltc4245
>  create mode 100644 drivers/hwmon/ltc4245.c

Applied, thanks :)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
