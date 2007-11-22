From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 22 Nov 2007 20:18:04 +0000
Subject: Re: [lm-sensors] no sensors were detected with Intel Corporation
Message-Id: <20071122211804.6e74aaab@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <c8faca170711081606t6acc5928hfdcd9200ba1d421f@mail.gmail.com>
In-Reply-To: <c8faca170711081606t6acc5928hfdcd9200ba1d421f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 20 Nov 2007 20:30:40 -0200, Kessia Pinheiro wrote:
> The output is below:
> 
> # isadump -f 0x0c90
> WARNING! Running this program can cause system crashes, data loss and worse!
> I will probe address range 0xc00 to 0xcff.
> Continue? [Y/n]
>   0 1 2 3 4 5 6 7 8 9 a b c d e f
> 0c00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0c10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0c20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0c30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0c40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0c50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0c60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0c70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0c80: 0a ff ff ff 08 ff ff ff ff ff ff ff ff ff ff ff
> 0c90: 34 ff ff ff 00 ff ff ff ff ff ff ff ff ff ff ff
> 0ca0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0cb0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0cc0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0cd0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0ce0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0cf0: ff ff ff ff ff ff ff ff ff 00 ff ff ff ff ff ff

This doesn't look like a hardware monitoring chip...

> On 11/16/07, Juerg Haefliger <juergh@gmail.com> wrote:
> >
> > Hi Kessia,
> >
> > Please keep the list in the loop for future replies.
> >
> >
> > > The isadump output is below, but the BIOS info i send later.
> > >
> > >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> > > 00: 00 00 00 00 00 00 00 0e 00 00 00 00 00 00 00 00
> > > 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > 20: 32 01 00 00 00 04 2e 00 00 00 00 00 00 00 00 00
> > > 30: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > >  60: 0c 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > a0: 00 00 00 00 00 00 00 00 00 00 ff ff ff ff ff ff
> > > b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > >  f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > >
> >
> > OK, can you now run 'isadump -f 0x0c90'?

... which isn't all that surprising, as the LDN is 0x0e which is never
used for hardware monitoring features on SMSC Super-I/O chips. Most of
them use LDN 0x0a or 0x08. Only one model uses LDN 0x09.

So, Kessia, please provide the output of the following commands:

isadump -k 0x55 0x2e 0x2f 0xa
isadump -k 0x55 0x2e 0x2f 0x8

(Please keep posting your replie to the mailing list.)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
