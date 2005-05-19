From: martin@martin-fernau.de (Martin Fernau)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: no FAN3 available
Message-Id: <200309151241.57749.martin@martin-fernau.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200309011224.08300.martin@martin-fernau.de>
In-Reply-To: <200309011224.08300.martin@martin-fernau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

> I recently contacted MSI about another motherboard, asking them if it
> had a secondary monitoring chip. I knew it had. They told it had not. I
> told them I knew it had. They told I were wrong...
>
> Don't trust docs. Don't trust support. These are hints at best, but only
> solely the truth.

:) So we see, the customer support also knows nothing about their own 
products.

> > Maybe I try to
> > connect the system-fan to the FAN2 input on my mainboard.
>
> If you don't use the FAN2 input, yes, why not.

I'll try it when my new processor arrives.

> There is something there. Something we don't know yet, but it's there.
> Please provide the output of "i2cdump 0 0x18" (make sure i2c-viapro is
> loaded). (I got the strange feeling that I *already* asked you for that
> output... Please forgive me if this is the case).

no problem. In your last mail you don't talk about this, but it's ok.
I append the output to this mail.

thanks,
Martin Fernau

-- 

Name		: Martin Fernau
Mail		: martin@martin-fernau.de
URL		: http://www.martin-fernau.de
icq		: 14509914

-------------- next part --------------
i2cdump 0 0x18
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x18, mode byte
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: f9 09 07 f0 00 3f ff ff 17 17 00 00 00 10 ff ff    ????.?..??...?..
10: ff 10 00 00 0c 00 00 ff ff ff ff ff ff ff ff ff    .?..?...........
20: 60 13 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    `?..............
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
