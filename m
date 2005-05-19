From: sascha@akv-soft.de (Sascha Volkenandt)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: SAA1064 sensors chip driver
Message-Id: <200307172002.50220.sascha@akv-soft.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307131153.24333.sascha@akv-soft.de>
In-Reply-To: <200307131153.24333.sascha@akv-soft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

At Dienstag, 15. Juli 2003 19:37 Jean Delvare wrote:
> Unfortunately, this couldn't be confirmed by i2cdump. I'd like you to
> insist, this would really help. Maybe the chip doesn't like the was
> i2cdump reads it. You still could try adding these checks in your driver
> code (for kind < 0) and see if the module still loads. Another
> possibility is to add detection to sensors-detect (what I could do.)

I *think* I've found a way to detect this thing. WHen the chip is freshly 
powered on (nothing is displayed), a byte read results in 0x80 (power 
failure indicator set to 1), while a subsequent byte read results in 0x00 
(no power-failure since last read-out). So, if two byte reads result in 
0x80, followed by 0x00, we'd probably have found a saa1064 chip. What do 
you think, is this secure enough or could it confuse other chips possibly 
using the same address?

Main problem will be that this will only work one time, after powering the 
chip.

Greetings,
Sascha
