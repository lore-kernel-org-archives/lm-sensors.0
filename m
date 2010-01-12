From: Juan RP <xtraeme@gmail.com>
Date: Tue, 12 Jan 2010 18:53:51 +0000
Subject: [lm-sensors] [PATCH] asus_atk0110: MBIF method not always present
Message-Id: <20100112195351.492ea302.xtraeme@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi,

The asus_atk0110.c module failed to populate /sys/class/hwmon
entries on this board ASUSTeK Computer INC. P5L-VM 1394
(as reported by sensors-detect) after loading the module.

After looking at the code and the ACPI DSDT, the MBIF method
is not found, but the required methods for old probing are there
so I made a patch that does not treat MBIF missing as fatal.

With the patch applied I can read the sensors ok:

[juan@nocturno ~]$ sensors
atk0110-acpi-0
Adapter: ACPI interface
Vcore Voltage:   +1.24 V  (min =  +0.85 V, max =  +1.60 V)
 +3.3 Voltage:   +3.26 V  (min =  +2.97 V, max =  +3.63 V)
 +5 Voltage:     +4.99 V  (min =  +4.50 V, max =  +5.50 V)
 +12 Voltage:   +12.14 V  (min = +10.20 V, max = +13.80 V)
CPU FAN Speed:  1383 RPM  (min =    0 RPM)
CPU Temperature: +24.0°C  (high = +60.0°C, crit = +95.0°C)  
MB Temperature:  +36.0°C  (high = +45.0°C, crit = +95.0°C)  

[juan@nocturno ~]$

This matches what the FreeBSD/NetBSD code does in the aiboost(4)
driver (which I ported from FreeBSD to NetBSD in 2007).

The patch is against vanilla kernel-2.6.32.3 sources. Please CC me
if you reply to this thread because I'm not subscribed to this list.

http://xbps.nopcode.org/linux/patches/asus_atk0110_missing_MBIF_method_not_fatal.diff

Thanks.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
