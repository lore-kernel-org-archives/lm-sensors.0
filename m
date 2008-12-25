From: "John Brier" <johnbrier@gmail.com>
Date: Thu, 25 Dec 2008 20:50:34 +0000
Subject: Re: [lm-sensors] lm-sensors 2.10.1 with newer 2.6.x.x kernel can't
Message-Id: <f421b28c0812251250g5905f4aei4cd5b510f198215b@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <f421b28c0812221450x5188180u1d21990775c42606@mail.gmail.com>
In-Reply-To: <f421b28c0812221450x5188180u1d21990775c42606@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Thu, Dec 25, 2008 at 2:40 PM, Jean Delvare <khali@linux-fr.org> wrote:
> Probably the best way to make sure what the exact problem is is to
> run "strace sensors" and see where the failure occurs.
>
> It would also be a good idea to check that everything is OK on the
> kernel side. What does the following command return?
>
> grep . /sys/class/hwmon/hwmon*/device/name
I did the grep and then ran the strace on sensors and all the sudden
it was working! Could a grep and strace make it work?! No...

So apparently dpkg *did* install the newer lm-sensors 3 and
libsensors4.. and now it works. LOL. This just shows my inexperience
with Debian. (I know Red Hat based distros the best). Well I guess the
issue is resolved now.. Not sure how this happened when it clearly
looked like it failed dependencies..

[root@tb303 log]# dpkg -p lm-sensors
Package: lm-sensors
Priority: extra
Section: utils
Installed-Size: 560
Maintainer: Aurelien Jarno <aurel32@debian.org>
Architecture: amd64
Source: lm-sensors-3 (1:3.0.2-1)
Version: 1:3.0.2-1+b2
Depends: sed (>= 4.0.5-1), libc6 (>= 2.7-1), libsensors4 (>= 1:3.0.0-1), perl
Suggests: sensord, read-edid, i2c-tools
Filename: pool/main/l/lm-sensors/lm-sensors_2.10.1-3_amd64.deb
Size: 126438
MD5sum: 1577df796b8e4502b6499450cd0fd1b5
Description: utilities to read temperature/voltage/fan sensors
 Lm-sensors is a hardware health monitoring package for Linux. It allows you
 to access information from temperature, voltage, and fan speed sensors. It
 works with most newer systems.
 .
 This package contains programs to help you set up and read data from
 lm-sensors.
Homepage: http://www.lm-sensors.org

[root@tb303 log]# dpkg -p libsensors4
Package: libsensors4
Priority: optional
Section: libs
Installed-Size: 212
Maintainer: Aurelien Jarno <aurel32@debian.org>
Architecture: amd64
Source: lm-sensors-3 (1:3.0.2-1)
Version: 1:3.0.2-1+b2
Depends: makedev (>= 2.3.1-45) | udev, ucf (>= 0.28), libc6 (>= 2.7-1)
Recommends: lm-sensors
Size: 63588
Description: library to read temperature/voltage/fan sensors
 Lm-sensors is a hardware health monitoring package for Linux. It allows you
 to access information from temperature, voltage, and fan speed sensors. It
 works with most newer systems.
 .
 This package contains a shared library for querying lm-sensors.
Homepage: http://www.lm-sensors.org

I had the older libsensors3 installed too but I just removed it.
Sensors was generating some syntax reading errors on the old config
file but i used sensors-conf-convert to fix that. I'm 100% back in
business. Still not sure how that install went forward when I didn't
actively force it.

[root@tb303 log]# sensors
acpitz-virtual-0
Adapter: Virtual device
temp1:       +21.8�C  (crit = +96.8�C)

k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:  +26.0�C

w83627thf-isa-0290
Adapter: ISA adapter
VCore:       +1.07 V  (min =  +0.00 V, max =  +3.84 V)
+12V:       +12.65 V  (min =  +5.59 V, max =  +7.78 V)   ALARM
+3.3V:       +3.12 V  (min =  +2.82 V, max =  +1.31 V)   ALARM
+5V:         +5.01 V  (min =  +0.16 V, max =  +2.19 V)   ALARM
-12V:       -11.95 V  (min = -14.91 V, max =  -4.38 V)
V5SB:        +5.00 V  (min =  +2.61 V, max =  +1.40 V)   ALARM
VBat:        +2.98 V  (min =  +1.39 V, max =  +1.41 V)   ALARM
fan1:          0 RPM  (min = 28125 RPM, div = 2)  ALARM
CPU Fan:    2083 RPM  (min =   -1 RPM, div = 8)  ALARM
fan3:       5625 RPM  (min = 3688 RPM, div = 2)
M/B Temp:    +32.0�C  (high =  +4.0�C, hyst =  +1.0�C)  ALARM  sensor
= thermistor
CPU Temp:    +32.0�C  (high = +80.0�C, hyst = +75.0�C)  sensor = thermistor
temp3:       +13.5�C  (high = +21.0�C, hyst = +17.0�C)  sensor = diode
cpu0_vid:   +0.000 V
beep_enable:enabled

I guess this means I have the wrong version of libc6 installed now.
I'm off to figure out if I broke my system.. lol

John Brier
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
