From: veso_vdd@mail.orbitel.bg (Vesselin Dimitrov)
Date: Thu, 19 May 2005 06:23:35 +0000
Subject: Ticket #920
Message-Id: <200206221919.26683.veso_vdd@mail.orbitel.bg>
List-Id: <lm-sensors.vger.kernel.org>
References: <200206221117.33609.veso_vdd@mail.orbitel.bg>
In-Reply-To: <200206221117.33609.veso_vdd@mail.orbitel.bg>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Saturday 22 June 2002 18:06, you wrote:
> you want i2cdump 2 0x50, not 0 0x50 - you dumped your SDRAM EEPROM, not
> your DDC one.
>
Oops, in the reply from support I was asked for 0 0x50. So there's the 2 0x50:
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 ff ff ff ff ff ff 00 1e 6d d1 42 f5 7c 00 00    ........?m?B?|..
10: 0a 0b 01 03 08 21 19 b9 e8 8a c9 a1 54 4b 99 24    ?????!??????TK?$
20: 12 48 4c ff fe 80 31 4f 31 59 45 4f 45 59 61 4a    ?HL.??1O1YEOEYaJ
30: 61 4f 61 59 81 80 ea 24 00 60 41 00 28 30 30 60    aOaY???$.`A.(00`
40: 13 00 3b e6 10 00 00 1e 30 2a 00 98 51 00 2a 40    ?.;??..?0*.?Q.*@
50: 30 70 13 00 3b e6 10 00 00 1e 00 00 00 fd 00 32    0p?.;??..?...?.2
60: a0 1e 46 0b 00 0a 20 20 20 20 20 20 00 00 00 fc    ??F?.?      ...?
70: 00 46 4c 41 54 52 4f 4e 20 37 37 35 46 54 00 17    .FLATRON 775FT.?
80: f7 37 cf bc 3f 5f ff ce ef ff f1 fb fb ed ff 59    ?7???_.??.????.Y
90: 6f e6 f5 e7 f9 ff ef 5c ff b5 db f7 bb db ff f5    o????.?\.?????.?
a0: a5 5d 27 fe bf 7f f3 df 49 97 ef fb fb ff fd ea    ?]'?????I????.??
b0: bb 6f 3f f5 b7 fa f9 f7 6f cf f7 ed 7f d3 eb cd    ?o??????o???????
c0: fe b7 fe ad 4d 7f b3 df ee 7d eb ff df c6 fd 5d    ????M????}?.???]
d0: f7 ff 00 00 00 04 00 76 ef fe b7 fe 7d 7f fd ae    ?....?.v????}???
e0: 01 e2 97 ff ff df fe 77 f6 bb ff f5 7f bf af ff    ???..??w??.????.
f0: bf fe ff bf dc 7b cd ee ff e6 eb b7 ff 7b fc ff    ??.??{??.???.{?.
