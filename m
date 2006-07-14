From: devsku@gmail.com (Sunil Kumar)
Date: Fri, 14 Jul 2006 19:33:13 +0000
Subject: [lm-sensors] new abituguru driver in mm kernel
Message-Id: <ce9ef0d90607141233s739ddbcdv13d02ec4f90cd0bc@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
In-Reply-To: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

you mean the hardware itself is not in the right state? Or its in the right
state but not in the state that you expect to be the right state? I am
confused I guess because suspending to disk should be like a shutdown to the
hardware. suspend to RAM might be a different beast because of BIOS
involvement.

On 7/14/06, Hans de Goede <j.w.r.degoede at hhs.nl> wrote:
>
>
>
> Sunil Kumar wrote:
> > bad news: module re-compile is not the issue. The problem came back.
> >
> > And this time I know why. This problem happens when I stop sensors,
> rmmod
> > the module, suspend2 to disk, resume from the swap image and modprobe
> the
> > module. After sometime, these messages start appearing in the log.
> >
> > Is there anything that you want me to enable for debugging purposes, so
> > that
> > we can capture more information when it happens next time? I can almost
> > always reproduce it with suspend resume cycle.
> >
>
> Hmm,
>
> After suspend/resume does it happen just once/twice, or does it happen
> regulary after suspend / resume.
>
> My current guess is that the uguru is no longer in what Olle and I have
> named "ready" state after a suspend / resume. If that is the problem
> then I need to find out howto add a suspend/resume handler to the driver
> and on resume mark the uguru as not ready (1 line of code in the handler
> :), then the driver will force it into ready state before trying to talk
> to it.
>
> Regards,
>
> Hans
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060714/89dbb825/attachment.html 
