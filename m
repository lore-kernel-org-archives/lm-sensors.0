From: jasonofhoulton@hotmail.com (Jason Anderson)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: Ticket #: 1365 w83627hf fan3_div
Message-Id: <Law10-F105Wcag1k39i0000884d@hotmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Law10-F1207IDkrBuOk0004d1a0@hotmail.com>
In-Reply-To: <Law10-F1207IDkrBuOk0004d1a0@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Thanks.  5d changes from 05 to 85 when changing fan_div from '4 2 1' to '4 =
2=20
64'.  Is that good?

Do you think my Winbond chip is messed up, and that's what's causing this?

>From: "Mark Studebaker" <mds@paradyne.com>
>To: Jason Anderson <jasonofhoulton@hotmail.com>
>CC: lm78@Stimpy.netroedge.com
>Subject: Re: Ticket #: 1365 w83627hf fan3_div
>Date: Wed, 27 Aug 2003 14:40:00 -0400
>
>isadump 0x295 0x296
>
>Jason Anderson wrote:
> >
> > Hi!  I tried isadump, but I guess I don't know how to use it.  Please
> > enlighten me.
> >
> > Update: My Windows motherboard utility reports 0 for fan3 now, too.
> >
> > Thanks,
> > Jason
> >
> > [root@chickadee w83627hf-isa-0290]# isadump 0x290 0x5d
> >   WARNING! Running this program can cause system crashes, data loss and
> > worse!
> >   I will probe address register 0x0290 and data register 0x005d.
> >   You have five seconds to reconsider and press CTRL-C!
> >
> >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> > 00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > [root@chickadee w83627hf-isa-0290]#
> > [root@chickadee w83627hf-isa-0290]# cat fan_div
> > 4 2 1
> > [root@chickadee w83627hf-isa-0290]# echo 4 2 2 > fan_div
> > [root@chickadee w83627hf-isa-0290]# cat fan_div
> > 4 2 2
> > [root@chickadee w83627hf-isa-0290]# isadump 0x290 0x5d
> >   WARNING! Running this program can cause system crashes, data loss and
> > worse!
> >   I will probe address register 0x0290 and data register 0x005d.
> >   You have five seconds to reconsider and press CTRL-C!
> >
> >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> > 00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >
> > _________________________________________________________________
> > Enter for your chance to IM with Bon Jovi, Seal, Bow Wow, or Mary J=20
>Blige
> > using MSN Messenger http://entertainment.msn.com/imastar

_________________________________________________________________
Get MSN 8 and enjoy automatic e-mail virus protection.  =20
http://join.msn.com/?page=FEatures/virus
