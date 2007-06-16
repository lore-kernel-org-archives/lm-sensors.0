From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 16 Jun 2007 09:53:50 +0000
Subject: Re: [lm-sensors] ASUS M2NPV-VM problems
Message-Id: <20070616115350.7e5f40d2@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <465D7955.7060307@zerone.se>
In-Reply-To: <465D7955.7060307@zerone.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Raivo,

On Wed, 30 May 2007 15:17:09 +0200, Raivo Kask wrote:
> My configuration looks like this:
> 
> MB:         ASUS M2NPV-VM
> CPU:        AMD 64 X2 Dual Core Processor 4800+
> OS:         Ubuntu 7.04 (Linux 2.6.20-16-generic #2 SMP)
> lm_sensors: 1:2.10.1-2ubuntu2 (feisy)
> 
> I have spent many hours to get it working (scanning all forums and 
> documentation) ... but I am lost.
> Hope someone can sort it our for me.
> Here is what I get from sensors output and it looks strange to me ...
> 
>     - why are there 2 temps for Core0 and Core1

Please read Documentation/hwmon/k8temp:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob_plain;f=Documentation/hwmon/k8temp

>     - what is temp1/2/3

Sensor wiring is board-specific, so ask your motherboard manufacturer.
You can also compare the order and values with what your BIOS displays.
When you find out, add label statements to sensors.conf.

>     - should VID be = 0.000 V

This suggests that the VID inputs of the IT8716F aren't wired to the
VID output pins of the CPU on your motherboard. This can happen,
because these pins can alternatively be used as GPI (general purpose
inputs).

It could also be that your device has the VID value in a different
register. The IT8716F datasheet mentions two possible registers to get
the VID value. The it87 driver uses one (the same as was used for the
IT8712F) but maybe that's not correct for you. If you provide a dump of
your chip, I will take a look:

rmmod it87
isadump 0x295 0x296
isadump -k 0x87,0x01,0x55,0x55 0x2e 0x2f 7

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
