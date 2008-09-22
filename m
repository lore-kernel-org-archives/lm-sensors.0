From: Rodolfo Giometti <giometti@enneenne.com>
Date: Mon, 22 Sep 2008 13:42:30 +0000
Subject: [lm-sensors] [i2c] support for MAX8821 led charge pump with mono
Message-Id: <1222090951-20567-1-git-send-email-giometti@enneenne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch adds support for MAXIM MAX8821.

This chip integrates a charge pump for white LEDs, an audio loudspeaker
amplifier, and two low noise LDOs controlled by an I2C control interface.

The driver uses the linux leds interface to manage the attached leds
while other devices are managed by simple sysfs entries.

The user may also define an initial chips status by simply defining a
struct max8821_platform_data as follow:

static struct max8821_platform_data wr1100_max8821_machinfo = {
        .led = {
                [MAX8821_LED1] = {
                        .name = "Keyboard",
                        .trigger = "backlight",
                },
                [MAX8821_LED2] = {
                        .name = "LCD",
                        .trigger = "backlight",
                },
                [MAX8821_LED5] = {
                        .name = "red",
                },
        },
        .ldo = {
                [MAX8821_LDO2] = {
                        .power = 1,
                        .voltage = 3000,
                },
        },
        .audio = {
                .power = 1,
                .clock = 1250,
                .gain = 6,
        },
};

Undefined devices will not be enabled.

Rodolfo



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
