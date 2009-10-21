From: Simon Wilson <simon@simonandkate.net>
Date: Wed, 21 Oct 2009 12:15:34 +0000
Subject: Re: [lm-sensors] Gigabyte GA-P35-DS3P - VID Zero value
Message-Id: <20091021221534.76963ezi3qng6546@mail.simonandkate.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091019164516.701032uxlen5ai2k@mail.simonandkate.net>
In-Reply-To: <20091019164516.701032uxlen5ai2k@mail.simonandkate.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Jean Delvare <khali@linux-fr.org>:

> Hi Simon,
>
>
> The raw VID value is at 0xfc, value is 0x3f, which means all VID pins
> are high. Which means they are not wired to the CPU, otherwise at least
> one of them would be low.
>
> Now, looking at register 0x27, it appears that all VID input pins have
> been configured for their alternative function (GPIO.) This is not the
> default value for this register, which means that the motherboard
> vendor decided to not use these pins for VID input but for another
> function.
>
> BTW... the pins in question are in input mode. So who knows... maybe
> they ARE used for VID monitoring, and GPIO was preferred over true VID
> for obscure reasons (incompatible voltage levels?) You may want to run,
> as root:
>
> isadump -f 0x800 16

WARNING! Running this program can cause system crashes, data loss and worse!
I will probe address range 0x800 to 0x80f.
Continue? [Y/n] y
        0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
0800: ff 21 cf fa f5 07 ff ff ff ff ff ff ff ff ff ff

>
> and see if the 3rd value would make sense as a VID value for your CPU.

Does it? CF hex = 207 dec... surely not 2.07V?!? According to Intel  
the e6850 should have a VID of 1.3 or 1.35V.

>
> Ask the manufacturer to confirm this, and if they do, blame it on them.

I can ask them in my IT job capacity - they may help... can you help  
me with the gist of what I need to ask them? :)

>
> One thing we could do is teach the it87 driver to not export the VID
> value if any of VID pins 0-3 are configured for GPIO function. That
> wouldn't be too difficult, but would you be able to test a kernel patch?
>

Happy to help - as long as you provide idiot-proof instructions LOL...  
the closest I've ever got to kernel stuff I've ever done is loading  
the kmod drivers, which isn't exactly difficult. Bear in mind I'm  
running a xen kernel:

2.6.18-164.el5xen

I "believe" that in0 actually provides a VCore reading on this setup  
anyway - it varies between 1.04V and 1.2V, which would seem to me to  
be about right. Unless I'm off on the wrong track there too and that  
needs a modifying calcluation for something else.

Thanks for your help Jean, much appreciated. It's not critical, but I  
like having things finished and working well.

Simon
-- 
Simon Wilson
www.simonandkate.net

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
