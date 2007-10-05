From: "Yani Ioannou" <yani.ioannou@gmail.com>
Date: Fri, 05 Oct 2007 16:17:26 +0000
Subject: Re: [lm-sensors] ipmisensors almost working...
Message-Id: <253818670710050917u446a41eje91f0900d740a17e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4705ED70.6080206@jordet.net>
In-Reply-To: <4705ED70.6080206@jordet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Stian,

The reason I haven't merged ipmisensors into the kernel yet is this
exactly, on some BMCs the code to convert sensor readings into human
readable forms is just not working - this is practically the only code
left over from bmcsensors  and I began re-writing it a few months ago
but got busy with other stuff. I'd like to start that again though, so
perhaps you could help ne test the new code when it is finished?

There are in fact some sensors we may never be able to convert
completely in the kernel - they require complex transformations
involving logarithms. etc, that kernel code simply can't (and
shouldn't) calculate, so I think the real solution to this will have
to involve userspace support.
For now could you list the results from lmsensors and ipmitool so they
can be compared?

Thanks,
Yani

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
