From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 23 Feb 2011 21:14:21 +0000
Subject: Re: [lm-sensors] [PATCH] lm85: extend to support emc6d103 chips
Message-Id: <20110223221421.5e763092@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D5E343702000078000329C1@vpn.id2.novell.com>
In-Reply-To: <4D5E343702000078000329C1@vpn.id2.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 23 Feb 2011 14:38:50 +0000, Jan Beulich wrote:
> >>> On 18.02.11 at 15:54, Jean Delvare <khali@linux-fr.org> wrote:
> > BTW, could you please provide a dump of your chip? I'd like to add it
> > to my collection. Use i2cdump with the i2c-dev kernel driver.
> 
> The box got two of them, one at 002c
> 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 20: 89 60 bf c4 be 1f 24 24 e0 0b ff ff 9c 0b ff ff    ?`????$$??..??..
> 30: ff ff ff 00 00 00 00 00 00 00 00 00 00 00 5c 68    ..............\h
> 40: 05 80 08 00 00 ff 00 ff 00 ff 00 ff 00 ff 81 7f    ???...........??
> 50: 81 7f 81 7f 30 2a 30 2a 30 2a ff ff 62 62 62 aa    ????0*0*0*..bbb?
> 60: aa aa e8 88 44 44 44 1e 1e 1e 7f 64 7f 44 40 00    ????DDD????d?D@.
> 70: ff ff ff 09 09 09 09 09 09 00 00 00 40 00 ec 1a    ...??????...@.??
> 80: 1f a4 0e 00 00 a4 3c c9 0c 00 40 40 09 09 0b 00    ???..?<??.@@???.
> 90: 14 14 14 04 0c 0c 0c 5a f1 00 00 00 23 00 00 00    ???????Z?...#...
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 
> and the other at 002e
> 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 f2 f2    ..............??
> 20: 87 5f bc bf bc 18 27 1c 9b 14 9a 14 ff ff ff ff    ?_????'?????....
> 30: 66 66 66 00 00 00 00 00 00 00 00 00 00 00 5c 68    fff...........\h
> 40: 05 80 30 00 00 ff 00 ff 00 ff 00 ff 00 ff 81 7f    ??0...........??
> 50: 81 7f 81 7f 30 2a 30 2a 30 2a 30 2a c2 c2 c2 73    ????0*0*0*0*???s
> 60: 7a 73 e8 88 66 66 66 37 37 37 46 64 46 44 40 00    zs??fff777FdFD@.
> 70: 66 66 66 09 09 09 09 09 09 00 00 00 40 00 ec 1a    fff??????...@.??
> 80: 1f a4 0e 00 00 8a 98 dd fa 00 40 40 09 09 0b 00    ???..????.@@???.
> 90: 14 14 14 04 0c 0c 0c 5a f1 00 00 00 23 00 00 00    ???????Z?...#...
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................

Great, thank you.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
