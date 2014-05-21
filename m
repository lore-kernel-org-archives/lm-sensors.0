From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 21 May 2014 14:26:01 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ntc_thermistor) Fix dependencies
Message-Id: <537CB779.2040702@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140521140115.532fc0b2@endymion.delvare>
In-Reply-To: <20140521140115.532fc0b2@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 05/21/2014 05:01 AM, Jean Delvare wrote:
> In commit 9e8269de, support was added for ntc_thermistor devices being
> declared in the device tree and implemented on top of IIO. With that
> change, a dependency was added to the ntc_thermistor driver:
>
> 	depends on (!OF && !IIO) || (OF && IIO)
>
> This construct has the drawback that the driver can no longer be
> selected when OF is set and IIO isn't, nor when IIO is set and OF is
> not. This is a regression for the original users of the driver.
>
> As the new code depends on IIO and is useless without OF, include it
> only if both are enabled, and set the dependencies accordingly. This
> is clearer, more simple and more correct.
>
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Fixes: 9e8269de hwmon: (ntc_thermistor) Add DT with IIO support to NTC thermistor driver
> Cc: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Doug Anderson <dianders@chromium.org>
> ---
> I've build-tested all option combinations (or so I believe) but
> I don't have the hardware for functional testing. If Naveen or Doug
> could test to confirm I didn't break anything, that would be great.
>
> This is a regression so the fix is candidate for stable trees. I don't
> know if this worries people enough in practice to justify it though.
>

Good catch, for both patches. Do you want to take it, or should I ?

For both patches:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
