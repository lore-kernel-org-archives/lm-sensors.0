From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 07 Jan 2010 13:02:17 +0000
Subject: Re: [lm-sensors] sensors show hdd temp instead of cpu temp using
Message-Id: <20100107140217.2b586da4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <b4184b2f1001041651x593dec41tf7e6a0dc71acecf8@mail.gmail.com>
In-Reply-To: <b4184b2f1001041651x593dec41tf7e6a0dc71acecf8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 7 Jan 2010 00:07:28 -0500, vajorie wrote:
> Thanks for your response (and it's truly great to hear from intel, as
> a side note). If I got your message right, unfortunately, I'm not
> literate at all about the internal mechanisms of hardware monitoring
> :( All I know is that the temperature that is reported as cpu's by
> coretemp / sensors is actually (I'm pretty sure) that of the hdd. The
> crit temps that sensors report (90C) is accurate according to intel's
> specs for N280, but the temperature is too low for this cpu (right
> now, it's 29C) and it corresponds almost perfectly to hdd temperature
> reported in Windows (checked with a reboot from Linux to Windows). The
> average cpu temp reported in Windows is 50C+...

You are doing several wrong assumptions.

You assume that the temperatures reported by hwmonitor are correct. As
this program is not provided by your hardware vendor, this may not be
the case. What makes you believe that hwmonitor is right and Linux is
wrong rather than the other way around?

You also assume that the temperature values reported under Windows and
under Linux should be the same. This may not be the case, depending on
the thermal strategy used by each OS. Many things can change the CPU
temperature, including the voltage and frequency at which it is
operated, its load, and the use of C states.

One thing I can say for sure is that the Linux coretemp driver does NOT
report your hard disk drive's temperature. This is simply impossible
technically.

> Is it possible that what coretemp thinks is MSR is actually not it (I
> don't know what I'm saying at this point)?

No, it's not possible. The coretemp driver is reporting the CPU's
temperature. Possibly not accurately, but in no way it can report
something else's temperature.

> This may be related to how Acer set (wrongly?) things up with Aspire
> One D250 (via their bios??), but I'm not sure about that. Their bios
> (?) already has other problems with this cpu[1].
> 
> I opened yet another bug report in linux kernel about this:
> http://bugzilla.kernel.org/show_bug.cgi?id991 which has one other
> user reporting similar experience on the D250. That bug report also
> has my output of acpidump, if relevant here.
> 
> Thanks again for your reply.
> Is there any way I can help debug this?

As this is an Acer machine... Did you try the acerhdf driver already?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
