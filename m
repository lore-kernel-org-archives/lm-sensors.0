From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Mon, 23 Jul 2007 14:33:12 +0000
Subject: Re: [lm-sensors] Fujitsu-Siemens Scylla (fscscy)
Message-Id: <46A4BC28.1080103@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <46933578.3010701@miloi.de>
In-Reply-To: <46933578.3010701@miloi.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 
> You may also want to take a look at the pending driver for the new FSC
> Heimdall chip:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-January/018629.html
> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-February/018787.html
> I wonder if it is also similar. I just added an entry to wiki/Devices.
> 

It is indeed similar too, for some reason FSC keeps changes fan and temp 
register addresses, but that can easily be handled with an array addressed with 
the chip-type.

Also they seem to have done strange things with temp sensor numbers, for the 
fscpos and fscher the temp sensors are identical, however the fscscy adds a 
fourth sensor, but in the 2.4 sensors puts that in as temp2 moving temp2 and 3 
to temp3 and 4 when compared to the fscher / fscpos, I guess its best to just 
clone this erm "interesting" numbering in the 2.6 driver.

>> Jean & Mark, were do you stand with regards to this., I see 2 options:
>>
>> 1) * Many smaller patches with incremental improvements to the fscher
>>     * essentially making it an fscxxx driver
>>     * with the current pseudo watchdog support left in for compatibility
>>     * with other uglies like raw export of status registers left in for
>>       compatibility, while also exporting the exact same info with _alarm and
>>       _fault files
>>
>> 2) A new fscxxx driver tackling all the issues at once, based on my current
>>     fscher work, with some major cleanup and added fscscy support
>>
>> As I type this, and also remind myself that the current driver has to keep 
>> carying the tempX_status ugliness, my vote strongly goes to the new driver 
>> approach. Then we can mark the fscpos and fscher drivers as obsolete for a 
>> while and remove them eventually.
> 
> I agree that having a single driver for all similar chips would be
> great, as it would lower the maintenance effort. I don't really care
> which road you take, but here are my random thoughts:
> 
> * I discourage the use of "x" in the driver names. It looks great only
> until the day a new chip is released, those name matches the mask, but
> which isn't compatible at all. For hardware monitoring drivers, we tend
> to name the driver after the first supported chip, and consider the
> others as "mostly foo-compatible."
> 

Okay, so I will call it fscpos_new then.

> * If you go for a new driver, without watchdog support, then we will
> have to keep all the other drivers around for at least some time
> anyway. So the watchdog problem is more or less independent from your
> decision.
> 

I know, but doing a new driver is in my mind way easier then juggling a lot of 
incremental patches to an existing driver, and there is more then just the 
watchdog, the current drivers also have old alarm files and various exports of 
status registers in raw formats, the fscpos also has very interesting 
rempX_reset sysfs entries, which can be written to reset the alarms for temps, etc.

So I'll start working on a new clean unified driver for the 4, without watchdog 
support for starters, but watchdog support according to the standard API's will 
be on my roadmap.

I'm actually planning to make writing the watchdog support a lab assignment for 
a device driver class I will be teaching starting september.

AFAIK I already asked, but let me ask again: I could really use some ideas / 
suggestion for chips/devices which come with docs and need a 2.6 driver 
written. So that I can use this as assignments, don't worry I will review, 
submit (if usable) and maintain any resulting drivers myself. Unless ofcourse a 
student likes writing the driver so much he pledges to maintain it himself.

I'm currently thinking about trying to get some adm1024 chips for example, but 
I wonder is the statement on the devices wiki-page that the adm1024 is not 
supported with 2.6 still accurate?

Thanks & Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
