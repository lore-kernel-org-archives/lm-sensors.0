From: devsku@gmail.com (Sunil Kumar)
Date: Fri, 25 Aug 2006 23:13:03 +0000
Subject: [lm-sensors] new abituguru driver in mm kernel
Message-Id: <ce9ef0d90608251613i2b6b7455v38a59499f034f700@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
In-Reply-To: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Has anybody used this driver on x86_64?

Any unexpected surprises?

-Sunil


On 7/31/06, Hans de Goede <j.w.r.degoede at hhs.nl> wrote:
>
> Sunil Kumar wrote:
> > but how do you account for the HZ.
>
> I don't, the system you've been running on has a HZ of 1000 I assume?
> That means that they delays we have found are them minimal ones needed
> to mkae things work, sleeping longer with lower HZ is unfortunate but
> not harmfull. Lower HZ has been taken into account in that we try not to
> sleep much, because otherwise delays for the calling up would become
> unacceptable. But besides that I do not take HZ into account. Remember
> we are dealing with an error / exception path here. It doesn't have to
> be beautifull or very efficient it just has to work and not suck.
>
> > I will give the 1:3 a run.
> >
> Thanks, In combination with a TIMEOUT of 100 I assume?
>
> Regards,
>
> Hans
>
>
>
>
> With msleep(1), one system will sleep
> > for 20ms while other will sleep only 2ms for the last try. We need to
> > either 1. make it msleep(20), so all systems sleep for 20ms per read OR
> > 2. have a conditional based on HZ to do msleep(1) for 100 and do
> > multiple msleep(1) for HZ 1000 OR 3. have it as a configured parameter.
> > 1st option means that 1000HZ folks will suffer delays which they could
> > have avoided because they can sleep finer, but without option 2, they
> > will just sleep for 2ms which may not be sufficient. 2nd and 3rd options
> > work but 3rd works better because its simple and makes a lot of sense
> > for the variety of hardware and BIOSes that you could be dealing with.
> >
> >
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060825/77e43b2b/attachment-0001.html 
