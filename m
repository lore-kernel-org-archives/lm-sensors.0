From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 10 Nov 2009 12:05:41 +0000
Subject: Re: [lm-sensors] Dell 4600C, cannot read any sensors
Message-Id: <20091110130541.43d9e747@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <249591.49138.qm@web110305.mail.gq1.yahoo.com>
In-Reply-To: <249591.49138.qm@web110305.mail.gq1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Bob,

On Thu, 5 Nov 2009 14:38:07 -0800 (PST), Bob Jurkowski wrote:
> I have googled for months... I still have no way of reading any sensors.
> I am running Slackware 12.2 running a 2.6.31.1 kernel-huge. the bios does not have a sensor page.
> 
> Tried lm_sensors, it detects "SMSC LPC47M10x/112/13x Super IO Fan Sensors" with confidence 9
> 
> 
> modprobe smsc47m1
> 
> 
> smsc47m1: Found SMSC LPC47M10x/LPC47M112/LPC47M13x
> ACPI: Device needs an ACPI driver
> i have tried the kernel parameter
> 
> 
> acpi_enforce_resources=lax
> this removes the "cannot insert modules / device busy" error message
> 
> and then dmesg gives:
> 
> smsc47m1: Found SMSC LPC47M10x/LPC47M112/LPC47M13x
> ACPI: I/O resource smsc47m1 [0xc00-0xc7f] conflicts with ACPI region LEDX [0xc5d-0xc5e]
> ACPI: Device needs an ACPI driver
> smsc47m1 smsc47m1.3072: Device not configured, will not use

This basically means that the fan pins of your Super-I/O chip aren't
used. It's up to the manufacturer to decide how to wire things, and
apparently they have decided to not connect the fans to the speed
monitoring and control pins.

> I have never heard or have any idea of "LEDX", i've searched, and nothing comes up related to what im looking for.

"LEDX" is how the BIOS vendor decided to name this I/O range
internally. It isn't relevant to your problem.

> 
> The thing that tells me there has to be something is, when I didn't properly have the heat sink seated correctly, I got thermal messages...
> 
> Something along the lines of "thermal temperature/normal"
> and this would repeat: 2,000 times, 2,300 times (literally) and fill my "messages" log (300MB) worth of this stuff, ONLY when the CPU hits 100% say i was recompiling my kernel, it would just fill the log. even though it was saying "normal" which was false, it had to be getting the data from somewhere!

Most modern processors have an internal safety which triggers
throttling when the temperature is too high. It doesn't mean you can
actually get the temperature value of the processor. It is all handled
at a very low level, and isn't related to lm-sensors nor hardware
monitoring drivers.

Without the exact log messages, I can't guarantee that's what happened
to you, but it certainly looks like it.

> all I'm after is CPU temp. the above tells me there has to be something telling it that there is an event or something happening.
> 
> /proc/acpi
> $> ls
> . dsdt fadt power_resource thermal_zone
> .. embedded_controller fan processor video
> button event info sleep wakeup
> 
> all the fan/thermal_zone/power_resource dirs, are empty
> processor/CPU0 have "info limit power throttling" but have nothing indicating any type of sensor.

OK, so nothing from ACPI either. It's hard to conclude without the
complete output of sensors-detect, but the lack of hardware monitoring
information in the BIOS setup screen is a good hint that your machine
simply has no hardware monitoring capabilities. It is unfortunately
still rather frequent for "vendor" desktop machines.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
