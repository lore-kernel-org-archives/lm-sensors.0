From: devsku@gmail.com (Sunil Kumar)
Date: Sat, 15 Jul 2006 00:52:59 +0000
Subject: [lm-sensors] new abituguru driver in mm kernel
Message-Id: <ce9ef0d90607141753u3d0c61eag2d64341a9ca9fbe0@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
In-Reply-To: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

You are right. The messages happen to be much more sparse. After recent
resume, I have only seen one:

abituguru: timeout exceeded waiting for read state (bank: 33, sensor: 9)

Last time I saw after a resume:

Jul 10 21:25:10 localhost abituguru: timeout exceeded waiting for read state
(bank: 34, sensor: 12)
Jul 10 21:25:10 localhost abituguru: timeout exceeded waiting for ready
state
Jul 10 21:25:20 localhost abituguru: timeout exceeded waiting for read state
(bank: 34, sensor: 15)
Jul 10 21:25:20 localhost abituguru: timeout exceeded waiting for ready
state
Jul 10 21:27:10 localhost abituguru: timeout exceeded waiting for ready
state
Jul 10 21:27:10 localhost abituguru: timeout exceeded waiting for ready
state

-Sunil

On 7/14/06, Hans de Goede <j.w.r.degoede at hhs.nl> wrote:
>
>
>
> Sunil Kumar wrote:
> > you mean the hardware itself is not in the right state? Or its in the
> right
> > state but not in the state that you expect to be the right state? I am
> > confused I guess because suspending to disk should be like a shutdown to
> > the
> > hardware. suspend to RAM might be a different beast because of BIOS
> > involvement.
> >
>
> The problem is that my driver currently does not take the option of
> suspendin (in anyway) into account. When the driver loads it puts the
> hardware in the "ready" state and whenever it does something with the
> hardware (making it not ready) it puts it back in the ready state when
> its done. So the driver expects the hardware to be in the ready state
> when it next tries to read from the hardware. However due to the
> suspend/resume cycly the hardware is most likely no longer in the ready
> state. My driver should be able to recover from this but complains that
> things did not go as expected. Hence my question:
>
> >> After suspend/resume does it happen just once/twice, or does it happen
> >> regulary after suspend / resume.
>
> Because if it only happens once or twice after a single suspend/restore
> then my theory is most likely correct and then I'll try to fix my
> driver. If it happens many times after a single suspend/resume it might
> very well be something else.
>
> Regards,
>
> Hans
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060714/9d03d6b5/attachment.html 
