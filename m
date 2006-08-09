From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Wed, 09 Aug 2006 18:35:56 +0000
Subject: [lm-sensors] BIOS Corruption (was : new abituguru driver in mm
Message-Id: <44DA2B0C.1060502@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <ce9ef0d90608052222j74e9f6fes40cbc5edf5678577@mail.gmail.com>
In-Reply-To: <ce9ef0d90608052222j74e9f6fes40cbc5edf5678577@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi All,

I was on a long weekend / short vacation hence the slow response.

Jean Delvare wrote:
> Hi Sunil, Hans,
> 
>> I found an issue with the driver. It seems to have put something in the
>> uguru part of BIOS, which makes my BIOS hang when I enter Abit uGuru
>> temperature monitor screen in the BIOS. No keys work and only way for me at
>> that point is to give it the three finger salute. The peculiar thing I
>> noticed was that somehow it modified the shutdown and beep CPU temperatures
>> to 245C and 235C while I had them set at 65C and 75C.
>>
>> As soon as the temp monitor displays 245C in CPU row, it just hangs. The
>> next values to be displayed are the enable bit for these temps, I think.
>>
>> I never used the driver to write anything to BIOS, so how did it end up
>> updating those values?
> 
> Err, this is bad :(
> 
> Hans, see why I was reluctant to having your driver in the kernel tree?
> Nothing personal, but that kind of problem is to be expected when
> writing a driver without a datasheet :(
> 
This would / could have happened with a datasheet too, its a combination
of a buggy chip (the uguru) which is a pain to work with (it would be
even with a datasheet) and a bug in my driver.

> What should we do now? Mark the driver broken in the kernel tree?
> 2.6.18 is just around the corner, and we sure don't want people to
> corrupt their BIOS.
> 

Things are not as bad as they look, the driver did not corrupt the BIOS,
nor the CMOS ram. For some strange reason (design probably) the Abit
uGuru motherboards BIOS saves the uguru settings to CMOS on successfull
(ACPI) poweroff. So all the driver did was write the uGuru register it
was designed to write, its not writing over random memory.

Also notice that the BIOS is also being buggy in this case, because it
hangs because of a single invalid byte in the uguru's settings, whereas
it should just be checking the relevant bits and ignoring the irrelevant
ones.

The problem has been very correctly analysed by Sergey Vlasov
<vsu at altlinux.ru>, there is indeed a bug in the driver where it fails to
restore the original settings when any read fails during the sensor type
detect code. Attached is a version which fixes this bug and which will
always restore the settings (if changed) no matter how that function is
left. To be really sure it tries the restore up to 3 times in case of a
writing error.

Sergey also correctly points out that this code is writing the uguru
todo the probing and that this is not ideal, unfortunatly, I cannot
think of another way.

I do not believe this bug will reoccur, not with sunil's new and
improved timeout handling, which make the chance of actually getting a
timeout error pretty small, combine this with the always restoring the
settings on an error, instead of the current buggy behaviour and
retrying this restore in case of a write failure (due to those same
timeouts, which are pretty rare now), the total chance of this happening
again is very small. And even if it happens a CMOS reset is enough, most
likely load setup defaults is enough, that fixed a similar issue for me
when I completly trashed the uguru during driver development (I was
probing random uguru bank addresses, which the uguru did not like).

To make really really sure we never get bitten by this I've added code
to the sensors detect code, to mask out any invalid bits from the
original settings byte before restoring it to the uguru.

Sunil,

Could you try the attached abituguru.c, after loading it once, it should
have fixed those invalid settings and you should be able to reenter the
relevant screen in your BIOS' setup just fine.


Here is a complete list of all the changes in this version compared to
the one in the kernel. I've also attached a unified diff between the
latest in kernel version and the attached one, so that it can get an
initial review. If this version fixes Sunil's problems as expected
without him needing to reset his BIOS, I'll then send an offical PATCH
with these changes for merging:

-Much improved timeout / wait for status handling. Many thanks to Sunil
 Kumar, for all his testing, ideas and patches! The code now first busy
 waits, polling the uguru for the expected status as this usual succeeds and
 it succeeds pretty quickly (within 90 reads). To avoid unnescesarry CPU
burn
 in timeout conditions, the amount of busy waiting has been halved from
 previous versions (120 tries instead of 250). This is not a problem,
because
 this version goes to sleep after 120 attemps for 1ms and then tries
again,
 it does this sleep and try again 5 times before finally giving up. This
 (almost?) completly removes the timeout errors some people have seen
 regulary. Appearantly some older uguru versions sometimes are distracted
 for a (relativly) long time. This solves this.
-These timeout errors not only occur in the sending address part of reading
 the uguru but also in the wait for read state, so errors in this state are
 now handled as retryable just like send address state errors and are only
 logged and reported to userspace if 3 executive tries fail.
-Add rudimentary suspend / resume support, this protects the uguru and
 the driver against suspend / resume cycles, so there is no reason to unload
 the driver in your suspend / resume scripts.
-Fix a very nasty bug in the bank1 sensor type detection code, where it
 would not restore the original settings in any of the error paths!
-Since not successfully restoring the original settings can seriously
 confuse the system BIOS (hang when entering the relevant setup menu), we
 now try restoring them 3 times before giving up.
-On successfull dectection of bank1 sensor type mask out any bits invalid
 for this type from the sensors original settings before restoring them.
 This should restore any damage done by the bug mentioned above, and should
 also repair any damage done in the highly unlikely scenario of the original
 sensor settings restoring failing.

Regards,

Hans

-------------- next part --------------
A non-text attachment was scrubbed...
Name: abituguru.c
Type: text/x-csrc
Size: 53013 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060809/0a222b95/attachment-0001.bin 
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: diff
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060809/0a222b95/attachment-0001.pl 
