From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 10 Oct 2007 18:09:17 +0000
Subject: Re: [lm-sensors] Problems reloading sis5595 since kernel upgrade to
Message-Id: <20071010200917.7c2a919a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <470CFD4B.3050809@gmail.com>
In-Reply-To: <470CFD4B.3050809@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ivo,

On Wed, 10 Oct 2007 18:26:51 +0200, Pinkel wrote:
> Yesterday, I upgraded my kernel on my sis5595 "PC" to 2.6.22.9, while 
> trying to converting the sis5595 device driver to support individual 
> alarm files.
> The first thing I noticed, is that when I loaded my patched version, 
> nothing happened. I couldn't find any file in sysfs and sensors said 'No 
> sensors were found.'.
> First, I thought I messed things up, which wouldn't be very surprising.
> However, after rebooting, I noticed that it also seem to happen in the 
> original sis5595:
> 
> 1. I boot my pc. I run sensors (vanilla config) and....
> --
> [ivo@localhost ~]$ sensors
> sis5595-isa-0290
> Adapter: ISA adapter
> VCore 1:   +2.96 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
> VCore 2:   +3.41 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
> +3.3V:     +2.75 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
> +5V:       +3.44 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
> +12V:     +14.71 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
> fan1:        0 RPM  (min =   -1 RPM, div = 2)          ALARM
> fan2:        0 RPM  (min =   -1 RPM, div = 2)          ALARM
> alarms:   Board temperature input (usually LM75 chips) ALARM
> 
> 2. I reload the module
> --
> [ivo@localhost ~]$ sudo /sbin/rmmod sis5595
> [ivo@localhost ~]$ sudo /sbin/modprobe sis5595
> 
> 3. Then I run sensors
> [ivo@localhost ~]$ sensors
> No sensors found!
> Make sure you loaded all the kernel drivers you need.
> Try sensors-detect to find out which these are.
> 
> [ivo@localhost ~]$ sudo /sbin/lsmod | grep sis5595
> sis5595                17993  0
> i2c_sis5595            11077  0
> hwmon                   7365  1 sis5595
> i2c_isa                 8257  1 sis5595
> i2c_core               27841  4 sis5595,i2c_sis630,i2c_sis5595,i2c_isa
> 
> [root@localhost sis]# uname -r
> 2.6.22.9-61.fc6
> 
> Any idea what happens here? I'm clueless. Can't find anything in any log 
> file either.

Try unloading i2c-sis5595 before you reload sis5595. The i2c-sis5595
driver refuses to share the PCI device with other drivers until 2.6.23.
See:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;hs75cd822d600b4e8b83cbc025422e4267bf5fac

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
