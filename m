From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:39 +0000
Subject: A question when test W83792D driver on another motherboard
Message-Id: <xeYDD4vh.1109159085.6008280.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190C6C@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190C6C@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Rudolf,

> I think the function fails because nothing listens on that address.
> (Khali/Jean can you confirm?)

Absolutely right, as I explained in my other post.

> you can try:
>
> modprobe i2c-dev
> i2cdetect -l
>
> You will see the bus number you will use in next command.
>
> i2cdetect 0
>
> 0 Is my bus number.
>
> This command will probe i2c addresses to find all clients.
> If you will see XX on that address where should be 792D. Then it is
> hidden.

If sensors-detect did not trigger on any address while scanning the bus,
this also confirms that. I think that's what Chunhao told in a previous
mail. That said, a conformation from i2cdetect would be welcome for sure.

--
Jean Delvare
