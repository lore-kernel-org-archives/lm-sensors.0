From: david.c.hubbard@gmail.com (David Hubbard)
Date: Mon, 11 Dec 2006 22:16:40 +0000
Subject: [lm-sensors] Asus P5B Deluxe WiFi AP Sensors
Message-Id: <4dfa50520612111416m2cb0b6aat79d0fc0ab7b94054@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060822145643.GA5632@seahunt.dyndns.org>
In-Reply-To: <20060822145643.GA5632@seahunt.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

> All right -- I've applied your patch to kernel 2.6.19, and I'm just
> familiarizing myself with sensors.conf & how my particular board is wired.
> Just to ground myself --- When I run "sensors", I only get two lines of
> output; this is bad, correct?
>
> roo2d2 src # sensors
> w83627dhg-isa-0290
> Adapter: ISA adapter
>
> I'm poking at creating a chip  "w83627dhg-*" section in sensors.conf, but
> the sensors command still does not return any additional output.  Is this
> the right approach?

I'm at work now (and will not be sleeping much in the next few days)
but if you can roust anyone else (maybe Rudolf Marek?) they can walk
you through tweaking sensors.conf.

> Otherwise, I appear to have all the entries under
> /sys/devices/platform/i2c-9191/9191-0290
>   fan[1-5]_*  in[0-8]_*  pwm[1-4]*  temp[123]_*
> and I've already reproduced an earlier observation on this list that
> fan[145] are all controlled via pwm4.

This is good. I'd suggest just running the new module on your system
continuously. Make sure the temperatures, voltages, and fan RPMs read
correctly and don't do anything unexpected. To verify temps, voltages,
and fans are correct, compare them to what's reported in the BIOS.
This is a first step for getting a good sensors.conf anyway.

David

