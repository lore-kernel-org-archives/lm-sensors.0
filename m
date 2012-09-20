From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 20 Sep 2012 01:39:19 +0000
Subject: Re: [lm-sensors] CPU fan rapidly turns on and off
Message-Id: <20120920013919.GA22634@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CALHKqSXP=Qkeor_orw+Cu5B9jaBb9O6EHicZUp_OP2nWcJGLpg@mail.gmail.com>
In-Reply-To: <CALHKqSXP=Qkeor_orw+Cu5B9jaBb9O6EHicZUp_OP2nWcJGLpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jack Kelly <jack-list@xlk.org.uk>
Cc: lm-sensors@lm-sensors.org, linux-acpi@vger.kernel.org

On Thu, Sep 20, 2012 at 01:19:13AM +0100, Jack Kelly wrote:
> Dear lm-sensors list,
> 
> Please may I ask for a bit of technical support (the problem I'm
> experiencing may be the result of a bug but I'm not sure... it might
> also be me being an idiot!)
> 
> I am using lm-sensors and coretemp on an HP ProBook 6450b laptop with
> an Intel i5 quad-core CPU.  I'm running Ubuntu 12.04 with all the
> latest updates:
> 
> $ uname -a
> Linux probook 3.2.0-31-generic #50-Ubuntu SMP Fri Sep 7 16:16:45 UTC
> 2012 x86_64 x86_64 x86_64 GNU/Linux
> 
> The CPU fan is off when the system is idling.  When I stress the
> system the fan starts running when the CPU gets to 105 degrees C
> (which seems rather high but never mind...).  The problem is that the
> system appears to be  failing to provide a constant current to the
> fan.  Instead the fan is being turned on and off very rapidly which
> results in a "clicking" noise which sounds a little like a hard disk
> seeking.  I have manually measured the voltage supplied to the fan and
> it does indeed turn on and off rapidly.
> 
> I wonder if this problem could be fixed by enabling a hysteresis
> setting in coretemp?
> 
> This "clicking fan" problem does not occur if I run Windows7 or if I
> boot Linux using apci=off.
> 
> Alternatively, is there a way for me to manually set the max and crit
> temperatures for my CPU?  I've tried
> 
> sudo bash -c "echo 90000 > /sys/class/hwmon/hwmon1/device/temp2_max"
> 
> But I get a "permission denied" error.
> 
> I've also tried adding "set temp2_max 90000" to sensors3.conf but I
> get a "Failed to set value" error.
> 
Hi Jack,

the coretemp module only reports CPU temperatures. It does not let you set
limits, and it does not perform any fan control. So the errors are not really
surprising.

What you _might_ have is ACPI based fan control. ACPI fan control in Linux is
implemented as thermal device, and currently only supports on/off status. The
latest revision of ACPI supports more fine grain fan control, but support for it
has not yet been implemented in the Linux kernel (nor do I know if it is
supported in your system).

You can see if ACPI fan control is enabled/used by checking your system log
(dmesg) for occurrences of "ACPI". Example of what to look for:

ACPI: PNP0C0B:00 is registered as cooling_device1
ACPI: Fan [FAN0] (on)
ACPI: Transitioning device [FAN1] to D0
ACPI: PNP0C0B:01 is registered as cooling_device2
ACPI: Fan [FAN1] (off)

If you see something like that, there are two possibilities: Something in the
DSDT (Differentiated System Description Table) is wrong, or ACPI on your system
implements fine grained fan control and Linux does not support it. Or something
else - I am not really an ACPI expert.

Anyway, this might be an ACPI problem, so I am adding the ACPI mailing list
(linux-acpi@vger.kernel.org). Maybe someone has an idea what is going on.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
