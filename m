From: devsku@gmail.com (Sunil Kumar)
Date: Sun, 09 Jul 2006 16:41:41 +0000
Subject: [lm-sensors] new abituguru driver in mm kernel
Message-Id: <ce9ef0d90607090942p55042f12wf851672bb1c5bf16@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
In-Reply-To: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ok, now another problem. Some of the times the module loads fine during
bootup but sensors reports that

$ sensors
Can't access procfs/sysfs file
Unable to find i2c bus information;
For 2.6 kernels, make sure you have mounted sysfs and libsensors
was compiled with sysfs support!
For older kernels, make sure you have done 'modprobe i2c-proc'!

If I rmmod abituguru and modprobe it again, it works. I will rebuild the
module and see if it helps.

The fallout of this is that gkrellm forgets about my sensors permanently. I
have to re-enable them and re-assign the labels etc....:(

Thanks,
-Sunil

On 7/9/06, Sunil Kumar < devsku at gmail.com> wrote:
>
> they always occurr in a bunch but they are scattered all over time,
> sometimes disappearing for many hours and then returning.
>
>
> On 7/9/06, Hans de Goede < j.w.r.degoede at hhs.nl> wrote:
> >
> >
> >
> > Sunil Kumar wrote:
> > > Hi Hans,
> > >
> > > I am seeing these messages in the dmesg:
> > >
> > > abituguru: timeout exceeded waiting for ready state
> > > abituguru: timeout exceeded waiting for ready state
> > > abituguru: timeout exceeded waiting for read state (bank: 34, sensor:
> > 15)
> > > abituguru: CMD reg does not hold 0xAC after ready command
> > > abituguru: timeout exceeded waiting for read state (bank: 38, sensor:
> > 2)
> > > abituguru: timeout exceeded waiting for ready state
> > >
> >
> > Hmm, were these messages close together in time, or now and then a
> > message?
> >
> > > I am not sure if they are related to a freeze I saw today. My machine
> > > wasn't
> > > being used and when I came back, it was frozen.
> >
> > I seriously doubt the freeze and these messages are related. The uGuru
> > only uses 2 io ports todo all communication with the outside. So reading
> >
> > the ports doesn't always get you the same register there is a sortoff
> > network protocol which you speak over the ports. These messages mean
> > that the uGuru failed to response within a reasonable time. Unfortunate
> > on some uGuru's this is quite normal. It seems the older the
> > Motherboard, the more often this happens (iow the buggier the uGuru
> > firmware).
> >
> > Regards,
> >
> > Hans
> >
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060709/b8fd318d/attachment.html 
