From: "Mark E. Hansen" <meh@Winfirst.Com>
Date: Sun, 28 Oct 2007 20:39:21 +0000
Subject: Re: [lm-sensors] lm_sensors on ASUS M2NPV-VM motherboard using
Message-Id: <4724F379.6070706@Winfirst.Com>
List-Id: <lm-sensors.vger.kernel.org>
References: <46ED7EFC.4030609@Winfirst.Com>
In-Reply-To: <46ED7EFC.4030609@Winfirst.Com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 10/28/07 07:44, Jean Delvare wrote:
> Hi Mark,
> 
> On Fri, 19 Oct 2007 12:40:52 -0700, Mark E. Hansen wrote:
>> I posted this question on Sept 16th, but didn't get any responses. The point
>> I don't understand about creating a 'sensors.conf' from scratch is how to
>> come up with the various multiplier/division factors that are needed to
>> get accurate voltages.
> 
> There are several ways, none of which is perfect:
> * Ask your motherboard vendor or manufacturer about the factors.
>   Most of the time they will simply ignore you.

I guess I can try this.

> * Look at the voltage values displayed by your BIOS, and use factors
>   such that "sensors" will display the same values. Ordering is usually
>   the same as well.

This just seemed really hard based on the match I'd seen done in other
configurations. It didn't look like a simple "solve for X" solution.
However, I guess I can just do that and see how it comes out.


> * Look at the voltage values displayed by a Windows tool, and use
>   factors such that "sensors" will display the same values.

I'm not running Windows on this machine. I guess I could run a windows
simulator, but that seems like a long way to go...

> * Find working configuration files for boards similar to yours, they
>   might hold valuable hints.

But if I understand it correctly, it's not just that they use the same
chipset and sensor chips, but the resistors they use could easily be
different (even the type of heat sensor, for example), right?


> 
> This is tricky either way. It took me two years to be able to write
> custom configuration files with good results, so I don't really expect
> users to get it right at their first try.

I can see why. Is it true that I'm the first person to try to get the
sensors package running on this particular mother board? When I chose
this board, I had lm-sensors in mind, but I guess I didn't do a good
enough job. I figured a popular manufacturer like ASUS would surely
be covered :-)

> 
>> Can someone please have a look at this and let me know if I'm just missing
>> something?
>> 
>> Thanks
>> 
>> ----- original messages posted on 16 September 2007:
>> 
>> I'm running CentOS Linux 4.5 on a desktop machine using the
>> ASUS M2NPV-VM motherboard and an AMD A64 X2 3800 (65watt) CPU.
>> The chipset is Northbridge NVIDIA GeForce 6150 GPU, Southbridge
>> NVIDIA nForce 430 MCP.
>> 
>> I'm running lm_sensors 2.8.7 (which is current for CentOS 4.5)
> 
> This is 3 years old, which probably explains why you did not get any
> answer.

Ah... this could explain a lot. I hadn't considered getting a newer
version, and feel silly for that now. I will get the most current
version and start over.

> 
>>  From reading various archives of problems other people have had,
>> it seems those with the same board have the IT8716F chip, but
>> when I run sensors detect, it shows that I'm running the IT8705F/
>> IT8712F/SiS 950, which should be supported.
> 
> Your board really has an IT8716F, not one of the older variants. The
> IT8716F is somewhat compatible, but not completely. One significant
> difference is that the IT8716F supports two additional fans.

If it really is using the IT8716F, then I think I read something somewhere
that this chip is not really supported yet, and a kernel patch was
required. Is that right?

> 
>> When I use the sensors.conf that comes with the package, it seems
>> to not be showing the correct sensor data, as though it thought
>> it was a different chip.
>> 
>> Is sensors-detect wrong in saying that I'm running the IT8705F,
>> and that I'm really running the IT8716F?
> 
> Certainly. That's not very surprising if you ran a 3-year-old version
> of sensors-detect to identify a device that did not even exist 3 years
> ago. Just run a more recent version of sensors-detect and it'll tell
> you the truth:
> http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/detect/sensors-detect?format=txt

In fact, here is what I get from the new sensors-detect program:

> Driver `it87' (should be inserted):
>   Detects correctly:
>   * ISA bus, address 0x290 (Busdriver `i2c-isa')
>     Chip `ITE IT8716F Super IO Sensors' (confidence: 9)
> 
> Driver `k8temp' (should be inserted):
>   Detects correctly:
>   * Chip `AMD K8 thermal sensors' (confidence: 9)

And, as expected, it finds the IT8716F chip.


Thanks so much for your help, Jean. I knew I must have been doing something
wrong.

I'll be back once I get the new version up and running and work through
getting a configuration file up and running.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
