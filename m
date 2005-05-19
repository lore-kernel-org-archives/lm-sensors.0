From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: sysfs names
Message-Id: <402EED55.6070703@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040126230447.09700886.khali@linux-fr.org>
In-Reply-To: <20040126230447.09700886.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I like solution #3.

Jean Delvare wrote:
>>Some temperature sensors have two types of alarms.  An over-limit 
>>(max_alarm) alarm and a sensors failed alarm.
>>
>>We could do this a couple of different ways:
>>
>>1. Name the alarm file for a sensor: temp1_alarm and have it take one
>>of several values:  "" (null string), "ALARM", "FAIL"
>>
>>2. Come up with another name for the other alarm: temp1_input_failed? 
>>temp1_fail_alarm?
>>
>>3. Some other idea I haven't thought of?
> 
> 
> Thanks for pointing that out. We really need to have a global view of
> all drivers if we want to make it correct on the first try, and there
> are at least two dozen chip drivers I never took a look at, so I need
> assistance.
> 
> My initial idea was 2. I wasn't thingking of failed yet (although I have
> to admit that at least one driver I have been working on does have it -
> lm83 or lm90, I can't remember). I was thinking of beeps, for chips that
> have a beeps register matching alarms.
> 
> This means that if we consider 1, we sometimes would need more than one
> string, because for example alarm and beep typically occur at the same
> time. Although this is easy to read for a human, it is likely to require
> some additional parsing code in the library.
> 
> If we now consider 2, this means that the number of files will increase
> significantly. For example, we can easily imagine a single temperature
> channel needing the following files:
> 
> temp1_input
> temp1_min
> temp1_max
> temp1_max_hyst
> temp1_over
> temp1_over_hyst
> temp1_alarm
> temp1_fail
> temp1_beep
> 
> Even more if you consider that there may be different alarm bits for
> different limits. For example, it would make sense to have something
> like:
> 
> temp1_input
> temp1_fail
> temp1_max
> temp1_max_hyst
> temp1_max_alarm
> temp1_max_beep
> temp1_over
> temp1_over_hyst
> temp1_over_alarm
> temp1_over_beep
> 
> We could suspect that one single beep file would be sufficent, since we
> already can check the individual alarm files to see which limit has been
> crossed. But I think that some chips allow individual beep disabling, so
> if two alarms have triggered, it wouldn't be possible to determine
> because of which the system is beeping. The question is to know if we
> really care, or not.
> 
> Now that we speak about it, such systems would need additional files:
> 
> temp1_max_beep_enable
> temp1_over_beep_enable
> 
> Think of complete monitoring chips such as the w83781d and family, this
> could lead to many, many files. The list above shows that we can
> reasonably expect 10 files per item, and such chips can have, say, 13
> items, which leads to the very approximate value of 130 files (although
> fans and voltages probably will have less files in average than
> temperatures, so let's say 100 files total).
> 
> Greg, is it correct to have such a high number of sysfs files for a
> driver?
> 
> If not, I have a solution 3.
> 
> We could define an arbitrary bit order for indiviual alarm files, much
> in the idea of current alarm files, but where the order of the bits
> wouldn't be chip-dependant. Example:
> 
> 1<<0 = alarm
> 1<<1 = beep
> 1<<2 = fail
> 
> This leaves some root for future extensions, while still limiting the
> number of files and being fast to "parse" (i.e. no parsing required).
> One drawback over 1 is that it is less easily readable by a human, also
> a simple rule apply (0 = OK, else there's at least one thing wrong). One
> drawback over 2 is that someone (or something) parsing the sysfs
> directory doesn't know wether a given bit is supported by the chip
> (unless that bit is set at the moment).
> 
> I see the sysfs files as a very interesting way to actually describe
> what a chip can do or not. This begins with the items themselves, then
> the limits/divisors/etc that apply to them, and it would probably be
> great if this could be extended to just anything, including alarm bits.
> 
> I think we really need to go on thinking about it all :)
> 
> Thanks.
> 
