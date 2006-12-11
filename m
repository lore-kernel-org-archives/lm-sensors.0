From: david.c.hubbard@gmail.com (David Hubbard)
Date: Mon, 11 Dec 2006 18:59:17 +0000
Subject: [lm-sensors] Asus P5B Deluxe WiFi AP Sensors
Message-Id: <4dfa50520612111059m52cb75c7xb7284781dc1b9b64@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060822145643.GA5632@seahunt.dyndns.org>
In-Reply-To: <20060822145643.GA5632@seahunt.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello again!

> > - Subscribe to the lm-sensors list
> (http://lists.lm-sensors.org/mailman/listinfo/lm-sensors)
>
> Already done.  :)
>
> > - What hardware monitoring chip do you have on your motherboard?
>
> W83627DHG / ICH8 -- I have the same P5B+WiFi board that's discussed in this
> post:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2006-August/017332.html
>
> > If you have a 627ehf/ehg/dhg jump in with testing the new driver -- and
> there are some bugs I could point you to, also. Or if you have another chip,
> I'm sure it needs development too.
>
> I could try my hand with some 627DHG bugs.  So what's the best way to start?
>  Install 2.6.19 w/ the patch you just sent the other day?
> (w83627ehf_add_w83627dhg_support.patch) ?  I also switched
> up to lm-sensors v2.10.1.

Feel free to install the patch I posted and test it. I have a test
script but I'm waiting for Jean to get back (I believe he's on
vacation for a few weeks) and then I'll send out the patch to everyone
for testing. So yeah, go ahead!

Here is another bug report that you could work on:
http://lists.lm-sensors.org/pipermail/lm-sensors/2006-November/018268.html

(I'll probably get on that one in January, but if you figure it out,
that's great!)

> > - The lm-sensors project also has work, which I'm sure Jean Delvare and
> Rudolf Marek could tell you more about.
>
> I'll work wherever you guys would need me too.  (I'm only finishing my
> dissertation now anyways...)

This is a list of all the active tickets:
http://www.lm-sensors.org/report/1

It's also very useful to just keep up to date on the discussion on the
lm-sensors list. There are lots of useful things to learn by watching
the devel process.

David

