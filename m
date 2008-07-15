From: Stian Jordet <liste@jordet.net>
Date: Tue, 15 Jul 2008 11:58:10 +0000
Subject: Re: [lm-sensors] ipmisensors almost working...
Message-Id: <487C90D2.8090808@jordet.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4705ED70.6080206@jordet.net>
In-Reply-To: <4705ED70.6080206@jordet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Yani Ioannou skrev:
> Hi Stian,
>
> The reason I haven't merged ipmisensors into the kernel yet is this
> exactly, on some BMCs the code to convert sensor readings into human
> readable forms is just not working - this is practically the only code
> left over from bmcsensors  and I began re-writing it a few months ago
> but got busy with other stuff. I'd like to start that again though, so
> perhaps you could help ne test the new code when it is finished?
>
> There are in fact some sensors we may never be able to convert
> completely in the kernel - they require complex transformations
> involving logarithms. etc, that kernel code simply can't (and
> shouldn't) calculate, so I think the real solution to this will have
> to involve userspace support.
> For now could you list the results from lmsensors and ipmitool so they
> can be compared?
>   
Hi, Yani.

I guess you have given up/lost interest in this project. But I still 
wanted to give it a shot and hear if you were planning trying to make it 
work one last time ;)

Have a nice summer!

Regards,
Stian

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
