From: adobin@gmail.com (Alexander Dobin)
Date: Tue, 17 Jan 2006 18:54:58 +0000
Subject: [lm-sensors] wrong readings for w83627ehf on p5mt-m
Message-Id: <aaa5cd0c0601171054q4887e0a1odcce7e6d0b142109@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <aaa5cd0c0601131819j5692f460yb447692c03341732@mail.gmail.com>
In-Reply-To: <aaa5cd0c0601131819j5692f460yb447692c03341732@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello, Rudolf,
thanks for your interest in this problem!
Below is the output you asked for.
Alex

isadump 0x295 0x296
WARNING! Running this program can cause system crashes, data loss and worse!
I will probe address register 0x295 and data register 0x296.
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 01 bf 01 bf 01 00 00 00 01 01 01 01 3c 3c 0a 0a
10: 01 bf 00 00 00 01 01 3c 43 00 ff ff 24 32 00 de
20: ff ff d5 d3 d3 d9 f9 d0 ff ff ff e7 00 00 00 04
30: 02 00 80 10 48 28 00 00 00 00 00 02 00 00 01 ff
40: 03 00 00 de ff 00 03 04 2d 44 01 04 10 95 00 a3
50: ff ff 80 ff ff ff 00 80 88 73 ff ff 19 e0 ff 05
60: ff ff d5 d3 d3 d9 f9 d0 ff ff ff e7 00 00 00 04
70: 02 00 80 10 48 28 00 00 00 00 00 02 00 00 01 ff
80: 01 bf 01 bf 01 00 00 00 01 01 01 01 3c 3c 0a 0a
90: 01 bf 00 00 00 01 01 3c 43 00 ff ff 24 32 00 de
a0: ff ff d5 d3 d3 d9 f9 d0 ff ff ff e7 00 00 00 04
b0: 02 00 80 10 48 28 00 00 00 00 00 02 00 00 01 ff
c0: 03 00 00 de ff 00 03 04 2d 44 01 04 10 95 00 a3
d0: ff ff 80 ff ff ff 00 80 88 73 ff ff 19 e0 ff 05
e0: ff ff d5 d3 d3 d9 f9 d0 ff ff ff e7 00 00 00 04
f0: 02 00 80 10 48 28 00 00 00 00 00 02 00 00 01 ff


On 1/14/06, Rudolf Marek <r.marek at sh.cvut.cz> wrote:
>
> > I will be happy to quickly provide any additional information if any of
> > developers decide to resolve this problem.
>
>
> Hello, please send back output of:
>
> isadump 0x295 0x296
>
> Thanks
>
> Regards
> Rudolf
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060117/98bab3d8/attachment.html
