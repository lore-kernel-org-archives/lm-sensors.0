From: gregg@playground.net (Gregory Gee)
Date: Thu, 19 May 2005 06:23:27 +0000
Subject: Urgent lm_sensor question.  System failure??
Message-Id: <3C1E8DFE.D4A8792F@playground.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


  First:

Abit BP6 with dual Celeron 400
Redhat 7.2
lm_sensor 2.5.5
/sbin/modprobe i2c-isa
/sbin/modprobe i2c-piix4
/sbin/modprobe w83781d
/sbin/modprobe eeprom

  Now, I have a quick question about what lm_sensor does.  Does it only read
data or does it also control the fans?  The reason is that recently I have been
getting sensor alarms about my Vcore and also my CPU fans have been individually
turning on, off and slowing down.  Is lm_sensors doing this or is there a major
CPU or motherboard problem.

Thanks,
Greg
