From: "Ivo Manca" <pinkel@gmail.com>
Date: Thu, 14 Jun 2007 14:19:14 +0000
Subject: Re: [lm-sensors] sis5595
Message-Id: <007c01c7ae8e$fe2512a0$0601a8c0@pinkeltje>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307161427.08403.linux@1g6.biz>
In-Reply-To: <200307161427.08403.linux@1g6.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hey Jean,

I got response from PCCHIPS, but no luck that way. They simply said 
something along the line of "We don't provide datasheets to End-users and
you can download the drivers from our website", where they obviously are not 
(The AMI utility, it is).
Pitty, but not that surpising..

I also posted a message on GoT (dutch tweakers forum) and someone pointed me 
to "PCCHips Lottery", which is offline right now, but Internet Archive keeps 
a mirror at:
http://web.archive.org/web/20060114065910/http://www.stud.fernuni-hagen.de/q3998142/pcchips/threads.html
Might be a very usefull link to other people with a PCCHIPS mobo.

According to this post:
http://web.archive.org/web/20041227220452/www.stud.fernuni-hagen.de/q3998142/ubb/Forum3/HTML/001138.html
It seems that the motherboard has two temperature sensors, one for the 
Socket 370, one for the Slot 1. I use the 370.

> The JP7 (I think this is the number, is the one in the middle of the 
> motherboard, with 3 pins) chooses which temp sensor will be measured
> (S370 OR Slot1). At least that's my conclusion after some tests...
> If you put the opposite setting on JP7 your motherboard will measure the 
> sensor that is no on your CPU and you will get a "system
> temperature" like measure.
So that's at least something.
I'll have more time next week, and I'll try to see if I can extract some 
more information about the temperature and sensor-readings.

Ivo

P.s. Hans: Thanks for offering your multimeter, however, I'd rather try it 
without one first :).

----- Original Message ----- 
From: "Jean Delvare" <khali@linux-fr.org>
To: "Ivo Manca" <pinkel@gmail.com>
Cc: <lm-sensors@lm-sensors.org>
Sent: Tuesday 12 June 2007 18:25
Subject: Re: sis5595


> Hi Ivo,
>
> On Mon, 11 Jun 2007 18:21:13 +0200, Ivo Manca wrote:
>> in4:       +3.55 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
>>
>> after md5sum:
>> [root@localhost ivo]# sensors -c sensors-PCChips
>> (...)
>> in4:       +0.19 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
>>
>> Seems like in4 dropped completely?
>> Wait: it seemed like a flatcable dropped on the fan, and stopped it
>> spinning. So I guess +0,19V is suppose to say "Way to hot: you're burning
>> your fingers!"? (Since I actually did burn my finger)
>>
>> But one minute after the fan started spinning again...
>> (...)
>> in4:       +0.00 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
>>
>> And 30 seconds later:
>> (...)
>> in4:       +4.03 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
>>
>> After a complete cooldown period (30 mins idling)
>> (...)
>> in4:       +3.42 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
>
> Strange. The value changes, so I was probably right that in4 was
> connected to a thermal sensor, but OTOH, the values look odd. The
> first two and last values suggest that +3.55 V / +3.42 V corresponds to
> the normal running temperature, and +0.19 V means the CPU is very hot,
> but the 3rd and 4th values don't really fit in that model. Or maybe it
> was just too hot and the sensor got confused for some time, I don't
> know.
>
>> Is there any way to get information from PCCHIPS, or is it just a waste
>> of
>> time to request information from them?
>
> If the board is 10-year old, it's probably hopeless, but it depends on
> how much you want to get it to work and how much time you are ready to
> spend on it.
>
> If you can't get additional information, you can label in4 "CPU Temp",
> observe the reading over a period of time, and set arbitrary limits
> accordingly. Unfortunately we have no way to tell "sensors" that a
> voltage input is actually a temperature value.
>
>> > Well, I crafted the configuration file to make it look good, so it
>> > doesn't mean much ;)
>>
>> Is there actually any way to see if it is correct, not involving to use a
>> multimeter? I lost mine, so I should buy a new one ;p
>
> The other possibilities are asking PCChips, or attempting to
> disassemble the BIOS.
>
> -- 
> Jean Delvare 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
