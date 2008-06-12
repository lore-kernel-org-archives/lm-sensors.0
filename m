From: Marcos Dione <mdione@grulic.org.ar>
Date: Thu, 12 Jun 2008 18:37:06 +0000
Subject: Re: [lm-sensors] sensors on dell inspiron 1420
Message-Id: <20080612183633.GA20361@mustang.grulicueva.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080607135219.GD18192@grulicueva.homelinux.net>
In-Reply-To: <20080607135219.GD18192@grulicueva.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jun 11, 2008 at 03:39:43PM -0700, Juerg Haefliger wrote:
> Hi Marcos,
> OK I'm fishing now. Can you try:
> isadump 0x910 0x911

mdione@mustang:~$ sudo isadump 0x910 0x911
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
80: 1f 00 00 07 00 00 00 04 00 01 00 01 32 37 38 34
90: 02 00 00 00 80 00 00 08 00 00 00 00 00 00 00 43
a0: 00 01 00 64 00 00 28 31 ec 13 de 0b 0a 47 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

    looks promising...
     

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
