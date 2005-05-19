From: mr-smoke@spinning-plates.eu.org (Romain Riviere)
Date: Thu, 19 May 2005 06:24:16 +0000
Subject: Ticket 1382 : Update
Message-Id: <1063266810.23564.17.camel@marla.spinning-plates.eu.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1061487346.2223.4.camel@marla.spinning-plates.eu.org>
In-Reply-To: <1061487346.2223.4.camel@marla.spinning-plates.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 2003-09-07 at 17:31, Jean Delvare wrote:
> VIA chipsets have an overall bad reputation (network adapters and
> motherboards alike) for sure.
That must be it then, I'll just live with it...

> >
> > Well that's ok, I'm sticking to 2.4.21 for now, until grsec is patched
> > too.
> 
> FYI, the patches are available by now.

Yup, got 2.4.22 running fine now, thanx :)

> > If you don't mind my bothering you some more ...
> > - sensors-detect says:
> > Detects correctly:
> >   * Bus `SMBus Via Pro adapter at 0400' (Non-I2C SMBus adapter)
> >     Busdriver `i2c-viapro', I2C address 0x2d
> >     Chip `National Semiconductor LM80' (confidence: 3)
> > However, I don't think I've got that chip anywhere on my PC. I wonder
> > what chip could be misdetected like that, where to look ?
> 
> You should dump the chip contents and post the dump on this
> mailing-list. We'll take a look and see if we can find out what it is.
> Telling us what your motherboard is will help too. In order to dump the
> chip contents, use: "i2cdump 0 0x2d". (Replace 0 with the bus number if
> it's not 0). Make sure there's no chip driver loaded for that address,
> or you may confuse that driver with unpredictable results.

Ok here goes.
My motherboard is a Gigabyte GA-6VTXE-A, featuring the infamous
ApolloPro133 (VT82C694T and 686B). Now for the dump :

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 01 82 16 00 00 00 00 50 ad ad 00 40 00 00 00 00    ???....P??.@....
10: 00 00 00 ce a6 2a 39 86 00 00 00 00 00 ce c7 81    ...??*9?.....???
20: a1 94 8b 56 cf c8 ca 7f 7f 87 ff 91 82 e7 bd e4    ???V??????.?????
30: ba de b5 dc b4 12 86 81 82 ae a4 e1 e1 c7 c0 a2    ????????????????
40: 01 00 00 00 00 00 00 50 ad ad 00 40 00 00 00 00    ?......P??.@....
50: 00 00 00 ce c0 2a cc 85 00 00 00 00 00 ce c7 81    ...??*??.....???
60: a1 94 8c 56 cf c8 ca 7f 7f 87 ff 91 82 e7 bd e4    ???V??????.?????
70: ba de b5 dc b4 12 86 81 82 ae a4 e1 e1 c7 c0 a2    ????????????????
80: 01 00 00 00 00 00 00 50 ad ad 00 40 00 00 00 00    ?......P??.@....
90: 00 00 00 cc 76 2a 7f 85 00 00 00 00 00 ce c7 81    ...?v*??.....???
a0: a1 94 8c 56 ce c8 ca 7f 7f 87 ff 91 82 e7 bd e4    ???V??????.?????
b0: ba de b5 dc b4 12 86 81 82 ae a4 e1 e1 c7 c0 a2    ????????????????
c0: 01 00 00 00 00 00 00 50 ad ad 00 40 00 00 00 00    ?......P??.@....
d0: 00 00 00 56 28 2a f2 85 00 00 00 00 00 ce c7 81    ...V(*??.....???
e0: a1 94 8b 56 cf c8 ca 7f 7f 87 ff 91 82 e7 bd e4    ???V??????.?????
f0: ba de b5 dc b4 12 86 81 82 ae a4 e1 e1 c7 c0 a2    ????????????????

Thanx for your help!
Best regards,
Romain
