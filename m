From: Helmut Grohne <helmut@subdivi.de>
Date: Wed, 12 Mar 2008 10:52:18 +0000
Subject: Re: [lm-sensors] serious w83627ehf problem stopping cpu fan
Message-Id: <20080312105218.GA18748@alf.mars>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080312011430.GA20751@alf.mars>
In-Reply-To: <20080312011430.GA20751@alf.mars>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

thanks for your reply and your help!

> What motherboard it is? Asus A8V-E SE? Can you please send dsdt table her=
e?

The mainboard is labeled A8V-E and the box it came in is labeled A8V-E SE.

> cd /tmp
> cat /proc/acpi/dsdt  >dsdt.bin
> iasl -d dsdt.bin

Unfortunately there is no /proc/acpi/dsdt on my system. Can you tell me
what is missing? A kernel option?

> If you go to BIOS, is Q-fan enabled? What is your settings there?

Yes I know that Q-fan is enabled. A (more hardware savvy) friend of mine
configured this. The target temperature is 40=B0C with a tolerance of 3=B0C.
A setting I do not understand is called "fan duty cycle" and is set to
11/16.

My fan used to spin between 3000 and 5000 rpm. However the system
somewhen[1] stopped doing so and now merely sits on about 3500 however
hot the cpu is. This is also bad, because I cannot run the system at
full speed with work for a longer time.

Helmut

[1] Kernels I used: 2.6.18, since March 2007 2.6.20.1, since January
    2.6.23.14. According to munin graphs the system stopped spinning
    higher than 4000 rpm around September.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
