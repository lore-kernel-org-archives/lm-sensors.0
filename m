From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 24 May 2014 15:17:19 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (nct6683) Fix probe unwind paths to properly unregister platform dev
Message-Id: <CAFRkauB9fbMFXOgLiRvbcGMDKFqatowj1F91Qp9ivwnbuiaBDg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1400898016.10421.1.camel@phoenix>
In-Reply-To: <1400898016.10421.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

2014-05-24 23:08 GMT+08:00 Axel Lin <axel.lin@ingics.com>:
>> Hi Axel,
>>
>> Good catch. Note that nct6775 has the same problem, if you want to tackle
>> the problem there as well.
> I think the nct6775 code is fine, it calls
> platform_device_unregister() in probe error path.
Ooops, sorry.
it looks fine because I modified the code already in my local tree.
will send a fix soon.
>
> Regards,
> Axel

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
