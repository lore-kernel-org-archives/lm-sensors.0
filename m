From: "Juerg Haefliger" <juergh@gmail.com>
Date: Wed, 28 Nov 2007 23:57:15 +0000
Subject: Re: [lm-sensors] no sensors were detected with Intel Corporation
Message-Id: <191fb4ca0711281557l2df74307y7a33ba3de2bbf0d5@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <c8faca170711081606t6acc5928hfdcd9200ba1d421f@mail.gmail.com>
In-Reply-To: <c8faca170711081606t6acc5928hfdcd9200ba1d421f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,


On Nov 27, 2007 12:45 PM, Jean Delvare <khali@linux-fr.org> wrote:
> On Tue, 27 Nov 2007 18:11:07 -0200, Kessia Pinheiro wrote:
> > The output:
> >
> > # isadump -k 0x55 0x2e 0x2f 0x9
> > WARNING! Running this program can cause system crashes, data loss and worse!
> > I will probe address register 0x2e and data register 0x2f.
> > Probing bank 9 using bank register 0x07.
> > Continue? [Y/n]
> >   0 1 2 3 4 5 6 7 8 9 a b c d e f
> > 00: 00 00 00 00 00 00 00 09 00 00 00 00 00 00 00 00
> > 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 20: 32 01 00 00 00 04 2e 00 00 00 00 00 00 00 00 00
> > 30: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 60: 09 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > a0: 00 00 00 00 00 00 00 00 00 00 ff ff ff ff ff ff
> > b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>
> We already have a dump for 0x910 from one of your previous post, and no
> hardware monitoring device there either.

We do? He gave us a dump for 0xc90 but I haven't seen anything for 0x910.
Kessia, can you please run 'isadump -f 0x910'?

...juerg


> My conclusion is that you do not have a hardware monitoring chip, which
> is rather common for laptops anyway, so no real surprise. Just use
> "acpi -t" to get your system temperature.
>
> Either that, or the ICH8 integrated sensors are used. But we don't
> support them at the moment.
>
>
> --
> Jean Delvare
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
