From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 18 Jun 2010 16:06:31 +0000
Subject: [lm-sensors] [PATCH 0/3} hwmon: Driver for SMM665 Six-Channel
Message-Id: <1276877194-28214-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Andrew Morton <akpm@linux-foundation.org>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

This driver adds support for the hardware monitoring features of the Summit
Microelectronics SMM665 Six-Channel Active DC Output Controller/Monitor.

Issues/questions/notes:
- Some of the command register enum values are currently unused.
  Keep or remove ?
- Critical voltage values are not supported by the current sysfs API,
  though available from the chip. Would it make sense to report those values,
  e.g. as inX_min_crit and inX_max_crit ? 
  Note: This also applies to PMBus chips, so the question will come up again.
- It would be nice to be able to support other variants of this chip,
  but I have no means to test it. Some test coverage by others would be helpful.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
