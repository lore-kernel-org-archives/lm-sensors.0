From: devsku@gmail.com (Sunil Kumar)
Date: Thu, 06 Jul 2006 01:09:10 +0000
Subject: [lm-sensors] new abituguru driver in mm kernel
Message-Id: <ce9ef0d90607051809j323c6d80wa4529e3b4b52b97e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
In-Reply-To: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

great!! it works like a charm. Thanks a lot. That saves me the headache of
having ksensors around...:-)

temps are reported as temp1, temp2, temp3 and fans as fan1, fan2 etc. I
think this will go away once gkrellm moves to libsensors.

On 7/5/06, Sunil Kumar <devsku at gmail.com> wrote:
>
> Thanks. I will give it a try and post when I am home.
>
> On 7/5/06, Hans de Goede <j.w.r.degoede at hhs.nl> wrote:
>
> >
>
> Sunil Kumar wrote:
> > Hans,
> >
> > A related question: gkrellm2 ( 2.2.9) refuses to see my sensors as
> reported
> > by abit driver, but its able to see bogus sensors reported by w83627hf
> if I
> > modprobe it.  sensors and ksensors, both see the values correctly.
> >
> > Why would gkrellm not see them? Is there a configuration setting that
> > gkrellm reads which works for w83627hf but not for abituguru.
> >
>
> I became inspired by your mail and have taken a look. I haven't done (I
> haven't even started) a full libsensors implementation yet, but if you
> compile gkrellm with the attached patch it should work fine with the
> uguru and other new drivers which properly represent themselves as
> platform devices.
>
> Regards,
>
> Hans
>
>
>
>
> _______________________________________________
>
> lm-sensors mailing list
> lm-sensors at lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>
>
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060705/18ecebf6/attachment.html 
