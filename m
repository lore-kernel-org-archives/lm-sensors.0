From: devsku@gmail.com (Sunil Kumar)
Date: Sun, 09 Jul 2006 20:54:37 +0000
Subject: [lm-sensors] new abituguru driver in mm kernel
Message-Id: <ce9ef0d90607091355r3db338ber8b5046877c28423f@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
In-Reply-To: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Why I expect re-compile to work is that I might have done some kernel
rebuild with a newer option (I don't remember if I disabled HIGHPTE before
or after I built abituguru last time) and it is possible that the module
still loads fine but can't really get initialized the first time.

What is the unit for those timeouts you mentioned? In case I need to go
there.

With the recompiled module, I haven't seen it happen it so far after 4
reboots.

This is the advantage of having it in the kernel tree itself. When is it
expected to be in kernel mainline? 2.6.17 series? (I can't run mm for now.)

Thanks a lot,
-Sunil

On 7/9/06, Hans de Goede <j.w.r.degoede at hhs.nl> wrote:
>
>
>
> Sunil Kumar wrote:
> > it is AN8-SLI with BIOS 19.
> Hmm, the uguru on that should have firmware version 2.3.x.x I wouldn't
> expect much trouble with that, maybe my timeouts are just a bit too
> close to the critical limit.
>
> > I have recompiled the module and haven't seen
> > the behaviour so far. I will post once I see the timeout messages and
> > failure during boot again.
> >
>
> I don't expect a recompile to fix it, but if it does thats great. what
> you could try if it comes back is raising (try doubling for starters)
> the following defines:
> First the most likely candidate:
> #define ABIT_UGURU_WAIT_TIMEOUT 250
> No once all the "timeout exceeded waiting for xxxx state" messages are
> gone I would expect the other one: "CMD reg does not hold 0xAC after
> ready command" to also be gone, if its not try raisjng this define:
> #define ABIT_UGURU_READY_TIMEOUT 50
>
> Thanks & Regards,
>
> Hans
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060709/4faea60d/attachment.html 
