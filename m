From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 21 Oct 2009 12:51:29 +0000
Subject: Re: [lm-sensors] Gigabyte GA-P35-DS3P - VID Zero value
Message-Id: <20091021145129.26885bfc@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091019164516.701032uxlen5ai2k@mail.simonandkate.net>
In-Reply-To: <20091019164516.701032uxlen5ai2k@mail.simonandkate.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Simon,

On Wed, 21 Oct 2009 22:15:34 +1000, Simon Wilson wrote:
> Quoting Jean Delvare <khali@linux-fr.org>:
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
> 
> WARNING! Running this program can cause system crashes, data loss and worse!
> I will probe address range 0x800 to 0x80f.
> Continue? [Y/n] y
>         0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 0800: ff 21 cf fa f5 07 ff ff ff ff ff ff ff ff ff ff
> 
> >
> > and see if the 3rd value would make sense as a VID value for your CPU.
> 
> Does it? CF hex = 207 dec... surely not 2.07V?!? According to Intel  
> the e6850 should have a VID of 1.3 or 1.35V.

First of all, the upper 2 bits are irrelevant as only 6 GPIO3 pins have
been setup. So the value would be 0x0f. Secondly, decoding VID values
is somewhat more complex than that. You can look at
drivers/hwmon/hwmon-vid.c in the kernel source tree [1], or look on the
Intel developer web site for the VRM/VRD specification which applied to
your CPU model.

For VRM/VRD 11.0, which your CPU seems to use, 0x0f translates to
1.519 V, which is definitely not correct. This leads me to the
conclusion that this isn't a valid VID value.

> > Ask the manufacturer to confirm this, and if they do, blame it on them.
> 
> I can ask them in my IT job capacity - they may help... can you help  
> me with the gist of what I need to ask them? :)

Basically, we want to know:

* What are pins 13-14 and 16-19 of the IT8716F connected to on your
  motherboard: CPU VID or something else.
* If CPU VID, what's the trick (chip configuration steps) to get the
  correct value?

> > One thing we could do is teach the it87 driver to not export the VID
> > value if any of VID pins 0-3 are configured for GPIO function. That
> > wouldn't be too difficult, but would you be able to test a kernel patch?
> 
> Happy to help - as long as you provide idiot-proof instructions LOL...  
> the closest I've ever got to kernel stuff I've ever done is loading  
> the kmod drivers, which isn't exactly difficult. Bear in mind I'm  
> running a xen kernel:
> 
> 2.6.18-164.el5xen
> 
> I "believe" that in0 actually provides a VCore reading on this setup  
> anyway - it varies between 1.04V and 1.2V, which would seem to me to  
> be about right. Unless I'm off on the wrong track there too and that  
> needs a modifying calcluation for something else.

What I need is someone who can build kernel modules. It is possible
that xen will get in our way, and Adam apparently knows more than you
do about building kernel modules, so I think I will ask for his help.

> Thanks for your help Jean, much appreciated. It's not critical, but I  
> like having things finished and working well.

You're welcome. It doesn't look like we're progressing much though :/

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
