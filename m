From: =?UTF-8?B?VG9tw6BzIERlbHRlbGwgQm9uZWxs?= <tomasdeltell@gmx.es>
Date: Thu, 07 Apr 2011 17:59:22 +0000
Subject: Re: [lm-sensors] testing "w83627ehf" on Asrock ION 330 HT
Message-Id: <4D9DFB7A.2010407@gmx.es>
List-Id: <lm-sensors.vger.kernel.org>
References: <201103310124.08484.tomasdeltell@gmx.es>
In-Reply-To: <201103310124.08484.tomasdeltell@gmx.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

El 31/03/2011 10:06, Jean Delvare escribió:
> On Thu, 31 Mar 2011 01:24:08 +0200, Tomàs Deltell Bonell wrote:
>> I'm trying to install w83627ehf driver on my Asrock ION 330 HT with Mandriva
>> 2010.2, kernel 2.6.33.7 and lm-sensors 3.1.2. When i try to compile i get this
>> error:
>>
>> $ make
>>    CC [M]  /home/user/w83627ehf/w83627ehf.o
>> /home/user/w83627ehf/w83627ehf.c: on function ‘w83627ehf_find’:
>> /home/user/w83627ehf/w83627ehf.c:2385: error: implicit declaration of
>> ‘pr_warn’ function
>> make[2]: *** [/home/user/w83627ehf/w83627ehf.o] Error 1
>> make[1]: *** [_module_/home/user/w83627ehf] Error 2
>> make: *** [modules] Error 2
>>
>> and i don't know how to continue
> Where do you get this driver from? The one I host at
>    http://khali.linux-fr.org/devel/misc/w83627ehf/
> includes a compatibility patch for the problem you are reporting. And
> the one Guenter is hosting at
>    http://roeck-us.net/linux/drivers/w83627ehf/
> includes variants for older kernels (2.6.18 and RHEL 5.4 as I
> understand it.)
>
> BTW, Guenter, I don't think it makes sense that we both maintain a
> standalone w83627ehf driver. Mine is lagging behind these days (lacks
> support for the NCT6776F) but yours is less user-friendly IMHO (separate
> source files for older kernels.) Maybe we can combine our efforts to
> have a single, up-to-date and user-friendly driver? First question
> being: do you plan to keep your driver alive at all, or was it just
> there for the times when you were working on adding NCT6776F support?
>
> FYI, I am using quilt to maintain my standalone drivers. This lets me
> keep the compatibility layer separated from the original driver code.
> That way it is very easy for me to update to a new base version of the
> driver - I simply pop the compatibility patch, update the driver, push
> the compatibility patch again and refresh it as needed. Then I upload
> the result to my website. I don't know if you have such a workflow on
> your side.
>
I was using the Guenter's driver. But last night I tried your driver and 
compiled correctly. This is the result:

$ sensors
w83667hg-isa-0290
Adapter: ISA adapter
in0:         +1.14 V  (min =  +0.00 V, max =  +1.74 V)
in1:         +0.59 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
in2:         +3.42 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
in3:         +3.42 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
in4:         +1.31 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
in5:         +1.29 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
in7:         +3.47 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
in8:         +3.20 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
fan1:          0 RPM  (min =    0 RPM, div = 1)
fan2:          0 RPM  (min =    0 RPM, div = 1)
fan3:          0 RPM  (min =    0 RPM, div = 1)
fan4:          0 RPM  (min =    0 RPM, div = 1)
temp1:       +54.0°C  (high =  +0.0°C, hyst =  +0.0°C)  ALARM  sensor = 
diode
temp2:       +53.5°C  (high = +80.0°C, hyst = +75.0°C)  sensor = diode
temp3:       +67.5°C  (high = +80.0°C, hyst = +75.0°C)  sensor = diode
cpu0_vid:   +0.000 V

coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +22.0°C  (crit = +90.0°C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +31.0°C  (crit = +90.0°C)

Temperatures of the new adapter is displayed correctly (in accordance 
with the information that BIOS shows)
These are the results that should be shown?
There are any plan to include support for these chips on lm-sensors?

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
