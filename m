From: drewie@freemail.hu (Andras BALI)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: lm77 on national sc1100
Message-Id: <1089228348.4800.37.camel@null>
List-Id: <lm-sensors.vger.kernel.org>
References: <1088690691.2862.25.camel@null>
In-Reply-To: <1088690691.2862.25.camel@null>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2004-07-07 at 14:21, Jean Delvare wrote:

> > Sorry for the late answer, I didn't receive your mail, just found
> > it in the mailing list archive.
[...]
> And I thought "in the worse case he'll get it twice". Looks like I was
> wrong...

Anyway, that's my fault. I know that this free mail server sucks, but
I've been using it for quite a long time now.

> Still your comment "Register values" is now misleading, you should
> consider changing it.

Fixed.

> 1* Alignment. Kernel folks are being a bit strict when it comes to
> alignment. You are not allowed to use spaces to align your defines, nor
> your structure members. I know it's a bit restrictive, but that's the
> way it goes.

Okay, I fired up visible-whitespace-mode in emacs, hope I managed to
nuke all the spaces.

> 2* Do you have a personal need for exporting the configuration register
> to user-space?

No, actually I don't - I just thought that if all the registers are
shown, why skip this? But I admit that it might be dangerous so I
removed it.

> 3* Watch your indentation. In several places you have 8 spaces instead
> of a tab (reading the patch is an easy way to catch them). There are
> also problem on "goto exit_free" lines.

I hope that all of these are fixed, too.

> 4* According to out sysfs-interface standard, the alarms file should be
> named "alarms", not "alarm".

Fixed.

> 5* Is it just me or:
> +		if (((cur  & 0x00f0) != 0xf && (cur  & 0x00f0) != 0x0)
> +		    || ((hyst & 0x00f0) != 0xf && (hyst & 0x00f0) != 0x0)
> +		    || ((crit & 0x00f0) != 0xf && (crit & 0x00f0) != 0x0)
> +		    || ((min  & 0x00f0) != 0xf && (min  & 0x00f0) != 0x0)
> +		    || ((max  & 0x00f0) != 0xf && (max  & 0x00f0) != 0x0))
> is broken? I guess you'd need to test != 0xf0, not 0xf.

Correct. I wonder how I missed that... :P

> 6* It's a bit weird that you use a wrapper to read from the smbus and
> still read the alarm bits directly.

Fixed.

> 7* Don't define an ID for the LM77. It's not needed, you can just omit it.

Actually I had no idea what that ID does, I just saw that the LM75
driver had one and that's why I kept it there. Removed.

> Sorry to insist on things you might consider are details. They certainly
> are, but if I don't have you correct them now, chances are that your
> patch will not be accepted by kernel folks. It's also important that all
> our drivers are as similar as possible for the ease of maintainance.

I understand this and do not underestimate the importance of these
details (and of course I like to read well-aligned code - that's one
thing I learnt from Python :-) ). Thanks again for your time and
support, I hope this time I managed to get it right (well, if not, next
time :)

Thanks,
Andras

-------------- next part --------------
A non-text attachment was scrubbed...
Name: linux-2.6.7-mm6-lm77.patch
Type: text/x-patch
Size: 14939 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040707/a099cdb3/linux-2.6.7-mm6-lm77.bin
