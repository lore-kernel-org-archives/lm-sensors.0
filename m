From: Rodolfo Giometti <giometti@enneenne.com>
Date: Mon, 22 Sep 2008 14:06:21 +0000
Subject: [lm-sensors] leds: support for Philips PCA9531 8-bit led dimmer.
Message-Id: <1222092382-22148-1-git-send-email-giometti@enneenne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch adds support for PHILIPS PCA9531.

This chip is an 8-bit I2C & SMBus I/O expander optimizer for dimming LEDs in
256 discrete steps.

The driver uses the linux leds interface to manage the attached leds.

The user may also define an initial chips status by simply defining a
struct pca9531_platform_data as follow:

tatic struct pca9531_platform_data wr1100_pca9531_0_machinfo[] = {
        [PCA9531_LED0] = {
                .name = "power_on_led",
                .trigger = "backlight",
        },
        [PCA9531_LED3] = {
                .name = "lcd",
                .brightness = 255,
                .inverted = 1,
                .trigger = "backlight",
                .pwm = PCA9531_PWM0,
        },
        [PCA9531_LED5] = {
                .name = "power_on",
                .trigger = "backlight",
        },
        [PCA9531_LED6] = {
                .name = "action",
                .trigger = "backlight",
        },
        [PCA9531_LED7] = {
                .name = NULL,
        },
};

Undefined devices will not be enabled.

Rodolfo



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
