From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 23 Oct 2010 16:05:01 +0000
Subject: Re: [lm-sensors] looking for help with W83795ADG
Message-Id: <20101023180501.74c0b945@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101022135607.6996731s0m2gcr48@webmail.mnet-online.de>
In-Reply-To: <20101022135607.6996731s0m2gcr48@webmail.mnet-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Karsten,

On Fri, 22 Oct 2010 16:04:10 +0200, karsten@maxi-dsl.de wrote:
> hi Jean,
> > The w83795 driver uses the same detection mechanism used in
> > sensors-detect. So if sensors-detect doesn't see your chip, I am not
> > surprised that the driver didn't either.
> 
> > The full output of sensors-detect is needed to diagnose your problem
> > further. It could be that your SMBus controller isn't supported, or
> > maybe you are supposed to access the chip through IPMI.
> 
> IPMI is probably the key..
> 
>  From the sensors-detect output:
> "Warning: the required module ipmisensors is not currently installed
> on your system. If it is built into the kernel then it's OK.
> Otherwise, check http://www.lm-sensors.org/wiki/Devices for
> driver availability" (full ouput attached)
> 
> I did see the output before, but didn't really understand the  
> implications (IPMI seems to be an alternative way of accessing the  
> monitoring chips?)

Yes. The strength of IPMI access is that it can be used remotely too,
for example from a BMC plugged into your system.

> The suggested ipmisensors driver however does not seem to be available, right?
> (http://lm-sensors.org/wiki/Devices says "(2004-12-12)  Port to Linux  
> 2.6 in progress by Yani Ioannou")

That project is essentially dead. At the time being, the best way to
retrieve IPMI-based sensor values is using "ipmitool sensor". The
drawback is that this isn't integrated with libsensors, so the usually
monitoring applications won't work.

If you have a BMC or are otherwise already using IPMI on your machine,
just use ipmitool and you're done.

If not, then it might be worth trying ipmitool once, and then try
sensors-detect again. There is a small chance that, once ipmitool
managed to access the monitoring device, sensors-detect will see it. My
own mainboard which has a W83795ADG chip has a multiplexed SMBus, and I
can only see the W83795ADG in sensors-detect when the multiplexer is
set properly. Otherwise I would see the memory modules, which _do_
appear in your sensors-detect output. So maybe your board has a
multiplexed SMBus too.

If the trick doesn't work, you may want to try the new jc42 driver
which can monitor the temperature of some DDR3 memory modules. I
suspect your memory modules have such sensors. A more recent version of
sensors-detect would confirm that:
  http://dl.lm-sensors.org/lm-sensors/files/sensors-detect

I also see that sensors-detect suggested to use the k10temp driver,
which your kernel doesn't have. You can try the standalone flavor of
the drivers which I maintain at:
  http://khali.linux-fr.org/devel/misc/k10temp/
The accuracy of the CPU internal sensors is limited, but that's still
better than nothing.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
