From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 05 Mar 2015 17:15:20 +0000
Subject: Re: [lm-sensors] W83627DHG unable to load driver
Message-Id: <20150305171520.GA23072@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAP1ifE+haCeVp12UPK9kzMeoEV93PgVnFbjoLED2hePgtfg6gg@mail.gmail.com>
In-Reply-To: <CAP1ifE+haCeVp12UPK9kzMeoEV93PgVnFbjoLED2hePgtfg6gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Mar 05, 2015 at 11:48:48AM -0500, Jon Torrey wrote:
> Hi everyone,
> 
...

> modprobe w83627hf returns an error with the following on dmesg | tail -
> 
> *[ 1056.137920] w83627hf: Base address not set, skipping*

The hardware monitoring function in the chip was not activated
by the BIOS. Usually that means that nothing useful is connected
to it. I have seen this on some Supermicro server boards, where
hardware monitoring is handled by an IPMI chip.

Enabling the chip manually from user space is technically possible,
but I would not recommend it, and it would likely not help much (most
likely you would only be able to monitor VBAT and VCC to the chip).

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
