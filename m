From: david.c.hubbard@gmail.com (David Hubbard)
Date: Wed, 20 Sep 2006 20:46:32 +0000
Subject: [lm-sensors] Asus P5B
Message-Id: <4dfa50520609201346u10f179aay7a53bdeae357c660@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <b62408800609201018k102f2869wa8f97d0c83021fc8@mail.gmail.com>
In-Reply-To: <b62408800609201018k102f2869wa8f97d0c83021fc8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Michael,

> David's driver works very well on my P5B Deluxe WiFi AP.  Unfortunately, I
> can't use it right now.  It is for the 2.6.18 series kernels, and 2.6.18 has
> broken support for the JMicron IDE/SATA controller on my motherboard.  Alan
> Cox's latest patch kills the kernel upon loading, so for right now I'm just
> back to running the stock SuSE 10.1 kernel (2.6.16.something) and living
> without sensors and my DVD.
>
> Life sucks when you are using a MB that is riding the foreskin of technology.
>
> I will revisit 2.6.18 when it's released.
>
> Thanks for your work, David!
>
> Michael

I'd be willing to backport the driver for the 2.6.16 series. It
wouldn't be hard to do, once I have some time to do it. Which version
exactly are you using? I suspect the latest version (2.6.16.29) would
only have a few differences from the 2.6.18 series. If it also worked
for your version, support for 2.6.16 would be easy.

David

