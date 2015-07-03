From: =?UTF-8?B?6ams6LaF?= <mrs@mail.ustc.edu.cn>
Date: Fri, 03 Jul 2015 06:58:01 +0000
Subject: Re: [lm-sensors] about fan speed problem
Message-Id: <5936cad.127b4.14e52b52905.Coremail.mrs@mail.ustc.edu.cn>
List-Id: <lm-sensors.vger.kernel.org>
References: <6c0eab42.dbdf.14e4c45363a.Coremail.mrs@mail.ustc.edu.cn>
In-Reply-To: <6c0eab42.dbdf.14e4c45363a.Coremail.mrs@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


 
 On 07/03/2015 10:56 AM, Guenter Roeck wrote:
> >
> >
> > Thank you Jean,
> >
> Please don't top-post.
> 
> > Not laptop, here is my hardware info and sensors-detect result, I have changed the old sensors-detect to the latest sensors-detect(Select yes every step), but still only get the cpu temperature.
> >
> > Is there available sensors for my cpu fan?
> >
> 
> Did you try the following ?
> 
> sudo modprobe nct6775

I did not run this command before. After install kernels-devel rpm, run this command successfully, and get all the data I want.

Thank you very much and Best wishes for you.

Chao Ma

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
