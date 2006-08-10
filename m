From: devsku@gmail.com (Sunil Kumar)
Date: Thu, 10 Aug 2006 15:48:14 +0000
Subject: [lm-sensors] BIOS Corruption (was : new abituguru driver in mm
Message-Id: <ce9ef0d90608100848m36e640e9uff70947e0d19ef18@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ce9ef0d90608052222j74e9f6fes40cbc5edf5678577@mail.gmail.com>
In-Reply-To: <ce9ef0d90608052222j74e9f6fes40cbc5edf5678577@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I am happy to report that after 24 hours uptime, I haven't seen any timeouts
(or corruption ...;-)). So, it looks like we are all good.

Thanks, Hans.
-Sunil

On 8/10/06, Hans de Goede <j.w.r.degoede at hhs.nl> wrote:
>
>
>
> Sunil Kumar wrote:
> > ok, loading the patched abituguru didn't help the BIOS hang, its more
> than
> > those bits and BIOS may be really buggy. I finally noted down all the
> > custom
> > changes to the BIOS settings (actually quite a few, it turned out) and
> > did a
> > 'load optimised defaults'. That helped clear up the hung screen in BIOS.
> >
> > I am back to my original settings and things look good right now.
> >
>
> Good, so you didn't have to open your PC and use the CMOS reset jumper,
> I'm glad to hear that, that makes this bug much less severe IMHO.
>
> > One thing I noted is that earlier 'modprobe abituguru' used to take
> about
> > 560ms and now it takes almost twice that. As I suggested earlier, can we
> > please use msleep(0) instead of msleep(1). msleep(0) is a 1 jiffy sleep
> (1
> > ms for HZ 1000) while msleep(1) is twice that.
>
> I must have missed your request for this change earlier, sleeping 1
> jiffy is what I had in mind. So I've changed this. Here is my latest
> version:
>
> -Change msleep(1) to msleep(0) for shorter sleeps.
> -Remove the masking out of invalid setting bits after successfull sensor
> type detection, this didn't help the BIOS confusion, so its useless and
> it could have unforseen unwanted side effects.
>
>
> I'll send an official patch to the list soon to upgrade the in kernel
> version to this too, so that others can benefit from your improved
> timeout code, and more important so that the error paths in the sensor
> type detect code are fixed to always restore the original settings!
>
> Regards,
>
> Hans
>
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060810/f992f2b1/attachment-0001.html 
