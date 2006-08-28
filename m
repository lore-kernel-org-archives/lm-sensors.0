From: juergh@gmail.com (Juerg Haefliger)
Date: Mon, 28 Aug 2006 02:11:40 +0000
Subject: [lm-sensors] [PATCH 1/2 RESEND 2] hwmon: new vt1211 driver
Message-Id: <191fb4ca0608271911l481e8fc3ob8a3f574de83744@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0605311844n3d24f429k8942ffaa15e864a8@mail.gmail.com>
In-Reply-To: <191fb4ca0605311844n3d24f429k8942ffaa15e864a8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> > Wouldn't it be
> > simpler to split up the vt1211_refresh_device function and just read
> > the registers that we're interested in in the individual read
> > callbacks as oposed to calling vt1211_refresh_device and read
> > everything?
>
> Again, there are reasons why we wrote the drivers that way, mind you ;)

I'm certain of that I just wasn't obvious to me, that's why I asked.
Sorry for being such a pain in the but I just wanted to know how and
why things are implemented they way they are :-)
That was my last question, promised :-) Next you'll see an updated
patch that hopefully passes the bar...

...juerg


> First reason, some hardware monitoring chips stop updating when they
> are queried for register values. The idea of the cache was to group all
> bus accesses, and then guarantee a period of tranquility to the chip so
> that it can update the register values with fresh data.
>
> Second reason, if reading from a sysfs file was triggering a physical
> access to the chip unconditionally, it means every user of the system
> could saturate the bus this chip is connected to. With the cache, we
> guarantee this can't happen.
>
> Writing can only be done by root, which is why we are not worried about
> unconditional reads and writes in "set" sysfs callbacks.
>
> Third reason, or rather benefit, is to avoid duplicate reads when a
> register contains more than one "logical value". For example, if a
> register contains the fan clock dividers for all three fans, it's more
> efficient to read it once and cache it, than to read it three times.
>
> --
> Jean Delvare
>

