From: rickf@ca-flower.com (Rick Flower)
Date: Tue, 14 Jun 2005 20:37:32 +0000
Subject: [lm-sensors] Do my Xeon's have a temp sensor in them?
Message-Id: <Pine.LNX.4.61.0506141133150.3081@srv1.ca-flower.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <42ABD95E.1060205@ca-flower.com>
In-Reply-To: <42ABD95E.1060205@ca-flower.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Rudolf,

Thanks for the reply & suggestions.. I looked into the cpqhealth module 
and beleive it's way too new for my machine.. My machine is circa '99 or 
somewhere around there and so it's not something I can use.  I'll keep 
dicking around with things -- I'm currently playing with the ACPI stuff 
since it appears to show up disabled and am not sure if that has anything 
to do with this issue or not.  Perhaps my machine is just too old for some 
of this fancy shmancy stuff..

-- Rick

On Tue, 14 Jun 2005, Rudolf Marek wrote:

> hello,
>
> It might happen that the sensor is on another bus, or uses some other chips.
> But I think compaq has its own proprietary infrastructure called cpqhealth but I think it is not for 2.6 kernels.
> Please ask them for support, or how to access their chips.
>
> You can also try:
>
> modprobe i2c-piix4
> modprobe i2c-dev
> i2cdetect 0
>
> And send the output to us. It will detect again in "raw" form. But I think there will be nothing.
>
> Regards
>
> Rudolf
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>
>
