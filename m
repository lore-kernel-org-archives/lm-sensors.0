From: przemek.kulik@neostrada.pl (=?iso-8859-2?Q?Przemys=B3aw?= Kulik)
Date: Mon, 03 Apr 2006 21:50:11 +0000
Subject: [lm-sensors] [Fwd: Sensor readings from Gigabyte I915P Duo Pro
Message-Id: <1144101011.28472.17.camel@localhost>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Just as ruik adviced on #linux-sensors:
Here's what I get after chnaging sensor type to diode:
M/B Temp:    +96?C  (low  =   +15?C, high =   +40?C)   sensor = diode
CPU Temp:    +96?C  (low  =   +15?C, high =   +45?C)   sensor = diode
Temp3:       +33?C  (low  =   +15?C, high =   +45?C)   sensor = diode

Are you sure about Temp3 being CPU temp? I don't know if ther is any
corelation but:
fan1:      756 RPM  (min =    0 RPM, div = 8)
fan2:     1480 RPM  (min = 3013 RPM, div = 8)          ALARM
fan3:        0 RPM  (min = 3013 RPM, div = 8)
fan1 and fan2 are CPU and acse fans

hddtemp shows:
# hddtemp /dev/hde
/dev/hde: WDC WD2000BB-00DWA0:  34?C or ?F
while temp3 is 33?C

--
p3k4

-------- Przesy?any list ----------
Od: Przemek Kulik <przemek.kulik at gmail.com>
Dla: lm-sensors at lm-sensors.org
Temat: Sensor readings from Gigabyte I915P Duo Pro (IT8712F)
Data: Mon, 03 Apr 2006 20:33:26 +0200

I don't know if it is the right place to ask this question. If not,
plase disregard this note.

I get strange reading from M/B and CPU i.e.
M/B Temp:    -55?C  (low = +15?C, high = +40?C) sensor = thermistor
CPU Temp:     -2?C  (low = +15?C, high = +45?C) sensor = thermistor
Temp3:       +33?C  (low = +15?C, high = +45?C) sensor = diode

I tried to get it right by changing sensor type in sensors.conf but it
didn't work. Any tip would be appreciated

Cheers
--
p3k4



