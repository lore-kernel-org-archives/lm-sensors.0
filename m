From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 08 May 2011 09:18:06 +0000
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-Id: <20110508111806.1e830f35@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110414034609.476411A9866@localhost.localdomain>
In-Reply-To: <20110414034609.476411A9866@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Harry,

On Sat, 07 May 2011 10:23:57 -0600, Harry G McGavran Jr wrote:
> Here is the output from /usr/bin/sensors with the
> ecm6w201 driver you just gave us AND from the
> new i8k driver you mentioned in an earlier e-mail today.
>
> i8k-virtual-0
> Adapter: Virtual device
> Left Fan:   64710 RPM
> Right Fan:  48420 RPM
> CPU:         -22.0 C                                    

I presume that you had to pass force=1 or ignore_dmi=1 or both to get
the i8k driver to load at all?

The output above revealed a bug in my version of the i8k driver, the
-22 is really an error code (EINVAL) and not a temperature, so it
should be reported as such. Did you ever see a valid temperature
reported? If it's always wrong, I guess the driver shouldn't create the
entry in the first place. I've just fixed that, you can download the
updated driver.

As for the fan speed values, they are off by a factor 30. Load the i8k
driver with option fan_mult=1 (the default is 30) and you'll get correct
fan speeds. You'll notice these are the same speeds as reported by the
emc6w201 driver. This is good because it means both drivers are working
fine, but this is also bad because it means that both drivers poke at
the same piece of hardware. So you should really only use i8k, or
emc6w201, but not both drivers at the same time.

> emc6w201-i2c-3-2e
> Adapter: SMBus I801 adapter at e8a0
> in0:         +1.82 V  (min =  +1.64 V, max =  +1.98 V)
> in1:         +1.26 V  (min =  +0.78 V, max =  +1.70 V)
> in2:         +3.33 V  (min =  +3.08 V, max =  +3.52 V)
> in3:         +5.10 V  (min =  +4.66 V, max =  +5.34 V)
> in4:         +1.51 V  (min =  +1.40 V, max =  +1.60 V)
> in5:         +0.00 V  (min =  +0.78 V, max =  +1.70 V)
> fan1:       1614 RPM  (min =  300 RPM)
> fan2:          0 RPM  (min =  300 RPM)
> fan3:       2153 RPM  (min =  200 RPM)
> fan4:          0 RPM  (min =   82 RPM)
> fan5:          0 RPM  (min =   82 RPM)
> temp1:       +54.0 C  (low  = -127.0 C, high = +88.0 C)  
> temp2:        +0.0 C  (low  = -127.0 C, high = +88.0 C)  
> temp3:        +0.0 C  (low  = -127.0 C, high = +60.0 C)  
> temp4:        +0.0 C  (low  = -127.0 C, high = +55.0 C)  
> temp5:       +48.0 C  (low  = -127.0 C, high = +75.0 C)  
> temp6:       +44.0 C  (low  = -127.0 C, high = +80.0 C)  

This looks pretty good, I'd say. I guess you have a single CPU in the
machine, which explains the missing in5 and temp2. in1 would be the CPU
core voltage, and temp1 the CPU temperature. If the machine is using
DDR2 memory, in0 may be the memory voltage. This would leave maybe in4
for +12V, with scaling factor 8, or for battery voltage with scaling
factor 2. BTW, does the BIOS print any temperature, voltage or fan
speed? This would help us get the labels and scaling factors right.

> Thanks for your work on this!!!

You're welcome.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
