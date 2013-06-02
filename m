From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 02 Jun 2013 11:20:27 +0000
Subject: Re: [lm-sensors] Module load order dependency
Message-Id: <20130602132027.3dffc1b1@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <51A9CC8D.2010105@sat.dundee.ac.uk>
In-Reply-To: <51A9CC8D.2010105@sat.dundee.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Paul,

Please disregard my previous reply, it was accidentally sent before I
was finished writing it :(

On Sat, 01 Jun 2013 11:27:25 +0100, Paul Crawford wrote:
> I encountered a problem using the lm-sensors package along with the 
> fancontrol package where the various drivers for the temperature sensing 
> chips would be loaded in differing orders at boot time.

Yes, this can happen, depending on the hardware.

> This leads to the abstracted paths of, for example, 
> '/sys/class/hwmon/hwmon0' and '/sys/class/hwmon/hwmon1' changing places 
> and the fancontrol package doing nothing as it believes the hardware is 
> different or misconfigured.

The latest version of fancontrol supports absolute device paths, which
should help a bit in this respect. It isn't perfect yet, because:
1* pwmconfig still writes relative paths so you have to
   edit /etc/fancontrol manually. I have just created a ticket for that:
   http://www.lm-sensors.org/ticket/2388
2* Absolute paths aren't necessarily persistent. PCI and platform
   device paths are persistent but I2C bus numbers are not. So using
   absolute paths doesn't guarantee that fancontrol will find the
   devices it looks for after every reboot.

> This is also a risk for the Linux watchdog daemon that could be using 
> such a path for temperature sensing (I added the capability recently to 
> use lm-sensors outputs), leading to a far more irksome problem than 
> simply full-speed fans!

"lm-sensors outputs"? If you need to access hardware monitoring
information, please use libsensors. The problems you mentioned with
fancontrol precisely come from the fact that it does not use
libsensors. libsensors gives hardware monitoring devices stable names.
(See http://www.lm-sensors.org/ticket/2238 for one remaining issue
though.)

> Is this enumeration something that lm-sensors performs, or is it a 
> kernel issue? As this appears to be quite important for actually using 
> the capabilities, what can be done to fix it?

"lm-sensors" is a package name, it does not perform anything. The
relevant components are, in order: the hardware monitoring driver, the
kernel core, the sysfs interface, libsensors and ultimately "sensors"
or whatever application you're using. The kernel makes no guarantee
about device name stability. Some subsystems (most notably the sound
subsystem) have tried it but it simply doesn't work. For most subsystems
this is now handles by udev, unfortunately hwmon devices have no node
in /dev so udev is of no use in our case.

The persistent device naming is thus achieved by libsensors.
Applications which care about stable device names (or getting
everything right for that matter) should use libsensors.

> I added my crude solution (to make sure all of the modules are in 
> /etc/modules, and not some auto-loaded and others explicitly added) to 
> the bug report here:
> 
> https://bugs.launchpad.net/ubuntu/+source/lm-sensors-3/+bug/576602

The code there is horrible ;)

/etc/modules is a Debian/Ubuntu specific approach. Your workaround
should work fine as far as I can see, although this is obviously a step
backwards (driver autoloading is a great feature.) Unfortunately we
have not yet reached the point where all needed drivers can be
auto-loaded. This would require at least 3 things: LPC/Super-IO device
identification and instantiation at kernel level, SMBus ARP support and
cooperation from the BIOS/firmware to enumerate remaining devices, in
particular I2C-based ones.

Note though that I do not have the problem you describe with openSUSE.
Maybe I am just very lucky, or maybe Debian/Ubuntu starts more services
in parallel. If they would wait for driver autoloading to be finished
before starting the lm_sensors and then fancontrol services, that would
probably solve your problem.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
