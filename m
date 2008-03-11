From: Joakim Larsson <joakim@bildrulle.nu>
Date: Tue, 11 Mar 2008 21:36:02 +0000
Subject: [lm-sensors] W83627DHG driver on MSI 975x board
Message-Id: <1205271362.6571.9.camel@montecristo>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 2008-03-09 at 20:08 +0100, Joakim Larsson wrote:

ok, so I downloaded the Ubuntu Feisty 2.6.20 kernel source and compiled
the modules and then just copied the driver from the 2.6.24 kernel
source and recompiled it. Then I did make modules_install. The modules
now loads successfully:

$ sudo modprobe hwmon-vid 
$ sudo modprobe w83627ehf 
$ dmesg
<snip>
[  127.521735] w83627ehf: Found W83627DHG chip at 0x290
<snip>

However when I run sensors I got the following output: 

$ sudo sensors
w83627dhg-isa-0290
Adapter: ISA adapter

And no other output. I'll try to debug but any hint's appreciated! :-)

BR

Joakim

> I downloaded the latest sensors-detect script from lm-sensors.org
> 
> <snip>
> 
> > > So I suspect that the latest sensors-detect script is doing something
> > > wrong.
> > 
> > I don't think so. sensors-detect tells that you have a W83627DHG and I
> > believe it is true. However,
> > http://www.lm-sensors.org/wiki/Devices
> > says that support for this chip was only added in kernel 2.6.21, while
> > you're apparently running 2.6.20. This explains why the w83627ehf
> > driver says "no device found".
> 
> Got it, I'll try to backport the 2.6.20 code as a module and see if it
> loads.
> 
> // joakim
> 
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
