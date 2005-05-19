From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:19 +0000
Subject: w83627hf - i2c - chip
Message-Id: <20041016084608.45c4555e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <JZj4crVb.1097829064.8415090.khali@gcu.info>
In-Reply-To: <JZj4crVb.1097829064.8415090.khali@gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> If you need any other info, I would be happy to help.
> I know it is hard to collect data when developing for hardware you do
> not have ;)

You have no idea how right you are...

> > What is your motherboard brand/model?
> 
> Gigabyte 7DPXDW-P
> http://www.giga-byte.com/Server/Products/Products_ServerBoard_GA-7DPXDW-P.htm

Providing the "P" stands for "plus", the board is actually listed on the
MBM list with the following comment:
"LM90switch to 25 and pause to 30, see help file advanced section"

> Client found at address 0x70
> Probing for `Philips Semiconductors PCA9540'... Failed!

So sensors-detect doesn't seem to think that this is a PCA9540, while it
really is supposed to be. The problem is that there is no easy way to
detect that chip. Do not run i2cdump on it, it won't work and will leave
the chip in an undefined state (if it is a PCA9540, that is).

I'd suggest you open the case and visually inspect your motherboard in
search for a PCA chip. It would be very small (8 pins) and most likely
located between the two CPU sockets.

Also, while searching for info on your motherboard in my mail archives I
found the following record:

"BTW, the user has something strange with the other chip on the Gigabyte
GA-7DPXDW+, a Winbond W83627HF. It was working fine, but after he
scanned the SMBus (on which the LM90 is, but the W83627HF is *not*), the
W83627HF partly stopped working. Fan speeds are still OK, but voltages
and temperatures are dead (registers read $00 or $FF). Have you ever
seen that before?"

I have no other trace of the event, so I'm not sure if we ever
understood what had gone on, nor whether the readings ever went back.
There is probably no need to be afraid (that user probably just had bad
luck, no relation with lm_sensors), but I thought I'd let you know, just
in case.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
