From: Simon Guinot <sguinot@lacie.com>
Date: Wed, 20 Oct 2010 16:37:25 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: add generic GPIO fan driver
Message-Id: <1287592646-18109-1-git-send-email-sguinot@lacie.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Guenter,

Here is an updated version for the gpio-fan driver.

v2 changes :

- add support for sysfs attributes fan1_target, fan1_min and fan1_max
- simplify the pwm interface
- add power management support
- fix interrupt handling (allow to share the fan alarm irq)
- fix bugs mostly addressed during code review...

Documentation is still missing.

Thanks,

Simon


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
