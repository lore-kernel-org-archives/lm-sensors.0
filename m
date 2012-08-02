From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 02 Aug 2012 06:18:37 +0000
Subject: Re: [lm-sensors] help with i2cdetect
Message-Id: <20120802081837.7b844c2f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAF+LJYhBpqcps-OYJBVPH22+GpdwfftOt+KszTYGUsKKOKNW-g@mail.gmail.com>
In-Reply-To: <CAF+LJYhBpqcps-OYJBVPH22+GpdwfftOt+KszTYGUsKKOKNW-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 1 Aug 2012 16:10:41 -0700, ed in 92626 wrote:
> When I try i2cdump 0xa8 3 I get
> could not open file /dev/i2c/168.

You passed the parameter in the wrong order, bus number must be first
and slave address second.

> A8 is the address of my DIMM memory module.

Maybe in some document you have, it is, but not for the Linux kernel,
which uses right-aligned 7-bit slave addresses. 0xa8 is obviously a
left-aligned 7-bit address. So the address you actually want to pass to
i2cdump is 0xA8 >> 1 = 0x54.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
