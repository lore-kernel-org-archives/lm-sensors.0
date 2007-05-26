From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 26 May 2007 21:08:06 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/pc87360: Convert to a platform driver
Message-Id: <4658A1B6.60106@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070521171943.420aa00b@hyperion.delvare>
In-Reply-To: <20070521171943.420aa00b@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Thu, 24 May 2007 09:34:37 -0600, Jim Cromie wrote:
>   
>> Jean Delvare wrote:
>>     
>>> I finally found some time to convert the pc87360 driver to a platform
>>> driver. Jim (or anyone else with access to supported hardware), could
>>> you please give it a try and confirm that it works OK?
>>>       
>> yes it works!
>>
>> these are with the conf in debian unstable -
>>
>>     
> Thanks for the report, Jim! Hopefully the output looks the same as
> without my patch? Did you try unloading and reloading the driver too?
>
>   

I built your patch into 22-rc2, and had earlier kernels with pre-patched 
version.
so testing both meant reboots.  Have just tried rmmod, modprobe - as 
expected,
it works.

FWIW - due to some history with the power section of this board,
Ive (previously) written a script to compare output from sensors (live) 
vs similar
output saved previously. 

Using it now:

[jimc@harpo lab]$ cksensors.pl -r1 sensor-out-2.6.22-rc*-sk-debconf
check vid
check Vbat
check in5
check S-IO Crit
check Vsb
check in6
check CPU1 Crit
check S-IO Temp
val out of range by 2.08%, 96 should be +98
check in1
check in2
check in3
val out of range by 2.99%, 0.67 should be +0.65
check in4
check Vdd
check in0
check AVdd
check CPU0 Crit
check CPU1 Temp
check CPU0 Temp

[jimc@harpo lab]$ cksensors.pl -r1 sensor-out-2.6.22-rc*-sk-myconf
check VPWR
val out of range by 3.67%, 13.07 should be +13.55
check VCORE
check VCC
check Vbat
check Critical
check -12V
check Vsb
check Vdd
check +12V
check Temp
val out of range by 1.04%, 96 should be +97
check AVdd
check GND


The 1% check (-r1) is just for test.. 
Ive settled on 5% for power fluctuations, since nothing seems to go wrong..

If wanted, its here
http://jim.cromie.googlepages.com/linux-page
>   
>> [ 1903.061714] hwmon-vid: requested unknown VRM version
>> vid:      +0.000 V  (VRM Version 0.0)
>>     
>
> Hmmm, we should probably fix this warning, too. Maybe your CPU doesn't
> even have VID pins. Patch follows.
>
>   
Ive seen the patch - Yeah! from the backbench, consider this an ACK :-)
Id gotten used to looking right past the errors

I have a  " Geode by NSC",   aka SC-1100, a 586MMX class cpu AFAIK.
fwiw, Ive never seen any difference by building any of the Geode* cpu 
choices.

I recall looking at the vrm code, and concluding from the very helpful
comments (thanks Rudolf) that the VRM implementations prior to 686 were
rare/broken/unreachable, and that "I didnt have it" :-(


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
