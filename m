From: "Kessia Pinheiro" <kessiapinheiro@gmail.com>
Date: Sat, 01 Dec 2007 17:16:07 +0000
Subject: Re: [lm-sensors] no sensors were detected with Intel Corporation
Message-Id: <c8faca170712010916y2b276fd4je7233f532fa43cef@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <c8faca170711081606t6acc5928hfdcd9200ba1d421f@mail.gmail.com>
In-Reply-To: <c8faca170711081606t6acc5928hfdcd9200ba1d421f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

isadump 0x910 0x911
WARNING! Running this program can cause system crashes, data loss and worse!
I will probe address register 0x910 and data register 0x911.
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 23 00 00 00 ff 1f 80 4c 00 00 00 07 37 39 37 39
90: 02 00 00 00 80 00 00 08 00 00 00 00 00 00 00 43
a0: 00 01 01 4f ec f5 07 2d a8 0f 20 0c 06 01 37 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


On 12/1/07, Jean Delvare <khali@linux-fr.org> wrote:
> On Fri, 30 Nov 2007 17:29:40 -0200, Kessia Pinheiro wrote:
> > isadump -f 0x910
> > WARNING! Running this program can cause system crashes, data loss and worse!
> > I will probe address range 0x900 to 0x9ff.
> > Continue? [Y/n]
> >   0 1 2 3 4 5 6 7 8 9 a b c d e f
> > 0900: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 0910: af 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 0920: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 0930: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 0940: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 0950: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 0960: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 0970: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 0980: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 0990: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 09a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 09b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 09c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 09d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 09e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 09f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>
> Hmm, that could be an index/data pair as on the LPC47B397 and
> LPC47N252. Then the next step would be:
>
> isadump 0x910 0x911
>
> That being said, without a datasheet, I'm not sure where we are going.
> Especially as it is a laptop and most laptops don't have usable
> sensors, there's probably nothing to find.
>
> --
> Jean Delvare
>


-- 
Kessia Pinheiro
Bacharelanda em Ciência da Computação
Universidade Federal da Bahia
Linux Counter User #389695 [http://counter.li.org]
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
