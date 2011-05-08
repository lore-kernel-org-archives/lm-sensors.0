From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 08 May 2011 06:27:43 +0000
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-Id: <20110508082743.69ef9115@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110414034609.476411A9866@localhost.localdomain>
In-Reply-To: <20110414034609.476411A9866@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jeff,

On Sat, 07 May 2011 23:09:40 -0500, Jeff Rickman wrote:
> I just tried out the "i8k.c" code from the link shown above. I still get 
> a crash in Syslog and messages on the Console when loading the new 
> module. The machine still runs so the crash doesn't appear to be "fatal".

Well you had already tried exactly this version, hadn't you?

> 
> My testing steps:
> (1) Completely remove the "i8k" module supplied by Fedora to a "safe" 
> location. It is not being used on my machine per "lsmod".

Did you try loading this original i8k driver? Did it work? What are the
contents of /proc/i8k then?

If the original works and mine fails, please send me the two .ko files
in private and I'll try to figure out how they differ. Even better if
you can get the exact kernel sources used by Fedora to build your
running kernel so that I can also compare the source code (the source
file is drivers/misc/i8k.c in the kernel tree.)

> (2) Run "depmod -a"
> (3) Build the new "i8k" module, but leave it where it is built
> (4) Reboot, just to be certain the legacy "i8k" module isn't being loaded
> (5) Copy the new "i8k" module to /lib/modules/`uname 
> -r`/kernel/drivers/hwmon
> (6) Run "depmod -a" again
> (7) Run "modprobe -v i8k"

Note that you could simply use insmod with full path to the new module,
so you don't have to install it.

> At this point I get Console messages and a crashdump to Syslog. See 
> attached text file for details.
> 
> With the new "i8k" module loaded per "lsmod", a "lock up" occurs when 
> accessing the I2C bus in "sensors-detect" version 5946. A "ctrl-C" is 
> required to get the script running again. Output at the lock up follows:
> 
> Using driver 'i2c-i801' for device 0000:00:1f.3 Intel 82801EB ICH5
> Module i2c-dev loaded successfully.
> 
> I can sit and wait on this output for minutes unless I issue a "ctrl-C" 
> to continue script processing. That is not normal behavior.

With the kernel crash you got, it's nor surprising that anything
related to kernel module loading or unloading will hang.

> Harry, is your Dell machine a single CPU or a dual-CPU system? Also, 
> what Dell BIOS version are you using? I'm curious to know what is 
> different. My system has 2 physical Intel Xeon 3.0 GHz cpu that are also 
> hyperthreaded. My Dell BIOS is A07; "dmidecode" will reflect that in 
> "Handle 0x000" and so will a machine reboot. There is 2G of DRAM 
> onboard. I am running Fedora Core 14 x86_64. "uname -a" output follows:
> 
> Linux xx.xx.xx.xx 2.6.35.12-90.fc14.x86_64 #1 SMP Fri Apr 22 16:01:29 
> UTC 2011 x86_64 x86_64 x86_64 GNU/Linux

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
