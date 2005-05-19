From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: Emachines M5310
Message-Id: <408CAB3A.8040603@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1082877126.2416.19.camel@eagleone.eagles.net>
In-Reply-To: <1082877126.2416.19.camel@eagleone.eagles.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>
>
>  
>
>Performance Tips
>Warning 2533 : Disabled host controllers are present. Check BIOS settings.
>Tip 2536 : System has no SMBus/i2c/BMB bus support.
>Tip 10 : To benchmark/test your PDA / SmartPhone, use the 'Switch Test System' button.
>Tip 2 : Double-click tip or press Enter while a tip is selected for more information about the tip.
>  
>

I see that Sandra sees *something* disabled, but it's not clear that 
it's sensor related.

Again, why do you think you should get a CPU temperature?  The AMD and 
Intel CPU's have a thermal diode on the die, but they only work if they 
are connected to a sensor chip.  Intel CPU's also have thermal 
throttling sensors, but these are not readable by system software.

Can you be more specific about what part of the DSDT you think hints at 
more information?

Can you provide the output from 'lspci' and 'lspci -tv'.  That will give 
a breakdown of the PCI devices found and how they are connected.  I'm 
particularly interested in what southbridge and/or Super I/O chip was 
used in your system.

Thanks,
:v)

John Hawk wrote:

>Please find attached dmesg sandra dsdt.dsl sensor-detect outputs
>
>At a minimum it should give me cpu temp, which I can't get and DSDT
>hint's at more.  Sandra states the controller is present but not turned
>on in BIOS. Yes, this is a Microsoft enabled BIOS and looks for
>"Microsoft Windows NT" etc and checksum operations acpi_os_name failed
>to be of assistance.
>
>If I can provide any more info to help let please let me know.
>
>
>On Sun, 2004-04-25 at 22:56, Philip Pokorny wrote:
>  
>
>>The output from sensors-detect would be helpful.
>>
>>Also, PCI output that has the PCI ID's translated into text would also 
>>be helpful.
>>
>>Do you have any evidence that there actually *are* sensors in this 
>>system?  It's possible there aren't any.
>>
>>:v)
>>
>>John Hawk wrote:
>>
>>    
>>
>>>I have had extended correspondence with Dave Jones of PowerNow and
>>>finally have  PowerNow up and running and a new patch bk2 will alleviate
>>>the need to build custome kernels every time, A Plus
>>>
>>>This leads me to my next conquest sensor support on the Emachines M5310.
>>>I have tried the various Windoze (yuk) options and they also complain of
>>>BIOS options. Emachines flat refuses to address any problems with the
>>>M5310 BIOS I have corrected four error in the DSDT and compiled and
>>>installed same in kernel 2.6.5-1.327 Fedora Core 2 test 2.
>>>
>>>However, if I run sensor-detect the only thing found (twice as noted
>>>could happen) is an eprom  for memory. 
>>>
>>>If there is anything I can do to provide information to assist both you
>>>and myself in obtaining accurate sensor detection please let me know. I
>>>would like to get this up and running.
>>>
>>>I will attach output from a little program that should provided a real
>>>world snapshot of the current config.
>>>
>>>Thanks
>>>
>>>john
>>>
>>> 
>>>
>>>      
>>>
>>
>>    
>>

