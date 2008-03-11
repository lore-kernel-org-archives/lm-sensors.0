From: "David Hubbard" <david.c.hubbard@gmail.com>
Date: Tue, 11 Mar 2008 21:51:49 +0000
Subject: Re: [lm-sensors] W83627DHG driver on MSI 975x board
Message-Id: <4dfa50520803111451o3c6c5a3dy1b7b2abb350bfb0a@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1205271362.6571.9.camel@montecristo>
In-Reply-To: <1205271362.6571.9.camel@montecristo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Joakim,

>  ok, so I downloaded the Ubuntu Feisty 2.6.20 kernel source and compiled
>  the modules and then just copied the driver from the 2.6.24 kernel
>  source and recompiled it. Then I did make modules_install. The modules
>  now loads successfully:
>
>  $ sudo modprobe hwmon-vid
>  $ sudo modprobe w83627ehf
>  $ dmesg
>  <snip>
>  [  127.521735] w83627ehf: Found W83627DHG chip at 0x290
>  <snip>
>
>  However when I run sensors I got the following output:
>
>  $ sudo sensors
>  w83627dhg-isa-0290
>  Adapter: ISA adapter
>
>  And no other output. I'll try to debug but any hint's appreciated! :-)

Verify that you have a directory in /sys/class/hwmon/ (probably it is
/sys/class/hwmon/hwmon0/). You can actually view the plain-text data
read from your chip in /sys/class/hwmon/hwmon0/device/.

Assuming that's all working, sensors just needs you to edit
/etc/sensors.conf and set up the motherboard-specific parameters, such
as what fans are really present, what the voltage measurements mean,
etc. Your BIOS setup should be useful in getting those numbers right.

Good luck!
David

>
>  BR
>
>  Joakim
>
>  > I downloaded the latest sensors-detect script from lm-sensors.org
>  >
>  > <snip>
>  >
>  > > > So I suspect that the latest sensors-detect script is doing something
>  > > > wrong.
>  > >
>  > > I don't think so. sensors-detect tells that you have a W83627DHG and I
>  > > believe it is true. However,
>  > > http://www.lm-sensors.org/wiki/Devices
>  > > says that support for this chip was only added in kernel 2.6.21, while
>  > > you're apparently running 2.6.20. This explains why the w83627ehf
>  > > driver says "no device found".
>  >
>  > Got it, I'll try to backport the 2.6.20 code as a module and see if it
>  > loads.
>  >
>  > // joakim

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
