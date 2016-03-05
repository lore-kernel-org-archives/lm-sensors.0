From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 05 Mar 2016 14:29:53 +0000
Subject: Re: [lm-sensors] [PATCH v3 00/25] hwmon: (it87) Various enhancements and fixes
Message-Id: <56DAED61.7050603@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1453860229-23614-1-git-send-email-patchwork@patchwork.roeck-us.net>
In-Reply-To: <1453860229-23614-1-git-send-email-patchwork@patchwork.roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 01/26/2016 06:03 PM, Guenter Roeck wrote:
> From: Guenter Roeck <linux@roeck-us.net>
>
> This patch series builds on top of v4.5-rc1. The series was tested on
> a system with IT8728F. Out-of-kernel versions were tested by various
> people using a github repository.
>
> Most of the patches in this series were previously submitted as part of
> earlier patch series. No substantial changes were made to those patches
> since the previous submission.
>

Jean,

Any idea what to do with this series ?

Guenter

> ----------------------------------------------------------------
> Guenter Roeck (25):
>        hwmon: (it87) Add feature flag for AVCC3 support
>        hwmon: (it87) Add support for all pwm channels on IT8620E
>        hwmon: (it87) Add support for second pwm frequency register
>        hwmon: (it87) Simplify error return in it87_device_add
>        hwmon: (it87) Don't use pdev as static driver variable
>        hwmon: (it87) Pass SIO base address as parameter to superio functions
>        hwmon: (it87) Add support for second Super-IO chip
>        hwmon: (it87) Rearrange code to avoid forward declarations
>        hwmon: (it87) Use is_visible for voltage sensors
>        hwmon: (it87) Use is_visible for temperature sensors
>        hwmon: (it87) Use is_visible for fan attributes
>        hwmon: (it87) Use is_visible for pwm attributes
>        hwmon: (it87) Use single group and is_visible for miscellaneous attributes
>        hwmon: (it87) Convert to use new hwmon API
>        hwmon: (it87) Support up to 6 temperature sensors on IT8620E
>        hwmon: (it87) Simplify reading voltage registers
>        hwmon: (it87) Add support for VIN7 to VIN10 on IT8620E
>        hwmon: (it87) Use BIT macro
>        hwmon: (it87) Use defines for array sizes and sensor counts
>        hwmon: (it87) Formatting cleanup
>        hwmon: (it87) Support disabling fan control for all pwm control and chips
>        hwmon: (it87) Enhance validation for fan4 and fan5
>        hwmon: (it87) Support automatic pwm control on newer chips
>        hwmon: (it87) Fix pwm_temp_map for system with 6 pwm channels
>        hwmon: (it87) Add support for IT8628E
>
>   Documentation/hwmon/it87 |   15 +-
>   drivers/hwmon/Kconfig    |    3 +-
>   drivers/hwmon/it87.c     | 2281 ++++++++++++++++++++++++++--------------------
>   3 files changed, 1300 insertions(+), 999 deletions(-)
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
