From: "Juerg Haefliger" <juergh@gmail.com>
Date: Fri, 16 Nov 2007 16:34:06 +0000
Subject: Re: [lm-sensors] no sensors were detected with Intel Corporation
Message-Id: <191fb4ca0711160834v675114f1g908854464a616e69@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <c8faca170711081606t6acc5928hfdcd9200ba1d421f@mail.gmail.com>
In-Reply-To: <c8faca170711081606t6acc5928hfdcd9200ba1d421f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Kessia,

Please keep the list in the loop for future replies.


> The isadump output is below, but the BIOS info i send later.
>
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 00 00 00 00 00 00 00 0e 00 00 00 00 00 00 00 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 32 01 00 00 00 04 2e 00 00 00 00 00 00 00 00 00
> 30: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  60: 0c 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 ff ff ff ff ff ff
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>

OK, can you now run 'isadump -f 0x0c90'?

...juerg



>
> On Nov 15, 2007 3:04 PM, Juerg Haefliger <juergh@gmail.com> wrote:
> > Hi Kessia,
> >
> >
> > >
> > >
> > > The SpeedFan say me that... I think isnt good. I think was my laptop
> model
> > > very new for support.
> > >
> > >
> > >
> > > ERROR collecting CPU Usage : 1 (Unable to locate the "Processor"
> performance
> > > object)
> > > Win9x:NO 64Bit:NO GiveIO:YES SpeedFan:YES
> > > I/O properly initialized
> > > Linked ISA BUS at $0290
> > > Linked Intel 82801HB ICH8 SMBUS at $10C0
> > > Scanning ISA BUS at $0290...
> > > DELL Support Enabling has been disabled
> > > because SYSTEM CALLS were unsuccessful
> > > Please, report if you think this is an error
> > > Scanning Intel SMBus at $10C0...
> > > End of detection
> > > INFO : NO SUPPORTED CHIP DETECTED
> > >
> >
> > Do you see any voltage/fan information in the BIOS? Can you run
> > 'isadump -k 0x55 0x2e 0x2f' and post the output to the list?
> >
> > ...juerg
> >
> >
> >
> >
> >
> >
>
> --
> Kessia Pinheiro
> Bacharelanda em Ci=EAncia da Computa=E7=E3o
> Universidade Federal da Bahia
> Linux Counter User #389695 [ http://counter.li.org]

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
