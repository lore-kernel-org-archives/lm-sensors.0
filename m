From: Simon Wilson <simon@simonandkate.net>
Date: Wed, 21 Oct 2009 12:57:54 +0000
Subject: Re: [lm-sensors] Gigabyte GA-P35-DS3P - VID Zero value
Message-Id: <20091021225754.20761kbterh1jhoy@mail.simonandkate.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091019164516.701032uxlen5ai2k@mail.simonandkate.net>
In-Reply-To: <20091019164516.701032uxlen5ai2k@mail.simonandkate.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Jean Delvare <khali@linux-fr.org>:

> First of all, the upper 2 bits are irrelevant as only 6 GPIO3 pins have
> been setup. So the value would be 0x0f. Secondly, decoding VID values
> is somewhat more complex than that. You can look at
> drivers/hwmon/hwmon-vid.c in the kernel source tree [1], or look on the
> Intel developer web site for the VRM/VRD specification which applied to
> your CPU model.
>
> For VRM/VRD 11.0, which your CPU seems to use, 0x0f translates to
> 1.519 V, which is definitely not correct. This leads me to the
> conclusion that this isn't a valid VID value.
>
> Basically, we want to know:
>
> * What are pins 13-14 and 16-19 of the IT8716F connected to on your
>   motherboard: CPU VID or something else.
> * If CPU VID, what's the trick (chip configuration steps) to get the
>   correct value?
>
> What I need is someone who can build kernel modules. It is possible
> that xen will get in our way, and Adam apparently knows more than you
> do about building kernel modules, so I think I will ask for his help.

Sounds like a plan. Thanks Jean.

> You're welcome. It doesn't look like we're progressing much though :/

Ah progress has many definitions. :)

-- 
Simon Wilson
www.simonandkate.net

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
