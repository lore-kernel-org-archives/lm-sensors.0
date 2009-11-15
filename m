From: Reinhard Nissl <rnissl@gmx.de>
Date: Sun, 15 Nov 2009 20:23:10 +0000
Subject: Re: [lm-sensors] ASUS P6T, 2.6.31-14, no pwm devices
Message-Id: <4B00632E.3050002@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <8c4290000911141138v161593b0u785895e5a7960587@mail.gmail.com>
In-Reply-To: <8c4290000911141138v161593b0u785895e5a7960587@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Am 14.11.2009 20:38, schrieb Matt Sheumack:

> Been scanning the recent activity around how 2.6.31 has broken fan
> control on many m/boards, and am hoping to make a contribution so this
> problem can be fixed. Given that my coding skills are limited to Fortran
> 77, best I can do is help with data and test. I've not (yet) enabled the
> "lax" workaround, so I don't know if it works. Happy to follow
> instructions from here to provide H/W input.

I recently upgraded to openSUSE 11.2 which uses kernel 2.6.31.5
looking forward to using the new hwmon driver ATK0110. But
gkrellm doesn't show the sensors, though sensors does, just like
in your report.

I wonder which sysfs layout is correct as for example coretemp
works with gkrellm. coretemp provides its temperatures below
/sys/class/hwmon/hwmon1/device/ while ATK0110 provides it below
/sys/class/hwmon/hwmon0/.

I would be glad if this could be fixed in the 2.6.31 kernel tree.

Bye.
-- 
Dipl.-Inform. (FH) Reinhard Nissl
mailto:rnissl@gmx.de

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
