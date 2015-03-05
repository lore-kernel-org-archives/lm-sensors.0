From: Jon Torrey <jonutorrey@gmail.com>
Date: Thu, 05 Mar 2015 17:55:50 +0000
Subject: Re: [lm-sensors] W83627DHG unable to load driver
Message-Id: <CAP1ifEJ383ObYX61bem8L3977FQZt5FUxTw3cyjW-unUuFrNRg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAP1ifE+haCeVp12UPK9kzMeoEV93PgVnFbjoLED2hePgtfg6gg@mail.gmail.com>
In-Reply-To: <CAP1ifE+haCeVp12UPK9kzMeoEV93PgVnFbjoLED2hePgtfg6gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>
> The hardware monitoring function in the chip was not activated
> by the BIOS.


All I can see under Super IO Configuration ( inside the BIOS ) is Serial
Port configuration along with a Parallel Port configuration.
Would this have anything to do with ACPI?  I do see something ISA related
when invoking lspci if that makes any difference?

I have seen this on some Supermicro server boards, where
> hardware monitoring is handled by an IPMI chip.


I have an American Megatrends BIOS for an i7 processor on an embedded
board.  I do not believe it has an IPMI chip.


> Enabling the chip manually from user space is technically possible,

but I would not recommend it


How would I go about doing this?  I ran superiotool and got the following
in return:

 superiotool r6637

Found Winbond W83627HF/F/HG/G (id=0x52, rev=0x41) at 0x2e


On Thu, Mar 5, 2015 at 12:15 PM, Guenter Roeck <linux@roeck-us.net> wrote:

> On Thu, Mar 05, 2015 at 11:48:48AM -0500, Jon Torrey wrote:
> > Hi everyone,
> >
> ...
>
> > modprobe w83627hf returns an error with the following on dmesg | tail -
> >
> > *[ 1056.137920] w83627hf: Base address not set, skipping*
>
> The hardware monitoring function in the chip was not activated
> by the BIOS. Usually that means that nothing useful is connected
> to it. I have seen this on some Supermicro server boards, where
> hardware monitoring is handled by an IPMI chip.
>
> Enabling the chip manually from user space is technically possible,
> but I would not recommend it, and it would likely not help much (most
> likely you would only be able to monitor VBAT and VCC to the chip).
>
> Guenter
>
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
