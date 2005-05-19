From: arvidjaar@mail.ru (Andrey Borzenkov)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: 2.6 - sysfs sensor nameing inconsistency
Message-Id: <200308312025.41472.arvidjaar@mail.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307152214.38825.arvidjaar@mail.ru> <200308192319.01895.arvidjaar@mail.ru> <20030819194533.GA5738@kroah.com>
In-Reply-To: <20030819194533.GA5738@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

On Tuesday 19 August 2003 23:45, Greg KH wrote:
> On Tue, Aug 19, 2003 at 11:19:01PM +0400, Andrey Borzenkov wrote:
[...]
> > There are more issues than just type_name.
[...]
> > 1. I do not know where to get information on adapters (called busses
> > actually in libsensors) and algorithms. I.e. the information
> > corresponding to 2.4:
> >
> > {pts/2}% cat ~/tmp/i2c-bus
> > i2c-0   smbus           SMBus I801 adapter at e800              Non-I2C
> > SMBus adapter
>
> Look in /sys/class/i2c-adapter/
[...]
> Hm, a name file:
> $ cat /sys/class/i2c-adapter/i2c-0/device/name
> SMBus I801 adapter at 8000
>
> Ah, the same info as you showed for 2.4 :)
>

Sure it not the same info it is only part of it. I do not know if libsensors 
just using this for display or needs it internally. Thank you for pointer 
though.

> > 2. I do not know - and sysfs does not provide any information - how to
> > identify chips-of-interest as opposed to generic i2c devices. I.e.
> > w83781d has both clients and subclients (2.4 again):
> >
> > {pts/2}% cat ~/tmp/i2c-0-bus
> > 2d      AS99127F chip                           W83781D sensor driver
> > 48      AS99127F subclient                      W83781D sensor driver
> > 49      AS99127F subclient                      W83781D sensor driver
> >
[...]
>
> That's what you are going to have to set the name file to in the
> i2c_client structure, much like your patch did.  Then look at the
> different name files in each device directory to see what kind of device
> it is (chip, subclient, etc.)
>

OK attached patch sets all names to just chip name for chips themselves and 
"chipname subclient" when subclient ios registered.

> > 3. libsensors asks for hysteresis value. This one does not exist in sysfs
> > (so all temp readings fail). Is it emulated by kernel or read off chip?
>
> The kernel is exporting all of the info that it knows about through
> sysfs.

it just arbitrarily (re-)names them. "min" is not hysteresis; name is badly 
chosen.
[...]
> > 4. I do not have the slightest idea how ISA adapters look like in sysfs
> > and where they are located. Anyone can give me example?
>
> They show up on the legacy bus:
>
> $ tree /sys/class/i2c-adapter/i2c-1/
> /sys/class/i2c-adapter/i2c-1/
>
> |-- device -> ../../../devices/legacy/i2c-1
>

This does not help much. Libsensors expects as adapter identification either 
"i2c-N" or "isa". If I set it to "isa" I do not have any way to determine 
sysfs path except by rescanning /sys/class/i2c-adapter every time. Having 
/sys/class/i2-adapter/isa/... would be better, apparently it is assumed that 
only one such adapter can exist.
[...]
> > So the patch to ibsensors is actually trivial enough. Main issue is
> > contents of sysfs
>
> You might want to take a look at libsysfs, it makes finding all of the
> devices and attributes in the sysfs tree a whole lot easer.
>

No I did not want to make code dependent on libsysfs, besides arsing itself is 
trivial.

Attached is patch against 2.6.0-test3-bk8 that sets all chip names to simply 
chip names :) and patch for libsensors that makes use of it. libsensors still 
needs to be built under 2.4, no attempt is made to allow building under 2.6. 
I built it using make LINUX_HADERS=/home/bor/src/linux-2.4.21/linux 
COMPILE_KERNEL=0. It is possible to get rid of this dependency but I'd like 
to settle sysfs issue first. As can be seen the ugliest part is name 
translation between sysfs attributes and libsensors feature names ... if 
attributes were named consistently the whole would be much more simple.

This works perfectly for reading, writing does not work here but it is not my 
patch. Reading:
{pts/2}% LD_LIBRARY_PATH=./lib ./prog/sensors/sensors
as99127f-i2c-0-2d
Adapter: SMBus I801 adapter at e800
Algorithm: Not available via sysfs
VCore 1:   +1.70 V  (min =  +1.49 V, max =  +1.81 V)
+3.3V:     +3.47 V  (min =  +2.98 V, max =  +3.63 V)
+5V:       +5.00 V  (min =  +4.52 V, max =  +5.48 V)
+12V:     +11.37 V  (min = +10.82 V, max = +13.13 V)
-12V:     -11.57 V  (min = -12.33 V, max = -15.07 V)       ALARM
-5V:       -5.03 V  (min =  -4.50 V, max =  -5.49 V)
CPU:      4787 RPM  (min = 3000 RPM, div = 2)
Front:    2922 RPM  (min = 3000 RPM, div = 2)              ALARM
MB:          +28?C  (limit = +127?C, hysteresis =  +60?C)
CPU:       +36.0?C  (limit = +111?C, hysteresis =  +97?C)
HDD:       +37.0?C  (limit = +120?C, hysteresis = +100?C)
vid:      +1.650 V
alarms:
beep_enable:
          Sound alarm enabled

writing:

{pts/2}% cat /sys/class/i2c-adapter/i2c-0/device/0-002d/in_max2
3632
{pts/2}% sudo zsh -c 'echo 3500 > 
/sys/class/i2c-adapter/i2c-0/device/0-002d/in_max2'
{pts/2}% cat /sys/class/i2c-adapter/i2c-0/device/0-002d/in_max2
400

so writing is broken at least for w83781d driver

-andrey
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 2.6.0-test3-bk8-sensors_type_name-3.patch
Type: text/x-diff
Size: 6288 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030831/a055b45d/2.6.0-test3-bk8-sensors_type_name-3.bin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm_sensors-2.8.0-sysfs.patch
Type: text/x-diff
Size: 7303 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030831/a055b45d/lm_sensors-2.8.0-sysfs.bin
