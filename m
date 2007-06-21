From: Luca <kronos.it@gmail.com>
Date: Thu, 21 Jun 2007 19:33:02 +0000
Subject: Re: [lm-sensors] [RFC] ACPI based hwmon driver for ASUS
Message-Id: <68676e00706211233l7fa22ef6m891e61b831de2f02@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070513223329.GA29207@dreamland.darkstar.lan>
	 <46520F36.4080006@assembler.cz>
	 <68676e00705211453n69de6868lc5da2cad64f65699@mail.gmail.com>
	 <46528B6F.3050701@assembler.cz>
	 <20070602222829.GA11893@dreamland.darkstar.lan>
	 <467AC84A.303@assembler.cz>
In-Reply-To: <467AC84A.303@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rudolf Marek <r.marek@assembler.cz>
Cc: lm-sensors@lm-sensors.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 6/21/07, Rudolf Marek <r.marek@assembler.cz> wrote:
> > Ok, it makes sense :)
> >
> > Name (FBUF, Package (0x06)
> > {
> >     0x03,
> >     CPUF,
> >     CHAF,
> >     PWRF,
> >     CHPF,
> >     CH2F
> > })
> >
> > Clearly the first number is not the number of available readings (though
> > it matches the count in the other DSDTs I've seen); don't know what it
> > is :|
>
> Maybe study the Pro2.dll from Asus Probe II?

Done that ;-) Disassembling is quite painful though, and most of the
work is performed by a kernel driver which I find a bit difficult to
decode.

Will fix the other issues and resend.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
