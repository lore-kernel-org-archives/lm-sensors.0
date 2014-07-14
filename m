From: Tobias Klauser <tklauser@distanz.ch>
Date: Mon, 14 Jul 2014 14:25:25 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: pwm-fan: Add pwm-fan driver
Message-Id: <20140714142525.GB7668@distanz.ch>
List-Id: <lm-sensors.vger.kernel.org>
References: <1405345835-17089-1-git-send-email-k.debski@samsung.com>
In-Reply-To: <1405345835-17089-1-git-send-email-k.debski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kamil Debski <k.debski@samsung.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, t.figa@samsung.com, m.szyprowski@samsung.com, linux@roeck-us.net, linux-pwm@vger.kernel.org

On 2014-07-14 at 15:50:35 +0200, Kamil Debski <k.debski@samsung.com> wrote:
> The pwm-fan driver enables control of fans connected to PWM lines.
> This driver uses the PWM framework, so it is compatible with all
> PWM devices that provide drivers through the PWM framework.
> 
> Signed-off-by: Kamil Debski <k.debski@samsung.com>
> ---
> Changes since v1:
> - added documentation to Documentation/hwmon
> - fix checkpatch errors
> 	- added extra description to Kconfig
> 	- removed whitespace errors
> - include files rearranged to be in alphabetical order
> - remove unused sysfs entry pwm1_enable
> - changed the behavior of the set_pwm function
> 	- when 0 PWM value is set pwm_disable is run
> 	- pwm_config return value is checked for errors
> - use of ATTRIBUTE_GROUPS was added
> - removed "Not enouch memory" error message
> - fixed probe return value in case of devm_of_pwm_get error
> - changed hwmon_device_register_with_groups to
>   devm_hwmon_device_register_with_groups
> - changes suspend/resume to use pwm_disable/enable
> - removed unnecessary CONFIG_PM_SLEEP ifdefs

pwm_fan_suspend and pwm_fan_resume should still be enclosed in #ifdef
CONFIG_PM_SLEEP, otherwise you'll get 'defined but not used' compiler
warnings when building without CONFIG_PM being set.

Cheers
Tobias

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
