From: Insop Song <insop.song@gmail.com>
Date: Sat, 20 Jul 2013 17:25:01 +0000
Subject: [lm-sensors] Configuring PMbus VOUT_COMMAND
Message-Id: <CACzyEJ9tdP9PhnPFmcS9VoEtr+27HZfoLPdxZ0O_O=wfYEQ6wA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

I am using "pmbus/ltc2978.c" to use ltc3880
(http://cds.linear.com/docs/en/datasheet/3880fa.pdf)

I wanted to configure VOUT_COMMAND (0x21, nominal output voltage set
point) to adjust supply voltage per device.

VOUT_COMMAND is not exposed to sysfs for the right reasons, such as
hwmon/pmbus subsystem is for mainly monitoring not commanding;
moreover, to avoid error-prone operations to critical configurations.
And I've read Documentation/hwmon/sysfs-interface recommendation.

So instead of adding it to sysfs, I take a different direction and
I've made a change within ltc2978.c to accommodate my need as follows:
- add miscdevice to ltc2978
- use ioctl to configure VOUT_COMMAND

A quick prototype works fine, and before I proceed any further, I want
to ask your inputs and suggestions on this directions.

A patch sending out should be a next step, once I get your input.

Please let me know what you think,

Thank you,

Regards,

Insop Song

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
