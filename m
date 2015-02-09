From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 09 Feb 2015 04:44:46 +0000
Subject: [lm-sensors] [GIT PULL] hwmon updates for 3.20
Message-Id: <1423457086-15421-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Linus,

Please pull hwmon updates for Linux 3.20 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus-v3.20

Thanks,
Guenter
------

The following changes since commit 26bc420b59a38e4e6685a73345a0def461136dce:

  Linux 3.19-rc6 (2015-01-25 20:04:41 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next

for you to fetch changes up to dd378b1bcaa0ef5b14cca1e52b58ef9a3279fd8b:

  hwmon: (tmp102) add hibernation callbacks (2015-02-03 12:17:12 -0800)

----------------------------------------------------------------
Asaf Vertz (1):
      hwmon: (abx500) Fix format string warnings

Bartosz Golaszewski (7):
      hwmon: (ina2xx) reinitialize the chip in case it's been reset
      hwmon: (ina2xx) remove a stray new line
      hwmon: (ina2xx) don't accept shunt values greater than the calibration factor
      hwmon: (ina2xx) make shunt resistance configurable at run-time
      hwmon: (ina2xx) implement update_interval attribute for ina226
      hwmon: (ina2xx) remove an unnecessary dev_get_drvdata() result check
      hwmon: (ina2xx) use DIV_ROUND_CLOSEST() to avoid rounding errors

Grygorii Strashko (1):
      hwmon: (tmp102) add hibernation callbacks

Guenter Roeck (5):
      hwmon: (jc42) Use sign_extend32 for sign extension
      hwmon: (jc42) Fix integer overflow
      hwmon: (jc42) Fix integer overflow when writing hysteresis value
      hwmon: (ads2828) Convert to use regmap
      hwmon: (ads2828) Only keep data in device data structure if needed

Jean Delvare (1):
      hwmon: (jc42) Allow negative hysteresis temperatures

Kevin Hilman (1):
      hwmon: (ina2xx) Add ina231 compatible string

Krzysztof Kozlowski (1):
      hwmon: (nct7802) Constify struct regmap_config

Rasmus Villemoes (2):
      hwmon: (ad7314) Do proper sign extension
      hwmon: (adc128d818) Do proper sign extension

 Documentation/hwmon/ina2xx |  23 +++-
 drivers/hwmon/Kconfig      |   5 +-
 drivers/hwmon/abx500.c     |   6 +-
 drivers/hwmon/ad7314.c     |   5 +-
 drivers/hwmon/adc128d818.c |   3 +-
 drivers/hwmon/ads7828.c    | 102 ++++++--------
 drivers/hwmon/ina2xx.c     | 334 +++++++++++++++++++++++++++++++++++++++------
 drivers/hwmon/jc42.c       |  15 +-
 drivers/hwmon/nct7802.c    |   2 +-
 drivers/hwmon/tmp102.c     |  15 +-
 10 files changed, 375 insertions(+), 135 deletions(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
