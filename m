From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 16 Apr 2014 08:51:22 +0000
Subject: Re: [lm-sensors] Asus M5A88-M motherboard, "no pwm-capable sensor modules"
Message-Id: <20140416105122.2e635667@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <534B5355.5090102@gmail.com>
In-Reply-To: <534B5355.5090102@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Bernd,

On Wed, 16 Apr 2014 12:44:54 +0900, Bernd Bausch wrote:
> Thanks Jean. Is it OK to continue this conversation out in the open, i.e. on
> the mailing list?

Yes it is! That way everything is archived for the benefit of other
users.

> Executive summary: you are right about my kernel being too old, and in
> addition I have a driver conflict
> (http://hansdegoede.livejournal.com/7932.html) that comes up with a 3.x
> kernel. 
> Since I want to stay with Centos and 2.6.32, is there anything I can do?
> 
> Details:
> 
> My kernel is 2.6.32, not quite the 2.6.37 you mention, but I do have k10temp
> and it67 drivers:
> 
> /lib/modules/2.6.32-431.el6.x86_64/kernel/drivers/hwmon/it87.ko
> /lib/modules/2.6.32-431.el6.x86_64/kernel/drivers/hwmon/k10temp.ko

The question isn't if the drivers are present or not, but if they
support your hardware or not. Both drivers are relatively old, but we
add support for new hardware over time, so old versions of the drivers
do not support the most recent hardware.

> I downloaded the elrepo version of the two modules. Hard to say how they
> differ from my installed version; find modinfo output for it87 further
> below.
> 
> Also, the sensors output (also below) looks sensible, with the exception of
> the 16.8 degrees value, which is less than the ambient temperature. It seems
> that monitoring works and it's just fan control that doesn't. 

See at the bottom of:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/hwmon/k10temp
for an explanation of the 16.8 degrees.

Unfortunately fan control is not available on your system beyond the
options offered by the BIOS at boot time, see below.

> Next, I tested this with a LiveCD that uses a 3.9 kernel (Debian-based
> Kanotix, in case you wonder). By default, I am not able to modprobe it87
> because the BIOS ACPI code and it87 access the same hardware device (see
> http://hansdegoede.livejournal.com/7932.html). After booting with
> acpi_enforce_resources=lax, I can insert the it87 module, and now pwmconfig
> does detect a controllable fan. So, I could make it to work if I moved to a
> newer kernel, but this is not an option for me, as I need to stay with
> Centos/Redhat. Is there anything I can do, perhaps trying to port the newest
> it87 driver to my kernel (would be a steep learning curve)?

Using the it87 driver on your machine wouldn't be a good idea anyway.
Your BIOS implements a virtual device named ATK0110, which abstracts
the access to the hardware monitoring chip. We have a driver for this,
asus_atk0110, which can only do monitoring and not fan control, mostly
due to a lack of documentation. Forcing native access to the chip (i.e.
acpi_enforce_resources=lax + it87 driver) can cause random problems so
it is not recommended to do that.

So your only safe option at this time is to set the cooling profile of
your choice in the BIOS and let the chip regulate the fan speeds after
that. If you are unhappy with the settings offered by the BIOS, the
only thing you can do is complain to the board vendor.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
