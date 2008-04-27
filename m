From: Gabriel C <crazy@frugalware.org>
Date: Sun, 27 Apr 2008 16:26:50 +0000
Subject: Re: [lm-sensors] ASUS P5E-VM DO and unknown chip with ID 0x0b00
Message-Id: <4814A94A.1030302@frugalware.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <48077504.4000905@frugalware.org>
In-Reply-To: <48077504.4000905@frugalware.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rudolf Marek wrote:
> Hi,

Hi

> 
> Please can you provide output of following:
> 
> isadump -k 0x55 0x4e 0x4f
> 

Here the output :

    0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 0b 00 00 00 00 00 4e 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 ff ff ff ff ff ff
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 d1 15 0b 00 10 00 00 00 00 00 00 00 00 00 00


> Thanks,
> Rudolf

Gabriel

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
