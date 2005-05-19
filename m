From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: LIRC and Mandrake 10.1
Message-Id: <20050426205136.151526d9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0504261818510.2812@myl-uhtb.qbzn>
In-Reply-To: <Pine.LNX.4.58.0504261818510.2812@myl-uhtb.qbzn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Karel,

> I have problem with lm_sensors (Ver: 2.8.7 Release: 4mdk) in my new
> Mandrake 10.1 (kernel 2.6.8.1-24mdk). HW: QDI KinetiZ 7EA (via
> kt133a/686b), Duron 866, DIMM 128 + DIMM 64
> 
> On my Mandrake 9.2 (kernel 2.4.22) was everything OK. DIMM modules
> were identified, via686 sensors too and all was accesable via
> /proc/sys/dev/sensors too.
> 
> Now:
> 1. there is no interface in /proc ?! (module i2c-proc (like in
> lm_sensors for 2.4 kernel ?))
> 2. eeprom module gives no information

In 2.6 the sensors data is found under /sys/bus/i2c/. i2c-proc was (more
or less) renamed to i2c-sensor.

Up to 2.6.10, i2c-viapro and via686a conflict with each other, so only
the first one loaded will work, as you could see. You need i2c-viapro to
access the EEPROMs, and via686a for the sensors, which is why you can't
get both at the same time. This was fixed in 2.6.11.

Hope that helps,
-- 
Jean Delvare
