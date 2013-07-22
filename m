From: Kapil Dev <kapil_dev@brown.edu>
Date: Mon, 22 Jul 2013 03:23:00 +0000
Subject: Re: [lm-sensors] Few queries about lm-sensors and core temp.c
Message-Id: <9787FF0D-AD25-4A38-B3EE-D81D2CFE4B53@brown.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <D137AD88-0DA4-4CF3-889D-862386B3C35A@brown.edu>
In-Reply-To: <D137AD88-0DA4-4CF3-889D-862386B3C35A@brown.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I just realized that I just replied to Jean, and didn't reply-all previously.

I am using 2.6.39-020639-generic  kernel and I am running Ubuntu 9.04. I couldn't find /etc/sensors.d/coretemp.config file. I am using 3450S intel i5 processor, which has Tjmax of 103C (sorry for the typo in my original email), based on http://users.sosdg.org/~qiyong/lxr/source/Documentation/hwmon/coretemp?a=um . 

I found that for some processors, IA32_TEMPERATURE_TARGET MSR has the Tjmax value; I assume that the coretemp.c tries to read this register and if it doesn't succeed then, it uses the heuristic value. 
Few other doubts I have are:

1) For a multi-core processor, are there separate Tjmax for each core or just 1 Tjmax value per processor?
2) Inside coretemp.c  file, the temperature is read in milli-degree C, and multiplied by 1000 to get C value. Does it mean that DTS value stored in IA32_ThERMAL_STATUS MSR is in milli-degrees? I also notice that there are only  7 bits assigned to DTS value, which would not be sufficient to cover the wide range of temperate values if it is in mill-degree C. Am I missing something here?


Thanks,
Kapil

On Jul 21, 2013, at 3:40 AM, Guenter Roeck <linux@roeck-us.net> wrote:

> On Fri, Jul 19, 2013 at 05:47:24PM +0200, Jean Delvare wrote:
>> Hi Kapil,
>> 
>> On Fri, 19 Jul 2013 11:28:28 -0400, Kapil Dev wrote:
>>> I have a couple of queries about lm-sensors package.
>>> 
>>> 1) The FAQ section in chapter-1 says that the drivers update their values every 1 sec. I am aware of the fact that reading the sensors more frequently will affect the performance as it is intrusive to CPU to read an MSR, but I need to read the core-temperature values at faster rate for a project. Would you tell me what changes I should make to read the sensors faster? In particular, I want to read the core temperature (I believe it  is done in coretemp.c through IA32_THERMAL_STATUS MSR register). coretemp.c seems to have "jiffy" as time stamp, if I change it in the coretemp.c, will it work? Or, is there any other file that needs to be changed during kernel-compilation?
>> 
>> Just change this condition in show_temp():
>> 
>> 	/* Check whether the time interval has elapsed */
>> 	if (!tdata->valid || time_after(jiffies, tdata->last_updated + HZ)) {
>> 
>> to just:
>> 
>> 	/* Always update */
>> 	if (1) {
>> 
>> This will let you read the value as frequently as you want. Or if you
>> want to keep a safety guard, you can simply change HZ to HZ/10 (read
>> every 0.1 s max) or HZ/100 (read every 0.01 s max.)
>> 
>>> 2) Does the lm-sensor package use the correct value of Tjmax (the temp value at which PROCHOT signal goes high) automatically based on the processor brand and type? I noticed that the Tjmax 0C is used in core temp.c, but the 22nm intel processor that I am working on has Tjmax of 105C. Do I need to change it myself?
>> 
>> We have a complex heuristic to figure out the right TjMax value, but
>> Intel made it such a mess that it is very difficult. So it really is
>> best effort. If the driver has TjMax wrong for your CPU, please let us
>> know what kernel version you are running, what CPU model you have is
>> and where you found the correct TjMax value.
>> 
> The 22nm processors should all report it correctly from CPU registers,
> so this is really odd. My IvyBridge CPU (i7-3770K) reports it correctly.
> I am quite sure the Haswell did too, but I am some 12,000 miles away
> from it and the system is shut down, so we'll have to wait for another
> 10 days or so until I can check it.
> 
> So, yes, we'll definitely need the CPU model and kernel version.
> 
> Guenter
> 
>> Then you can either try to fix it in the driver itself, or adjust it
>> from userspace by adding this to /etc/sensors.d/coretemp.conf:
>> 
>> chip "coretemp-*"
>> 
>>    compute temp1 @+5, @-5
>>    compute temp2 @+5, @-5
>>    compute temp3 @+5, @-5
>>    compute temp4 @+5, @-5
>>    compute temp5 @+5, @-5
>> 
>> (Adjust for your own case...)
>> 
>> Hope that helps,
>> -- 
>> Jean Delvare
>> http://khali.linux-fr.org/wishlist.html
>> 
>> _______________________________________________
>> lm-sensors mailing list
>> lm-sensors@lm-sensors.org
>> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
