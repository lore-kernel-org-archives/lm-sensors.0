From: david@ad5ey.net (David Holl)
Date: Mon, 11 Dec 2006 22:10:33 +0000
Subject: [lm-sensors] Asus P5B Deluxe WiFi AP Sensors
Message-Id: <6b59d5890612111410l7e7848f6gbf55f1c0c0506346@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060822145643.GA5632@seahunt.dyndns.org>
In-Reply-To: <20060822145643.GA5632@seahunt.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>
> Feel free to install the patch I posted and test it. I have a test script
> but I'm waiting for Jean to get back (I believe he's on vacation for a few
> weeks) and then I'll send out the patch to everyone for testing. So yeah, go
> ahead!


All right -- I've applied your patch to kernel 2.6.19, and I'm just
familiarizing myself with sensors.conf & how my particular board is wired.
Just to ground myself --- When I run "sensors", I only get two lines of
output; this is bad, correct?

roo2d2 src # sensors
w83627dhg-isa-0290
Adapter: ISA adapter

I'm poking at creating a chip  "w83627dhg-*" section in sensors.conf, but
the sensors command still does not return any additional output.  Is this
the right approach?

Otherwise, I appear to have all the entries under
/sys/devices/platform/i2c-9191/9191-0290
  fan[1-5]_*  in[0-8]_*  pwm[1-4]*  temp[123]_*
and I've already reproduced an earlier observation on this list that
fan[145] are all controlled via pwm4.

Here is another bug report that you could work on:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2006-November/018268.html
>
> (I'll probably get on that one in January, but if you figure it out,
> that's great!)

This is a list of all the active tickets: http://www.lm-sensors.org/report/1
>
> It's also very useful to just keep up to date on the discussion on the
> lm-sensors list. There are lots of useful things to learn by watching the
> devel process.


Nifty -- I'll keep an eye out for anything I could help with.

- David
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061211/f15b1776/attachment.html 
