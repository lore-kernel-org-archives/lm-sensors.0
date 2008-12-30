From: Gabriel C <crazy@frugalware.org>
Date: Tue, 30 Dec 2008 14:28:49 +0000
Subject: Re: [lm-sensors] [RFC] Asus ATK0110 ACPI hwmon driver
Message-Id: <495A3021.1020109@frugalware.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081229205537.GA11072@dreamland.darkstar.lan>
In-Reply-To: <20081229205537.GA11072@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Luca Tettamanti wrote:

> On Tue, Dec 30, 2008 at 3:01 PM, Gabriel C <crazy@frugalware.org> wrote:
>>> I'm once again submitting my driver for ASUS ATK0110 sensor interface,
>>> re-based against kernel v2.6.28. Comments are welcome :)
> [...]
>> Your patch works fine on my motherboard , here is the output when loading the driver :
> 
> yay :)
> 
>> however do I need some patches against lmsensors 2.* / 3.* to make sensors display the data from the ATK driver ?
> 
> Ah, yes:
> http://thread.gmane.org/gmane.linux.drivers.sensors/18322
> 
> libsensors ignores the unknown 'acpi' bus.


Ah right I remember now :) With the patch all seems fine , thx :)

...

atk0110-acpi-0
Adapter: ACPI device
Vcore Voltage:     +1.11 V  (min =  +0.85 V, max =  +1.60 V)
 +3.3 Voltage:     +3.26 V  (min =  +2.97 V, max =  +3.63 V)
 +5 Voltage:       +4.97 V  (min =  +4.50 V, max =  +5.50 V)
 +12 Voltage:     +11.87 V  (min = +10.20 V, max = +13.80 V)
CPU FAN Speed:     846 RPM  (min =  600 RPM)
CHASSIS FAN Speed:   0 RPM  (min =  600 RPM)
CPU Temperature:   +29.0°C  (high = +60.0°C, crit = +95.0°C)
MB Temperature:    +28.0°C  (high = +45.0°C, crit = +95.0°C)

...

 
> Luca


Gabriel


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
