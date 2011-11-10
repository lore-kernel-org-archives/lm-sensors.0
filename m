From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 10 Nov 2011 13:31:44 +0000
Subject: Re: [lm-sensors] lm_sensors and static kernel
Message-Id: <20111110143144.0b063dd5@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4E970050.10209@akron.net.pl>
In-Reply-To: <4E970050.10209@akron.net.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Sorry for the late reply.

On Thu, 13 Oct 2011 10:14:24 -0500, brylu wrote:
> I don't know if it's just me but, I don't have problem with lm_sensors
> with kernel components compiled as modules everything works fine, but
> when those components are compiled in statically and no module support
> is enabled in the kernel I can't get it to work, sensors-detect detect
> the correct drivers and stuff but sensors returns no modules found.
> 
> Did anyone succeeded in having it work with a static kernel, no modules
> at all all compiled in?

I just tried building my i2c bus and hwmon drivers into the kernel
(still has modules enabled for the rest of the drivers) and it worked
fine for me. In general it should work, however you should keep in mind
that the most frequent use of lm-sensors is with modular drivers so the
built-in case doesn't get much testing, isn't supported by
sensors-detect, and may not be supported by your distribution either.

One problem that can happen is that your distribution initialization
script for the lm-sensors service wants at least one module to load,
otherwise it decides that configuration wasn't done and it will bail
out. This would prevent limits from being set at boot time, but
"sensors" would still print the right thing (which doesn't seem to be
the case for you?)

A second problem would be that you included in your kernel hwmon
drivers which you don't need. Probing for hwmon devices on the SMBus
can be tricky, and we have seen misdetections happen. A midetection
could cause the wrong driver to bind to your device, depending on the
driver probing order. A probe sequence for device A could also confuse
device B, even though we make our best to avoid this.

If you want us to help, you'll have to provide more technical details.
Which kernel version are you running?
Which hardware monitoring devices do you have?
Which drivers did you build into the kernel exactly?
If you can share your .config file, this will help.
Do you see anything under /sys/class/hwmon?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
