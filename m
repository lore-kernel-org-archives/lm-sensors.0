From: Doug Anderson <dianders@chromium.org>
Date: Mon, 09 Jun 2014 21:03:00 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ntc_thermistor) Fix dependencies
Message-Id: <CAD=FV=WRY8KqAJqKiSRKSAhPUftngYb13PaEpbz5qDyS_qvqXw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140521140115.532fc0b2@endymion.delvare>
In-Reply-To: <20140521140115.532fc0b2@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean,

On Wed, May 21, 2014 at 5:01 AM, Jean Delvare <jdelvare@suse.de> wrote:
> In commit 9e8269de, support was added for ntc_thermistor devices being
> declared in the device tree and implemented on top of IIO. With that
> change, a dependency was added to the ntc_thermistor driver:
>
>         depends on (!OF && !IIO) || (OF && IIO)
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
>  drivers/hwmon/Kconfig          |    2 +-
>  drivers/hwmon/ntc_thermistor.c |    4 +++-
>  2 files changed, 4 insertions(+), 2 deletions(-)

Also too late to matter, but confirming that I can still build with
this and see thermistors.  In my case I've got the thermistors
compiled as modules...

I've got an early-rev exynos5250-snow (that still had thermistors on
it) and have hacked them into the device tree with:

diff --git a/arch/arm/boot/dts/exynos5250-snow.dts
b/arch/arm/boot/dts/exynos5250-snow.dts
index 079fdf9..28acb52 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -20,6 +20,39 @@
                i2c104 = &i2c_104;
        };

+       adc@12D10000 {
+               status = "okay";
+               vdd-supply = <&buck5_reg>;
+               ncp15wb473@3 {
+                       compatible = "ntc,ncp15wb473";
+                       pullup-uv = <1800000>;
+                       pullup-ohm = <47000>;
+                       pulldown-ohm = <0>;
+                       io-channels = <&adc 3>;
+               };
+               ncp15wb473@4 {
+                       compatible = "ntc,ncp15wb473";
+                       pullup-uv = <1800000>;
+                       pullup-ohm = <47000>;
+                       pulldown-ohm = <0>;
+                       io-channels = <&adc 4>;
+               };
+               ncp15wb473@5 {
+                       compatible = "ntc,ncp15wb473";
+                       pullup-uv = <1800000>;
+                       pullup-ohm = <47000>;
+                       pulldown-ohm = <0>;
+                       io-channels = <&adc 5>;
+               };
+               ncp15wb473@6 {
+                       compatible = "ntc,ncp15wb473";
+                       pullup-uv = <1800000>;
+                       pullup-ohm = <47000>;
+                       pulldown-ohm = <0>;
+                       io-channels = <&adc 6>;
+               };
+       };
+
        rtc@101E0000 {
                status = "okay";
        };

-Doug

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
