From: devsku@gmail.com (Sunil Kumar)
Date: Tue, 11 Jul 2006 04:43:35 +0000
Subject: [lm-sensors] new abituguru driver in mm kernel
Message-Id: <ce9ef0d90607102143s396f9a08pa14b85e56e8b9007@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
In-Reply-To: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

bad news: module re-compile is not the issue. The problem came back.

And this time I know why. This problem happens when I stop sensors, rmmod
the module, suspend2 to disk, resume from the swap image and modprobe the
module. After sometime, these messages start appearing in the log.

Is there anything that you want me to enable for debugging purposes, so that
we can capture more information when it happens next time? I can almost
always reproduce it with suspend resume cycle.

On 7/9/06, Hans de Goede <j.w.r.degoede at hhs.nl> wrote:
>
>
>
> Sunil Kumar wrote:
> > Why I expect re-compile to work is that I might have done some kernel
> > rebuild with a newer option (I don't remember if I disabled HIGHPTE
> > before or after I built abituguru last time) and it is possible that the
> > module still loads fine but can't really get initialized the first time.
> >
>
> Ah I see.
>
> > What is the unit for those timeouts you mentioned? In case I need to go
> > there.
> >
> Number of attempted ISA reads while waiting for a certain response
> before giving up.
>
> > This is the advantage of having it in the kernel tree itself. When is it
> > expected to be in kernel mainline? 2.6.17 series? (I can't run mm for
> now.)
> >
>
> Its in 2.2.18rc1
>
> Regards,
>
> Hans
>
>
> p.s
>
> Everyone I'm going on a short vacation till friday so don't expect any
> response /replies from me till saturday.
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060710/6326e2f4/attachment.html 
