From: Reinhard Nissl <rnissl@gmx.de>
Date: Sun, 15 Nov 2009 21:33:59 +0000
Subject: Re: [lm-sensors] ASUS P6T, 2.6.31-14, no pwm devices
Message-Id: <4B0073C7.5030306@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <8c4290000911141138v161593b0u785895e5a7960587@mail.gmail.com>
In-Reply-To: <8c4290000911141138v161593b0u785895e5a7960587@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Am 15.11.2009 22:26, schrieb Jean Delvare:

>> I wonder which sysfs layout is correct as for example coretemp
>> works with gkrellm. coretemp provides its temperatures below
>> /sys/class/hwmon/hwmon1/device/ while ATK0110 provides it below
>> /sys/class/hwmon/hwmon0/.
> 
> Both are correct, libsensors supports both.
> 
>> I would be glad if this could be fixed in the 2.6.31 kernel tree.
> 
> If "sensors" shows things correctly then you can be certain that
> everything is right on the kernel side.

What's the idea behind providing it "here" or(/and) "there"?

Looks like gkrellm doesn't use libsensors so the location matters
until it supports both locations too.

Bye.
-- 
Dipl.-Inform. (FH) Reinhard Nissl
mailto:rnissl@gmx.de

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
