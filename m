From: dave@boost-consulting.com (David Abrahams)
Date: Sat, 12 Aug 2006 11:49:10 +0000
Subject: [lm-sensors] Thinkpads still not supported?
Message-Id: <ur6zmuqbt.fsf@boost-consulting.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20060811T155741-190@post.gmane.org>
In-Reply-To: <loom.20060811T155741-190@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare <khali at linux-fr.org> writes:

> David,
>
>> > There's a kernel driver named "IBM ThinkPad Laptop Extras", it's
>> > probably that. Never used it, I can't tell what it does exactly nor how
>> > useful and reliable it is.
>> 
>> Thanks; I'll check that out.  Do you happen to know how I can find out
>> what an acceptable GPU temp is on this thing, and/or what I can do to
>> keep it under control?
>
> No, sorry. I never had a Thinkpad laptop myself. Best is probably to
> find someone else with similar hardware, and compare your numbers.

I finally did;
http://forum.thinkpads.com/viewtopic.php?t%304&postdays=0&postorder=asc&start=0
is somewhat inconclusive.  Sounds like the Apple MacBookPro heat
debacle all over again, on a smaller scale.

>>                         The vesa driver runs it at 60 Centigrade at
>> idle, which is already hot.  The ATI drivers all run it at 71 and
>> above, which is scary (to me anyway).
>
> I'd say it's high, but not scary.

185 degrees Farenheit at idle doesn't worry you?  Well, that's good to know.

>> > No, don't worry. As long as you don't run sensors-detect 
>> 
>> Well, I did, before I found the admonition not to.  And I recall at
>> some point last week, long before I ran sensors-detect, seeing a
>> message at boot that the EEPROM had been corrupted or something (!) I
>> think I may have installed something from my XP partition that
>> corrected it (although I don't specifically recall a BIOS update), and
>> I don't recall seeing it recently.
>
> Nasty. These EEPROMs have a state machine bug which makes them
> vulnerable, so other tools and OSes could corrupt it as well. However,
> as far as I remember, the corruption cases that were reported to us
> were fatal, in that the laptop would not boot anymore. Your case seems
> to be different, but without additional details it's hard to come to any
> conclusion.

I'm going back over to the dark side briefly to recover things, and
I'll install a BIOS update if necessary.  I'm still at a point with
this machine where I don't mind completely redoing my Linux install if
I have to.

>> > and/or load random i2c and/or hwmon drivers, nothing bad will
>> > happen. Just installing the lm_sensors user-space tools doesn't
>> > represent any danger. As far as I know, ksensors can use other data
>> > sources than lm_sensors (ACPI, hddtemp...) so it may still work.
>> 
>> Oh, then maybe I'll reinstall it; thanks!
>
> Make sure your system won't load related drivers for you at boot
> time.

Like what?

> If you ran sensors-detect and let it create it's configuration file
> (typically /etc/sysconfig/lm_sensors), the modules listed in that file
> will be loaded at boot time, and you don't want this to happen. To be
> safe, delete or blank that file.

OK, will do, thank you very very much.

-- 
Dave Abrahams
Boost Consulting
www.boost-consulting.com


