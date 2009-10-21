From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 21 Oct 2009 12:53:19 +0000
Subject: Re: [lm-sensors] Gigabyte GA-P35-DS3P - VID Zero value
Message-Id: <20091021145319.78497a1d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091019164516.701032uxlen5ai2k@mail.simonandkate.net>
In-Reply-To: <20091019164516.701032uxlen5ai2k@mail.simonandkate.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 20 Oct 2009 21:50:31 +1000, Adam Nielsen wrote:
> > The raw VID value is at 0xfc, value is 0x3f, which means all VID pins
> > are high. Which means they are not wired to the CPU, otherwise at least
> > one of them would be low.
> > 
> > Now, looking at register 0x27, it appears that all VID input pins have
> > been configured for their alternative function (GPIO.) This is not the
> > default value for this register, which means that the motherboard
> > vendor decided to not use these pins for VID input but for another
> > function.
> > 
> > BTW... the pins in question are in input mode. So who knows... maybe
> > they ARE used for VID monitoring, and GPIO was preferred over true VID
> > for obscure reasons (incompatible voltage levels?) You may want to run,
> > as root:
> > 
> > isadump -f 0x800 16
> > 
> > and see if the 3rd value would make sense as a VID value for your CPU.
> 
> Ah interesting.  It doesn't seem to for me though:
> 
>        0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 0800: ff 01 cf fa f7 07 ff ff ff ff ff ff ff ff ff ff
> 
> VRM v11 (in hwmon-vid) says values can't be > 0xb2, although I don't know how
> many bits are wired up to the VID.
> 
> So is 0x802 the GPIO input?  I wonder what it's wired up to...?

See my answer to Simon. 6 VID bits -> 0x0f -> 1.519 V -> definitely not
the right voltage for your CPU. Dead end.

> > One thing we could do is teach the it87 driver to not export the VID
> > value if any of VID pins 0-3 are configured for GPIO function. That
> > wouldn't be too difficult, but would you be able to test a kernel patch?
> 
> I can test an it87 patch if you need a guinea pig - especially if it'll
> compile against 2.6.30 so I don't have to reboot ;-)

I'll prepare a patch as my time and health permits.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
