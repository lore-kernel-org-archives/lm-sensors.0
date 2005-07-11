From: pgunreben@lucent.com (Gunreben, Peter (Peter))
Date: Mon, 11 Jul 2005 15:48:14 +0000
Subject: [lm-sensors] sensors-detect bug in generating
Message-Id: <FB3C0705909A7E4A9D832D5CD5A4289206D0CF97@ge1884exch001u.de.lucent.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I had problems to configure lm_sensors 2.9.0-3 (SuSE 9.3)
on my Asus A7M266-D (Dual Athlon MP 1900+) board.
Sensors-detect showed the correct chip (AS99127F (rev.2)),
but the driver was missing in the generated file:
/etc/sysconfig/lm_sensors. It seems there's a bug in 
sensors-detect.

> sensors-detect
========8<========
...
Next adapter: SMBus AMD768 adapter at e4e0
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08
Client found at address 0x2d
...
Probing for `Winbond W83792D'... Success!
    (confidence 8, driver `to-be-written'), other addresses: 0x48 0x49
...
Probing for `Asus AS99127F (rev.2)'... Success!
    (confidence 8, driver `w83781d'), other addresses: 0x48 0x49
...
 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:

Driver `to-be-written' (should be inserted):
  Detects correctly:
  * Bus `SMBus AMD768 adapter at e4e0' (Algorithm unavailable)
    Busdriver `i2c-amd756', I2C address 0x2d (and 0x48 0x49)
    Chip `Winbond W83792D' (confidence: 8)

Driver `w83781d' (may not be inserted):
  Misdetects:
  * Bus `SMBus AMD768 adapter at e4e0' (Algorithm unavailable)
    Busdriver `i2c-amd756', I2C address 0x2d (and 0x48 0x49)
    Chip `Asus AS99127F (rev.2)' (confidence: 8)
...
========8<========

>  cat /etc/sysconfig/lm_sensors
========8<========
...
MODULE_0=i2c-amd756
========8<========

I noticed that the chip driver was missing and added:
MODULE_1=w83781d

With this modification, I managed to get some sensor 
output, but the values were still not correct. I'll post this 
problem separately.

