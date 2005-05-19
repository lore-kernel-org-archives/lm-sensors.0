From: m.strong@tnsa.com.au (Mark Strong)
Date: Thu, 19 May 2005 06:25:30 +0000
Subject: fan speeds and temps no reading
Message-Id: <1105647947.15001.181.camel@tooheys.tnsa.com.au>
List-Id: <lm-sensors.vger.kernel.org>
References: <1104907933.3003.195.camel@tooheys.tnsa.com.au>
In-Reply-To: <1104907933.3003.195.camel@tooheys.tnsa.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hey,
	Jean,
		I'm doing it now, but is it supposed to do this

[root@bambi ~]# isaset -y -f 0x2e 0x87
Data mismatch, wrote 0x87, read 0xff back.
[root@bambi ~]# isaset -y -f 0x2e 0x87
Data mismatch, wrote 0x87, read 0xff back.

Well here's the dump anyway (you sure 0x2e is the right location?)

[root@bambi ~]# isaset -y -f 0x2e 0xaa
Data mismatch, wrote 0xaa, read 0xff back.


Mark.

ps Its a fair sized surface mount, it would take a bit of effort to
unsolder it, so as you say I think the isadump tool is the best bet :)

On Thu, 2005-01-13 at 20:42 +0100, Jean Delvare wrote:
> Hi Mark,
> 
> Could you please provide a dump of logical device 8 or your W83627THF
> chip?
> 
> isaset -y -f 0x2e 0x87
> isaset -y -f 0x2e 0x87
> isadump -y 0x2e 0x2f 8 > w83627thf-ld8.dump
> isaset -y -f 0x2e 0xaa
> 
> Thanks,
-------------- next part --------------
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff ff ff ff ff ff 08 ff ff ff ff ff ff ff ff 
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
20: 82 84 ff fe e2 00 00 ff 20 00 00 1a 58 20 00 ff 
30: 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
