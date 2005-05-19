From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: bug?
Message-Id: <Pine.LNX.4.58.0406240848551.31465@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040623220306.GA10703@terminal.dnsalias.org>
In-Reply-To: <20040623220306.GA10703@terminal.dnsalias.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello,

> The only difference is with rev 1.04 the i dont see the mobo
> temperature value.
> It show constantly -48 celsius. (bios shows correctly)

It seems unconnected.
What about temp3 (you may have this temp commented out) ?


> MB:        -48.0?C  (high =   +80?C, hyst =   +75?C)
> With 1.03 mobo the mb temp is showed correcty.

> I am using same bios on the two mobos.

You flashed to same version ?

> Is it a sensors bug or something wrong with the mobo?

It may be change in HW design. Lets try to dump the chip registers.

In "sensors" listing you should see chip address. (2 hex digits) If not
you can try:

I suppose you havent more i2c busses on your computer.
(check with i2cdetect -l)

Run as root to probe the ALI bus:

i2cdetect 0

You should see in 0x20 - 0x2F range some number(s). I would say it can be
on 0x2D

If you are sure about the address from sensors output you can continue
here. Just replace the 0x2d with your address.

then i2cdump 0 0x2d

You can redirect output to file. Please run it on both computers and send
it to us. Could you write also the bios revision you are using ?

Don't forget to CC to a list. You can visit us at IRC #linux-sensors at
freenode.org.

Thanks

Regards

Rudolf

