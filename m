From: xuan--sensors--2003.12.20@baldauf.org (Xuan Baldauf)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: Hidden and disabled SMBus SiS0016, please enable
Message-Id: <3FF1FFFA.5090206@baldauf.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FE4DB3C.8050504@baldauf.org>
In-Reply-To: <3FE4DB3C.8050504@baldauf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark Studebaker wrote:

>
>
> Mark M. Hoffman wrote:
>
>> * Xuan Baldauf <xuan--sensors--2003.12.20@baldauf.org> [2003-12-21 
>> 00:29:00 +0100]:
>>
>>> Hello Alex and Mark,
>>>
>>> I'm referring to your discussions at 
>>> http://archives.andrew.net.au/lm-sensors/msg01299.html
>>>
>>> I have got a new notebook "Mitac 8640m". (The same as in 
>>> http://archives.andrew.net.au/lm-sensors/msg03881.html ) It is based on 
>>
>>
>>
>> I re-read that thread and laughed: is your machine really labelled
>> "Packard Bell"?  I can't remember the last time I saw that name on
>> a computer in the US - at least not since 1995.  They had an *awful*
>> reputation.
>>
>>
>
> Looks like NEC owns Packard Bell and has been investing in them since 
> 1995.
>
> http://www.businessweek.com/1998/02/b3560256.htm
>
Just in case somebody is interested, I want to mention:

I now can read out the temperatures (actually, there are two sensors in 
this notebook), not by SMBus, but by using the ACPI embedded controller. 
However, by reading the ACPI DSDT table, I found out that there is also 
a way to access the ACPI embedded controller address space using the 
SIS0016 controller. I did not investigate further into it, because I did 
not need (because reading by ACPI EC was sufficient).

I then changed the ACPI DSDT table to define three new thermal zones, 
one for the CPU temperature, one for the chipset ("mainboard") 
temperature and one for the maximum CPU temperature since the last real 
poweroff (which is also reported in the ACPI address space). I 
discovered that the CPU temperature oscillated between 44 ?C and 54 ?C, 
which is pretty cool. Additionally, I can (under Linux) read these 
temperatures. Under Windows, I'm missing such a tool (hint to Alexander 
van Kaam ;-)).

Then I hacked the firmware of the ACPI embedded controller (which 
actually is software for the Hitachi H8/300, which is the core of the 
microcontroller which provides the ACPI EC functionality) so that the 
fan speed is only 15% of the former value. The fan at this low speed 
blows the heat nearly as equal as the fan at high speed. Even with full 
CPU usage, the temperature will not rise above 56 ?C. But now, the fan 
is *much more* quiet, there is just some regular ticking. I do not know 
wether these ticks are due to snapping in of the motor or wether they 
are due to microcontroller which may set the fan speed by providing 
duty-cycles, i.e. on-off-alternations where the "on" time is higher when 
the fan should run faster. Nevertheless, it served the purpose of 
calming down the 8640 notebook.

Unfortunately, the notebook has a too high thermal resistance to the 
environment if the fan is completely off. That means, that the 
temperature will be too high (63 ?C) if the fan is shut off for longer 
time. If the temperature is kept too high, the heat will flow to other 
parts of the notebook (i.e. the chipset), which will make a secondary 
fan start. Because this fan is normally off, I consider the safety limit 
for slowing down the CPU fan to be that low speed of the CPU fan. where 
the secondary fan would start due to heat flow.

So, that's the story.

If someone needs somebody for hacking ACPI tables or ACPI embedded 
controller firmware in order to read temperatures and control fans, 
maybe I can help.

Xu?n Baldauf.
