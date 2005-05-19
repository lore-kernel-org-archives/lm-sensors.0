From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: Ported lm80 to Linux 2.6
Message-Id: <20040218222517.552a6438.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1076403383.40289cb779c27@imp.gcu.info>
In-Reply-To: <1076403383.40289cb779c27@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> On Tue, 17 Feb 2004, Jean Delvare wrote:
> > Interesting. I will analyze the data and try to summarize some
> > facts. Could you dump the chip again under high load? If it is some
> > temperature sensor, we should see at least one register increase.
> 
> Here they are, baked at 75 C :)

Thanks. I have more information since yesterday. It happens that this
mysterious chip is simply your via686a chip, except that you access it
through the SMBus instead of ISA. Until then I didn't know that this
chip could possibly be accessed that way.

Now, there's a theory I would like to confirm, if you can provide one
more dump. I'd like you to load i2c-isa and via686a. Then note the
address of the via686a. If should be relatively high (such as 0x5800 or
0x6000). Then unload via686a and dump it using the following command:
isadump -f 0x<address>

This should give you a dump similar to what i2cdump gave you so far.
Please send it to me :)

Thanks.

(BTW, your lm80 driver will be part of Linux 2.6.4, in case I didn't
already told you! Congratulations.)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
