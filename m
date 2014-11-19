From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 19 Nov 2014 22:07:32 +0000
Subject: Re: [lm-sensors] [PATCHv0] hwmon: g762: fix call to devm_hwmon_device_register_with_groups()
Message-Id: <20141119220732.GA10376@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <3b385cc3fdf1884f8902c015c7fa40b7133fd7b8.1416433516.git.arno@natisbad.org>
In-Reply-To: <3b385cc3fdf1884f8902c015c7fa40b7133fd7b8.1416433516.git.arno@natisbad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Nov 19, 2014 at 10:52:36PM +0100, Arnaud Ebalard wrote:
> 
> g762_remove() needs to first call hwmon_device_unregister() and then
> g762_of_clock_disable(). For that reason, it is not possible to
> convert it to devm_hwmon_device_register_with_groups() and the
> the non device managed version must be used.
> 
> This is correctly stated in commit message for 398e16db6262 ("hwmon:
> (g762) Convert to hwmon_device_register_with_groups") but the
> associated changes do in fact introduce a call to the device managed
> version of the function.
> 
> This patch fixes that typo by switching to the non devm_ version.
> 
> Fixes: 398e16db6262 ("hwmon: (g762) Convert to hwmon_device_register_with_groups")
> Cc: stable@vger.kernel.org (3.17+)
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>

Good catch.

Applied, thanks.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
