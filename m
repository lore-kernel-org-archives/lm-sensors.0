From: devsku@gmail.com (Sunil Kumar)
Date: Thu, 20 Jul 2006 17:13:46 +0000
Subject: [lm-sensors] new abituguru driver in mm kernel
Message-Id: <ce9ef0d90607201013i75e2db84y7403de34f44594a8@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
In-Reply-To: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hold on to this patch please, because I just saw two messages appear again
after two hours of uptime after resume. This hasn't happened in my previous
tests where machine was up even longer. I think there is more to it than
just sleeping a few milliseconds. It may very well be an issue with my
particular board.

On 7/20/06, Sunil Kumar <devsku at gmail.com> wrote:
>
> I had been getting the problem on a clean boot as well as after a
> suspend/resume cycle. I have now tested it with both reboots and
> suspend/resume cycles multiple times and it seems to work. I agree that the
> worst case delay of 38*50~ 00 msec is big but I don't think we will hit
> that.
>
> anyway, I will give the attached a run and let you know.
>
> Thanks,
> Sunil
>
>
>
> On 7/20/06, Hans de Goede < j.w.r.degoede at hhs.nl> wrote:
> >
> >
> >
> > Sunil Kumar wrote:
> > > Ok, this patch seems to have made the messages go away for good (even
> > with
> > > suspend/resume cycle). Because this patch helps fix it, I suspect that
> > > its a
> > > race between setting the ready state and doing a read because the
> > while
> > > loop
> > > executes really fast and the hardware is not really that fast to
> > respond
> > > when you expect it in ABIT_UGURU_STATUS_READ state in the
> > abituguru_read
> > > call.
> > >
> >
> > Hi,
> >
> > 1) Thanks for all the testing and the patch
> > 2) The while loop speed is not as fast as you think, since the while
> >    test condition contains a inb_p which will do 2 isa reads, thus the
> >    while loops speed is ISA bus bound, not CPU bound.
> > 3) Normally I would object against the sleeping in the while since in
> >    the normal (no suspend problem) case, the loops are intented to
> >    execute pretty fast. In abituguru_update_device 38 read operations
> >    are done, if every read op is going to take milliseconds this will
> >    cause noticable stalls in sensors using applications.
> > 4) However the 2 places where you've inserted the sleep are places where
> >
> >    normally the code succeeds on the first read (so it never enters the
> >    while and thus never sleeps) the whole reason for the while was to
> >    try to fix the problem you're experiencing and you've fixed the fix,
> >    thanks!
> >
> > So the fix is most definitly going in, thanks! Could you try the
> > attached version? I've also modified the suspend / resume code so that
> > it no longer unconditionally marks the uguru not_ready as that seemed to
> >
> > make things worse, instead it now checks the uguru status and sets the
> > ready flag depending on the status.
> >
> > Thanks,
> >
> > Hans
> >
> >
> >
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060720/4d07214e/attachment.html 
