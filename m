From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 09 Mar 2008 12:55:31 +0000
Subject: Re: [lm-sensors] lm78 detected as W83627DHG on MSI board
Message-Id: <20080309135531.11efb143@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1204653201.6143.18.camel@montecristo>
In-Reply-To: <1204653201.6143.18.camel@montecristo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Joakim,

On Tue, 04 Mar 2008 18:53:21 +0100, Joakim Larsson wrote:
> I just upgraded from Ubuntu Edgy to Ubuntu Feisty on my MSI 975X
> Platinum PowerUp Edition motherboard based system equipped with a
> Pentium D. I never used lm-sensors since the Smart Fan utility seemed to
> work pretty good before.
> 
> I got two other similar computers set up for my kids running Ubuntu
> Dapper and they still have an active Smart Fan control that works.
> Somewhere between Ubuntu Dapper to latest Edgy the Smart Fan control
> stopped to work and the fan is almost always running noisily at full
> speed. Thats why I upgraded my system to Feisty and are trying to set up
> lm-sensors to work.

For those of us not familiar with Ubuntu distribution names, can you
please tell us what version of the linux kernel and what version of
sensors-detect all these distributions are running? That's all we
really care about.

> Running the sensors-detect in the Ubuntu Edgy distribution I got the
> lm78 driver identified but in the Ubuntu Feisty and using the latest
> sensors-detect from the lm-sensors.org home page it detects a Winbond
> W83627DHG Super IO Sensors:
> 
> Probing for Super-I/O at 0x4e/0x4f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Fintek'...                       Yes
> Found `Winbond W83627DHG Super IO Sensors'                  Success!
>     (address 0x290, driver `w83627ehf')

The MSI 975X is a fairly recent board, so it is certain that it doesn't
have an LM78 chip at all. It must have a W83627DHG. The misdetection
(W83627DHG identifies by sensors-detect as an LM78) has been reported
several times before, but I think that it is fixed in the latest
version of sensors-detect (as the above log seems to confirm.)

> However, I am only able to load the lm78 driver:
> 
> joakim@montecristo:~/Desktop$ sudo modprobe w83627ehf
> FATAL: Error inserting w83627ehf
> (/lib/modules/2.6.20-16-generic/kernel/drivers/hwmon/w83627ehf.ko): No
> such device
> joakim@montecristo:~/Desktop$ sudo modprobe lm78
> joakim@montecristo:~/Desktop$ 

The fact that the lm78 driver loads doesn't mean anything. It is an
hybrid ISA/I2C driver, and I2C chip drivers always load regardless of
the presence of a device at the time of load (because the device could
appear later).

> So I suspect that the latest sensors-detect script is doing something
> wrong.

I don't think so. sensors-detect tells that you have a W83627DHG and I
believe it is true. However,
http://www.lm-sensors.org/wiki/Devices
says that support for this chip was only added in kernel 2.6.21, while
you're apparently running 2.6.20. This explains why the w83627ehf
driver says "no device found".

So the only problem here is that sensors-detect and the kernel don't
agree on the support status of the device. That's something for your
distribution to take care of, although this is admittedly tough. I had
to fix the exact same problem in SLES 10 a few weeks ago:
https://bugzilla.novell.com/show_bug.cgi?id56615

> Does anyone have any experience with this MSI board? Should I turn off
> the Smart Fan feature in BIOS? 

Can't tell you, really depends on your board. Different boards
implement this differently, and let the user specify temperature limits
or not. If it works for you, enable it, if not, disable it and see if
you get lm-sensors and its scripts to do what you want.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
