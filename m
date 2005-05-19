From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: lm77 on national sc1100
Message-Id: <20040707142145.2e723267.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1088690691.2862.25.camel@null>
In-Reply-To: <1088690691.2862.25.camel@null>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Sorry for the late answer, I didn't receive your mail, just found
> it in the mailing list archive.

I was wondering. I got an error on my mail stating:

"<drewie@freemail.hu>: conversation with fmx.freemail.hu[195.228.242.194] timed
    out while sending end of data -- message may be sent more than once"

And I thought "in the worse case he'll get it twice". Looks like I was
wrong...

> Attached is a patch against 2.6.7-mm6, reworked to comply with your
> comments. I chose to store the temperatures as `int' and not `s16'
> because I store the converted values and eg. 80000 would hardly
> fit in s16.

Ah OK. We usually store "raw" register values and convert them right
before "exporting" them. But I admit your way is more efficient. Still
your comment "Register values" is now misleading, you should consider
changing it.

> I guess it's time to admit that I've never written anything longer
> than 10 lines in C before, so this is why it's going so slow. Thanks
> for your time and patience :-)

No problem. You couldn't possibly know the kernel folks (strange)
choices for coding style, nor the common patterns in our chip drivers.
Patience is the way only way i know to learn.

A few more comments:

1* Alignment. Kernel folks are being a bit strict when it comes to
alignment. You are not allowed to use spaces to align your defines, nor
your structure members. I know it's a bit restrictive, but that's the
way it goes.

2* Do you have a personal need for exporting the configuration register
to user-space? Other drivers don't. It's assumed that the chip is
configured for proper operation by either the bios or the driver init
process (or in extreme cases module parameter) and should not need to be
changed in runtime. What's more, the format is chip-dependant, and
changing some bits may be extremely sensible (polarity for example).

3* Watch your indentation. In several places you have 8 spaces instead
of a tab (reading the patch is an easy way to catch them). There are
also problem on "goto exit_free" lines.

4* According to out sysfs-interface standard, the alarms file should be
named "alarms", not "alarm".

5* Is it just me or:
+		if (((cur  & 0x00f0) != 0xf && (cur  & 0x00f0) != 0x0)
+		    || ((hyst & 0x00f0) != 0xf && (hyst & 0x00f0) != 0x0)
+		    || ((crit & 0x00f0) != 0xf && (crit & 0x00f0) != 0x0)
+		    || ((min  & 0x00f0) != 0xf && (min  & 0x00f0) != 0x0)
+		    || ((max  & 0x00f0) != 0xf && (max  & 0x00f0) != 0x0))
is broken? I guess you'd need to test != 0xf0, not 0xf.

6* It's a bit weird that you use a wrapper to read from the smbus and
still read the alarm bits directly. I think that your wrapper should
just do its job, ie get the values. The temperature conversions don't
belong there. See how it is done in the other drivers. I admit that your
code works, but it's not consistent.

7* Don't define an ID for the LM77. It's not needed, you can just omit it.

Sorry to insist on things you might consider are details. They certainly
are, but if I don't have you correct them now, chances are that your
patch will not be accepted by kernel folks. It's also important that all
our drivers are as similar as possible for the ease of maintainance.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
