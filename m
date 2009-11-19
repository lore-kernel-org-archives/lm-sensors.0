From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 19 Nov 2009 12:17:46 +0000
Subject: Re: [lm-sensors] lm-sensors w83795 chip, I want to help.
Message-Id: <20091119131746.186b1883@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <d08fef840911182007y4793ac72w7c186e774546595b@mail.gmail.com>
In-Reply-To: <d08fef840911182007y4793ac72w7c186e774546595b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 19 Nov 2009 15:07:32 +1100, Nemykal wrote:
> Hello
> I have an asus z8pe-d18 motherboard and according to the asus support site,
> it has this (w83795) hardware monitoring chip in it.
> By googling, I found this thread:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2009-March/025551.html

A candidate driver was posted there, but it was not reviewed and thus
is not merged into the kernel tree yet.

> I am currently on 2.6.32-rc7 sources.
> I'm on Gentoo x86_64
> [I] sys-apps/lm_sensors 3.1.1 is installed [+sensord]
> 
> In that thread you asked for an i2c dump. I'm not sure how to do that.

The driver author already provided a dump of his chip, so I no longer
need anything, thanks.

> (...)
> I want to help get this chip supported, it seems the guy who wrote the
> original driver disappeared.

Wei left Nuvoton a few weeks after posting his driver, yes. His code is
waiting for someone to pick it up and review it. But it's a relatively
large piece of code, so it will probably take time before someone
volunteers. Of course, if one of the lm-sensors developers had such a
chip on their motherboard, things would be different...

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
