From: Reinhard Nissl <rnissl@gmx.de>
Date: Sun, 15 Nov 2009 22:08:01 +0000
Subject: Re: [lm-sensors] ASUS P6T, 2.6.31-14, no pwm devices
Message-Id: <4B007BC1.4020806@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <8c4290000911141138v161593b0u785895e5a7960587@mail.gmail.com>
In-Reply-To: <8c4290000911141138v161593b0u785895e5a7960587@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Am 15.11.2009 22:53, schrieb Jean Delvare:

>> Looks like gkrellm doesn't use libsensors so the location matters
>> until it supports both locations too.
> 
> Recent versions of gkrellm (2.3.1 and later) do support libsensors, if
> built properly.

openSUSE 11.2 provides 2.3.1. Changelog says, they upgraded to
2.3.1 about 2 years ago. But ldd /usr/gkrellm doesn't mention
libsensors, although openSUSE 11.2 provides both v3 and v4.

So, looks like poor me is using a gkrellm without libsensors support.

Bye.
-- 
Dipl.-Inform. (FH) Reinhard Nissl
mailto:rnissl@gmx.de

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
