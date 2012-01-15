From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 15 Jan 2012 20:29:18 +0000
Subject: Re: [lm-sensors] kernel 2.6.32 i2c-isa w83781d via686a
Message-Id: <20120115212918.056845a6@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326658239.11934.YahooMailNeo@web29606.mail.ird.yahoo.com>
In-Reply-To: <1326658239.11934.YahooMailNeo@web29606.mail.ird.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Emilio,

On Sun, 15 Jan 2012 20:10:39 +0000 (GMT), emilio wrote:
> I have an old mb austek K7V with via686a and w83781d devices.
> 
> Until some day ago, I was using a debian system with kernel 2.6.18.1 and lm-sensors 2.10.1.
> 
> sensors-detect correctly detect the devices and suggest to use the respective modules.
> 
> lsmod tell me that this module are loaded:
> 
> 
> via686a;
> w83781d;
> i2c_isa;
> i2c_viapro;
> i2c_core.
> 
> 
> with this configuration all working fine. In sensors.conf I have fine tunning the data for as99127 and the accuracy of the voltages and of the cpu fan is good (matched with the bios reading).
> 
> Now, on the same hardware I have installed an Ubuntu 10.04-03 LTS with kernel 2.6.32-37-generic.
> 
> I have installed the lm sensors 3.3.1 directly from ubuntu repository.
> 
> sensors-detect don't recognize the w83781d but only the via686a.
> 
> All reading are incorrect.

Boot with additional parameter acpi_enforce_resources=no [1], blacklist
module via686a [2] and run sensors-detect again. You should then be
back on the same state you were before your upgrade.

[1] More details at:
http://www.lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworkinginkernel2.6.31
Don't be frightened, on such an old board it is definitely safe.

[2] This is done by adding the following line to any file
under /etc/modprobe.d/ :
blacklist via686a

> If I try to load with modprobe the w83781d this is loaded but I cannot read the sensors correctly (I read only via686a).
> 
> Installing from source code (recompiling for my kernel) the 2.10.8 lm sensor version (I have not the source code for the 2.10.1) the result is the same of the 3.3.1.

Note: if you were using lm-sensors 2.10.x before and 3.x now, you'll
have to run your old custom configuration script through
sensors-conf-convert.

> I think that the problem is the missing in kernel source of the module i2c-isa.

No, it is not. i2c-isa is no longer needed.

> I read in internet that now the i2c support is included in the kernel, but if this is true, why lm-sensor not working with kernel 2.6.32-37 ?

Yes, i2c support is included in the kernel. It already was in kernel
2.6.18, this has nothing to do with your problem.

> ok, the mb is old, the via686a is not good supported, but: with kernel 2.6.18.1 and the i2c-isa all working fine for many years, why, now, with the new kernel I cannot have lm-sensors working again ?

See above. And I am fairly certain that i2c-isa was never actually
needed on your board to start with, as it was a dependency of via686a
which is NOT the right module for your system to start with (w83781d
is.)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
