From: vr@aradio.ru (Victor A. Bykov)
Date: Wed, 15 Feb 2006 11:10:06 +0000
Subject: [lm-sensors] w83781d and empty /sys/class/hwmon
Message-Id: <030d01c63220$60c0ace0$5964a8c0@office.aradio.ru>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

???????????
????:  lm-sensors at lm-sensors.org
??: ????????? ????????????? ????? ?????? ?????????
????: w83781d and empty /sys/class/hwmon

Strange thing, in kernel 2.6.15.4 I have following modules loaded w83781d, hwmon_vid, hwmon, w83781d, i2c_isa, i2c_piix4, i2c_dev, 
i2c_core.
But directory /sys/class/hwmon is empty, and sensors -s does not work!
while sensors-detect shows
Driver `w83781d' (should be inserted):
  Detects correctly:
  * Bus `SMBus PIIX4 adapter at e800'
    Busdriver `i2c-piix4', I2C address 0x2d (and 0x48 0x49)
    Chip `Asus AS99127F (rev.1)' (confidence: 8)



????/?????: 15.02.2006 14:10:14
???????: + 7 (495) 258-33-44
E-mail: vr at aradio.ru
??? ????: http://www.avtoradio.ru

