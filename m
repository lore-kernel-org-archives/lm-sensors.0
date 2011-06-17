From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 17 Jun 2011 19:09:48 +0000
Subject: Re: [lm-sensors] Gigabyte GA-D525 core temps N/A?
Message-Id: <1308337788.8271.450.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <12337942.277431308248481343.JavaMail.defaultUser@defaultHost>
In-Reply-To: <12337942.277431308248481343.JavaMail.defaultUser@defaultHost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Fri, 2011-06-17 at 13:30 -0400, everythingsfree@lineone.net wrote:
> Guenter & Jean, thanks for the continued help.
> 
> I got slightly bogged 
> down yesterday attempting to upgrade my install - I tried 'apt-get 
> update' which downloaded a few things but didn't fix the problem so I 
> then tried 'apt-get upgrade' (I'm not sure on the difference between 
> the two...) which downloaded even more and then got into trouble, 
> ending with a segmentation fault!  I rebooted and continued but got 
> more issues and had to stop as it was getting late.
> 
> I've since resumed 
> and managed to get where I am now with what I hope is a fully upgraded 
> install but I still get the same compile errors.
> 
> So, I've grabbed 
> Jean's file and followed Guenter's instructions to build and install 
> those, all went well.  On running 'sensors' I still get 'N/A' for the 
> core temps but at least I only get two:
> 
> coretemp-isa-0000
> Adapter: ISA 
> adapter
> Core 0:           N/A  (high = +80.0Â°C, crit = +100.0Â°C)
> Core 
> 1:           N/A  (high = +80.0Â°C, crit = +100.0Â°C)
> 
> it8720-isa-0290
> 
> Adapter: ISA adapter
> in0:          +1.10 V  (min =  +0.00 V, max =  +4.
> 08 V)
> in1:          +1.52 V  (min =  +0.00 V, max =  +4.08 V)
> 
> in2:          +3.31 V  (min =  +0.00 V, max =  +4.08 V)
> in3:          
> +2.98 V  (min =  +0.00 V, max =  +4.08 V)
> in4:          +3.07 V  (min 
> =  +0.00 V, max =  +4.08 V)
> in5:          +4.08 V  (min =  +0.00 V, max 
> =  +4.08 V)  ALARM
> in6:          +4.08 V  (min =  +0.00 V, max =  +4.08 
> V)  ALARM
> in7:          +2.18 V  (min =  +0.00 V, max =  +4.08 V)
> 
> Vbat:         +3.06 V
> fan1:        3994 RPM  (min =    0 RPM)
> 
> fan2:           0 RPM  (min =    0 RPM)
> temp1:        -55.0Â°C  (low  = 
> +127.0Â°C, high = +127.0Â°C)  sensor = thermistor
> temp2:        +63.0Â°
> C  (low  = +127.0Â°C, high = +127.0Â°C)  sensor = thermistor
> 
> temp3:        +29.0Â°C  (low  = +127.0Â°C, high = +127.0Â°C)  sensor = 
> thermal diode
> cpu0_vid:    +1.850 V
> 
> 
> Any further thoughts?
> 
Maybe your CPU doesn't support the temperature register ? I don't really
know.

> Btw, how 
> do you apply a patch file?
> 
Usually you would use the "patch" command. Idea, though, was that you
would just use Jean's driver; he sent the patch to show the differences
to the upstream version.

Thanks,
Guenter




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
