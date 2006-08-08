From: vsu@altlinux.ru (Sergey Vlasov)
Date: Tue, 08 Aug 2006 15:25:18 +0000
Subject: [lm-sensors] BIOS Corruption (was : new abituguru driver in mm
Message-Id: <20060808152518.GA15178@procyon.home>
List-Id: <lm-sensors.vger.kernel.org>
References: <ce9ef0d90608052222j74e9f6fes40cbc5edf5678577@mail.gmail.com>
In-Reply-To: <ce9ef0d90608052222j74e9f6fes40cbc5edf5678577@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Aug 07, 2006 at 01:53:39PM -0700, Sunil Kumar wrote:
> abituguru_read() calls have timedout on me quite a few times. In fact, that
> was the discussion point in this thread so far. So, that is highly likely
> the reason for this corruption.
> 
> what is the course of action for me here?

Did you try to reset BIOS settings to defaults (first in the BIOS
setup, if that does not help, try the jumper)?

> On 8/7/06, Sergey Vlasov <vsu at altlinux.ru> wrote:
> >
> >On Mon, 7 Aug 2006 09:09:45 -0701 Sunil Kumar wrote:
> >
> >> Yeah, I tried that. Didn't help. I think BIOS reset might help, but I
> >have
> >> to note down some settings before I do that (bigger exercise than just
> >cmos
> >> jumper moves, which in itself involves opening the box....<yawn>). I am
> >able
> >> to read/write all settings except for uguru temp screen. My system
> >functions
> >> without any problems (none that I have noted), except it will not beep
> >or
> >> shutdown if CPU were to become hotter than my tcase of 65C, which is
> >> possible if my cpu fan dies. With the fan working, at full load it stays
> >> around 45-46C.
[skip]
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 191 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060808/68334ab2/attachment.bin 
