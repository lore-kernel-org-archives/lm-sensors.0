From: Clemens Ladisch <clemens@ladisch.de>
Date: Mon, 17 May 2010 07:06:26 +0000
Subject: Re: [lm-sensors] No temperature output with k10temp for AMD II X3
Message-Id: <4BF0EAF2.80104@ladisch.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <4BE718BF.4080101@googlemail.com>
In-Reply-To: <4BE718BF.4080101@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Sun, 09 May 2010 22:19:11 +0200, Florian Schwade wrote:
> > [florian@errorkiste ~]$ sensors
> > k10temp-pci-00c3
> > Adapter: PCI adapter
> > temp1:       +21.0°C  (high = +70.0°C)
> > 
> > 21°C is impossible to be the correct temperature. The BIOS reports my
> > CPU running at something like 36°.

The temperature values returned by k10temp are relative; AMD says:
| Tctl is the processor temperature control value, used by the platform to
| control cooling systems. Tctl is a non-physical temperature on an
| arbitrary scale measured in degrees. It does _not_ represent an actual
| physical temperature like die or case temperature. Instead, it specifies
| the processor temperature relative to the point at which the system must
| supply the maximum cooling for the processor's specified maximum case
| temperature and maximum thermal power dissipation.

Apparently, on your CPU, the reported values are about 15 °C lower.

lm-sensors currently does not indicate that values are not absolute.

> Maybe the BIOS applies an arbitrary offset,

AMD doesn't publish any method to derive this offset.

> or they get the temperature from an external sensor connected to a
> hardware monitoring device.

This is usually the case, especially since most mainboards also have
a bunch of other temperature sensors handled by the same hwmon device.


Regards,
Clemens

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
