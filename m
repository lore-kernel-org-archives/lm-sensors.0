From: anthony.calabro@lmco.com (Calabro, Anthony)
Date: Wed, 02 Aug 2006 16:38:06 +0000
Subject: [lm-sensors] Flex Scanner Jammed Problem
Message-Id: <ECFA7CB48E408A45987215BF5593E04704F7F7BC@emss09m08.us.lmco.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1064332995.5787.33.camel@nils>
In-Reply-To: <1064332995.5787.33.camel@nils>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

 
Hi Anthony,

>     We recently upgraded from Linux v2.4.9 to 2.6.9 and are trying to 
> go from lm_sensors 2.8.7 to 2.10.0.
>  
>     the old version of sensors works on the new system, but the VBatt 
> readings are incorrect.  Most of the other values seem to be fine 
> though.
>  
>     using sensors-detect, we find (ignoring all the "Failed!" lines) :
>  
>     Probing for PCI bus adapters
>     Use driver 'i2c-i801' for device 00:1f.3 : Intel 82801DB ICH4
>     ......
>     Module 'i2c-i801' already loaded
>     ......
>     i2c-dev is already loaded
>     .......
>     Next adapter: SMBus I801 adapter at 1100
>     ......
>     Client found at address 0x18
>     Probing for 'Maxim MAC1617'... Success!

You certainly mean MA_X_1617. Did you really copy all of this output
manually? ;)

-- Yeah, I cant actually paste any of the ouptput over, huuge pain.

>         (confidence 3, driver 'adm1021')
>     ......
>     Client found at address 0x1a
>     Probing for 'Maxim MAC1617'... Success!
>         (confidence 3, driver 'adm1021')

Dual-Xeon system?

-- Yes

>     ....
>     Client found at address 0x2d
>     Probing for 'Winbond W83627HF'... Success!
>         (confidence 8, driver 'w83781d'), other addresses: 0x48 0x49
>     .....
>     Client found at address 0x2e
>     Probing for 'LM87'... Success!
>         (confidence 7, driver 'LM87')
>     .... 
>     Client found at address 0x30
>     Client found at address 0x48
>     Client found at address 0x49
>     Client found at address 0x61
>     Probing for 'SMBus 2.0 ARP-Capable Device'... Success!
>         confidence 1, driver 'smbus-arp'
>     Client found at address 0x69
>     .....
>     ISA scan:
>     Probing for Winbond W83627HF'... Success!
>         (confidence 8, driver 'w83781d')
>         Alias of the chip on I2C bus 'SMBus I801 adapter at 1100'
>     .....
>  
>     #---cut here----
>     # I2C module options
>     alias char-major-89 i2c-dev
>     options w83781d ignore=0,0x2d

Hm, this is a bug, this ignore line shouldn't be there. I thought I had
fixed this some months ago...

>     #----cut here-----
>  
>     #---cut here----
>     # I2C adapter drivers
>     modprobe i2c-i801
>     modprobe i2c-isa
>     # I2C chip drivers
>     modprobe adm1021
>     modprobe w83781d
>     # Warning:  required module lm87 is not currently installed on
your system.
>     modprobe lm87

This one wasn't ported to Linux 2.6 at the time of 2.6.9. If you need
it, you'll need to backport it, or to move to a more recent kernel.

-- OK

>     # Warning:  required module smbus-arp is not currently installed
on your system.
>     modprobe smbus-arp

You can ignore this one, it's useless anyway.

>     modprobe w83627hf
>     #----cut here-----
>              
>  
> so i load all available libraries

What do you mean? Do you mean you loaded the _kernel_modules_?

-- yes loaded all the modules...

> and run sensors -s it returns flex scanner jammed.

This means that the configuration file contains something libsensors
doesn't understand. This would happen if you have an old libsensors, and
a new sensors.conf file, or if your sensors.conf file got somehow
corrupted.

>  
> modules loaded:
> w83781d
> w83627hf

Loading both drivers is a bad idea. This too, I thought I had fixed...
Load either driver, but not both. I would recommend w83627hf, it's
generally better.

> i2c-isa
> i2c-sensor
> i2c-i801
> i2c-dev
> i2c-core
>  
> i tried getting the new sensors.conf file, and copying over old ones, 
> and even trying an empty file, none of which work...

By "none of which work", I take it that you always obtained the "flex
scanner jammed" error message?

-- correct.

> i also tried removing modules down to just sensors, i801 and w83781d, 
> and removing ones until i got the proc/sysfs error message, then 
> adding modules back up until the flex scanner message returned.

I suspect that you have both the old and the new libsensors installed on
your system, and the new "sensors" picks the old library. Try "sensors
-v" and see what it returns. Or run "ldd $(which sensors)" for a similar
effect.

If I'm right, you should simply get rid of (or rename) the old library,
run ldconfig, and try again.

The only strange thing is that an empty configuration file should have
let "sensors" work, and you report it did not...

-- I ran sensors -v and get:
	sensors version 2.10.0 with libsensors version 2.10.0

 with ldd /usr/bin/sensors I get:
	libsensors.so.3 => /usr/lib/libsensors.so.3 (0x00664000)
	libc.so.6 => /lib/tls/libc.so.6 (0x0075b000)
	libm.so.6 => /lib/tls/libm.so.6 (0x0088d000)
	libsysfs.so.1 => /usr/lib/libsysfs.so.1 (0x00101000)
	/lib/ld-linux.so.2 (0x00742000)

If I do ls /usr/lib/libsens* I get:

libsensors.a
libsensors.so -> libsensors.so.3
libsensors.so.3 -> libsensors.so.3.1.0
libsensors.so.3.0.5
libsensors.so.3.1.0

I definitely think that could be possible, I simply installed the new
version right over top of the old versions on sensors and libsensors.
But everything looks OK.  Thanks so much for your quick response and let
me know if you see anything else that might help.

-Anthony Calabro

