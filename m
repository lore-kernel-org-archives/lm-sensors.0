From: devsku@gmail.com (Sunil Kumar)
Date: Wed, 05 Jul 2006 16:35:51 +0000
Subject: [lm-sensors] new abituguru driver in mm kernel
Message-Id: <ce9ef0d90607050935q3019a67bo8b7458c4f8c8be07@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
In-Reply-To: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hans,

A related question: gkrellm2 (2.2.9) refuses to see my sensors as reported
by abit driver, but its able to see bogus sensors reported by w83627hf if I
modprobe it.  sensors and ksensors, both see the values correctly.

Why would gkrellm not see them? Is there a configuration setting that
gkrellm reads which works for w83627hf but not for abituguru.

Thanks,
Sunil


On 7/4/06, Hans de Goede <j.w.r.degoede at hhs.nl> wrote:
>
> Sunil Kumar wrote:
> > I actually found that thread after posting here. I am devsk there. So,
> > is there going to be standalone tar release of version 1.1.10? I have
> > AN8-SLI and 1.1.8 is working fine with patch to lm_sensors-2.10.0
> > package. I am also wondering if I really need to go to 1.1.10?
> >
>
> I'm not planning on doing a stand alone release of 1.1.10 as you say
> 1.1.8 works fine for you and so it does for most others. If the need
> arises I may do a stand alone release. But the whole idea is to have
> this driver in the kernel and for the kernel to be _the_ place where
> development happens. So things are actually going as planned, with 1.1.8
> being the last standalone release.
>
> Regards,
>
> Hans
>
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors at lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060705/d206aed9/attachment.html 
