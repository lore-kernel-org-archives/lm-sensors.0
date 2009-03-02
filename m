From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 02 Mar 2009 09:15:03 +0000
Subject: Re: [lm-sensors] Preferred way to obtain thermal data on Linux?
Message-Id: <20090302101503.199067e0@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 22 Feb 2009 15:25:22 +0100, armencho@gmail.com wrote:
> I have a Thinkpad T61. Reading from /proc/acpi/ibm/thermal works fine
> but generates too many interrupts - reading the file once per 5
> seconds generates 20 interrupts waking up the CPU, wasting battery
> life and outputting extra heat very strictly speaking, although many
> would not care. Admittedly reading sensor data through
> /sys/class/hwmon/*/device/*_input files ALSO interrupts the CPU,
> albeit not so often. The /proc interface is also deprecated they say.
> In light of the latter, the multitude of ways to obtain readings, and
> the fact that I am trying to find battery-life optimal way to read the
> sensors continually (most hardware monitors do so), i was wondering:
> 
> What interface is most reliable, generic and least resource intensive
> for obtaining sensor readings in Linux (2.6.27.11)?
> 
> The reason I am asking is that it seems both documentation of
> thinkpad-acpi and libsensors mentions similiar facts, and touches the
> same subjects, almost hinting that the development of these two
> modules shares a lot of knowledge. Both have their own separate ways
> to obtain sensor readings, and both prefer this or that. Also, I have
> no knowledge of internal workings of libsensors, and whether it in
> fact USES thinkpad-acpi or generic acpi driver or something else to do
> its job. I just want to get a piece of advice concerning the best
> method, and also one that is reliable. I know thinkpad-acpi gets data
> per ACPI specs, and that libsensors does chip-specific stuff, but
> still that does not give me confidence using either over the other...

libsensors doesn't access the hardware directly. It gets its values
from /sys/class/hwmon. There you will find all the devices that have
been registered by their drivers as hardware monitoring devices. These
can be of 3 different kinds:

* Native hardware monitoring drivers. These access the hardware
  themselves. In your case, the only such driver that will work on your
  laptop is the coretemp driver, which reads Intel CPU core temperature
  from the CPU registers directly. This will appear as "coretemp-isa-*"
  in the output of "sensors". This is lightweight, shouldn't generate
  any interrupt.

* Generic ACPI access driver. This is implemented by the ACPI "thermal"
  driver. I'm not totally sure whether this was fully implemented in
  2.6.27 or not. If it does, it will appear as "acpitz-virtual-0" in
  the output of "sensors". This makes use of the standard but limited
  ACPI thermal zone interface. The implementation details are courtesy
  of your BIOS vendor.

* Vendor-specific ACPI access driver. In your case, this is the
  thinkpad-acpi driver. I know this driver has not always implemented
  the standard hwmon interface. In 2.6.28 it does, but I can't remember
  if it did in 2.6.27. If it did, it will appear as "thinkpad-isa-0000"
  in the output of "sensors". I don't know much about the
  implementation details of this drivers, so I can't comment on that.
  Please ask Henrique (Cc'd) if you are interested.

These 3 methods may or may not physically read from the same sensors;
it's difficult to say. You'd have to read the ACPI byte code to make
sure.

As long as you use a libsensors-based application, you are reading
values from /sys/class/hwmon which is the right interface. The driver
implementation behind it depends on the system.

In general, if you care about battery time, polling sensors every few
seconds isn't such a good idea anyway. Your ACPI implementation should
take care about kicking in the fan as needed to prevent overheating, so
you don't really have to watch over it yourself.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
