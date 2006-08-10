From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Thu, 10 Aug 2006 11:57:01 +0000
Subject: [lm-sensors] BIOS Corruption (was : new abituguru driver in mm
Message-Id: <44DB1F0D.7020705@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <ce9ef0d90608052222j74e9f6fes40cbc5edf5678577@mail.gmail.com>
In-Reply-To: <ce9ef0d90608052222j74e9f6fes40cbc5edf5678577@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Sunil Kumar wrote:
> ok, loading the patched abituguru didn't help the BIOS hang, its more than
> those bits and BIOS may be really buggy. I finally noted down all the
> custom
> changes to the BIOS settings (actually quite a few, it turned out) and
> did a
> 'load optimised defaults'. That helped clear up the hung screen in BIOS.
> 
> I am back to my original settings and things look good right now.
> 

Good, so you didn't have to open your PC and use the CMOS reset jumper,
I'm glad to hear that, that makes this bug much less severe IMHO.

> One thing I noted is that earlier 'modprobe abituguru' used to take about
> 560ms and now it takes almost twice that. As I suggested earlier, can we
> please use msleep(0) instead of msleep(1). msleep(0) is a 1 jiffy sleep (1
> ms for HZ 1000) while msleep(1) is twice that.

I must have missed your request for this change earlier, sleeping 1
jiffy is what I had in mind. So I've changed this. Here is my latest
version:

-Change msleep(1) to msleep(0) for shorter sleeps.
-Remove the masking out of invalid setting bits after successfull sensor
 type detection, this didn't help the BIOS confusion, so its useless and
 it could have unforseen unwanted side effects.


I'll send an official patch to the list soon to upgrade the in kernel
version to this too, so that others can benefit from your improved
timeout code, and more important so that the error paths in the sensor
type detect code are fixed to always restore the original settings!

Regards,

Hans
-------------- next part --------------
A non-text attachment was scrubbed...
Name: abituguru.c
Type: text/x-csrc
Size: 52142 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060810/218f2abf/attachment-0001.bin 
