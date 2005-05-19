From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: We will port w83792d.c to linux-2.6
Message-Id: <20050324212145.7a4ab8e7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

> I2C WRITE QUICK is used to detect the devices. It is simply a "probe"

I would insist on the fact that this is the way we use it. This is NOT
how SMBus defines it in the first place. In theory, the "quick command"
allows the host to send one single bit of data to a client. It isn't
meant to be a probe. It just happens that clients have to ack sent
bytes, and no known client chip implements the "quick command" so it's
convenient to use it for probe.

> You will just issue bus transaction, Start cond, address, and you will
> wait if some device will confirm its presence. I'm not expert on this
> and I think then STOP is issued and thats all.

That's correct.

> It does not read/write anything just probing address if someone
> respond on this address.

It does actually write a bit, which all known client chips ignore (so
far...). So in the facts Rudolf is correct, the command doesn't actually
have any effect above the probe.

-- 
Jean Delvare
