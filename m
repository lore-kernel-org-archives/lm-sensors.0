From: "Lars Kr.Lundin" <lmsensors@lklundin.dk>
Date: Wed, 23 Jun 2010 20:47:14 +0000
Subject: Re: [lm-sensors] sensors.conf for DFI LP MI P55-T36 (it8720-*)
Message-Id: <20100623204714.28710.qmail@mailserver01.ottosenfx.dk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100606154919.4066.qmail@mailserver01.ottosenfx.dk>
In-Reply-To: <20100606154919.4066.qmail@mailserver01.ottosenfx.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jun 23, 2010 at 10:31:39PM +0200, Jean Delvare wrote:

> try instead:
>
> # isadump -y -k 0x87,0x01,0x55,0x55 0x2e 0x2f 7
>
> Thanks,
> --
> Jean Delvare

$ sudo isadump -y -k 0x87,0x01,0x55,0x55 0x2e 0x2f 7
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 00 00 00 00 00 00 00 07 00 00 00 00 00 00 00 00 
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
20: 87 20 08 00 00 01 fe 30 43 10 00 00 1f 00 00 00 
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
60: 00 00 0a 20 0a 30 00 00 00 00 00 00 00 00 00 00 
70: 00 00 00 00 00 04 00 00 00 00 00 00 00 00 00 00 
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
b0: 00 00 00 00 00 00 00 00 20 00 70 30 00 00 00 00 
c0: 01 42 30 01 00 00 00 00 01 42 30 01 00 00 00 00 
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
e0: 00 00 00 00 00 00 00 00 00 03 03 03 00 3e 3e 0c 
f0: 00 00 00 00 00 00 40 00 00 00 00 00 cf 00 00 00 

(I have to wonder what one can learn from the above :-)

-Lars Lundin.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
