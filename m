From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Mon, 27 Feb 2006 02:23:21 +0000
Subject: [lm-sensors] Can't access procfs/sysfs file - 2.6.14.6
Message-Id: <20060227022321.GA4278@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <BAY115-F3564B5DE03D3DA0134F7AFCFF10@phx.gbl>
In-Reply-To: <BAY115-F3564B5DE03D3DA0134F7AFCFF10@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Warren:

* Warren Wilder <wipwap19 at hotmail.com> [2006-02-26 11:12:57 +0000]:
> Allright, here is some more info:
> 
> first, the link between  libsensors and sysfs is there:
> 
> root:~# ldd /usr/local/bin/sensors
>        libsensors.so.3 => /usr/local/lib/libsensors.so.3 (0x010f1000)
>        libc.so.6 => /lib/libc.so.6 (0x0111c000)
>        libm.so.6 => /lib/libm.so.6 (0x01249000)
>        libsysfs.so.2 => /usr/lib/libsysfs.so.2 (0x0126e000)
>        /lib/ld-linux.so.2 (0x010d9000)

Good.

> next, the entire sensors-detect output (which mentions module eeprom)

[cut sensors-detect output sans ISA or superio detection]

> The modules that are loaded on my system (before the script is run).

[cut - looks ok]

> The modules compiled 'into' my kernel.

[cut - list of I2C stuff only]

> Sysfs is compiled in, but also being used:
> 
> /dev/hda2 on / type ext3 (rw)
> proc on /proc type proc (rw,noexec,nosuid,nodev)
> sysfs on /sys type sysfs (rw,noexec,nosuid)
> devpts on /dev/pts type devpts (rw,nosuid,gid=4,modeb0)
> shm on /dev/shm type tmpfs (rw,nosuid,nodev)
> usbfs on /proc/bus/usb type usbfs (rw)

Good.

> I think the VT1211 chip is not being detected, since the vt1211 is not 
> being suggested. At least, that is the module I need according to this line 
> on your website:
> 
> Manufacturer  	Chip  	    Detected  	Driver       Initial Support   
> Status, Comments
>                                                                   
> (lm-sensors)
> VIA  	            VT1211  yes  	    vt1211  	2.6.4  	 	    
> (2005-05-18) Integrated sensors.
>                                                                             
>               Port to Linux 2.6 in progress by Lars Ekman.

Hrm.  Do you know for a fact that the vt1211 chip is present inside your
computer?  I.e. have you inspected your mainboard physically and located
it?  The line you quote from our website only says we support it.  It
doesn't claim that you have one.  Or maybe I am misreading you?

> I know I am not scanning the ISA bus and superio? channel in the above 
> sensors-detect output, but  my kernel does not allow that. I have turned 
> the Grsec options off, but there wasn't anything else found. If needed, I 
> can turn the Grsec options off again to really check. (Will take a while)
> If you need some more info to help me diagnose this, let me now.

vt1211 is a superio chip.  sensors-detect cannot find it unless you allow
the superio scan.

So to recap, the good:

1) You built lm-sensors userspace OK.
2) You have sysfs mounted OK.

... and the bad:

1) I'm not sure you have a vt1211 in the first place.
2) sensors-detect for sure won't find it unless you allow superio scan.

And to top that off, even if you *do* have a vt1211, the driver has not yet
been ported to kernel 2.6.x anyway.

But if you did run sensors-detect with grsec off and the superio scan didn't
find anything, then I doubt you have a vt1211.  So let's back up here...

* * * * *

Are there temp/volt readings in any of your BIOS screens?  If not, probably
you just plain don't have any supported hardware on your board.  But if so...

Who makes your mainboard & what is the model?  Do the specs mention a specific
hardware sensor chip?

If possible, please physically examine your mainboard to see if you can find
any of the chips from our supported or new drivers lists.  On average, they
are the size of a thumb nail.  It's almost never necessary, but it is the
last resort.  Thanks.

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


