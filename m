From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:39 +0000
Subject: A question when test W83792D driver on another motherboard
Message-Id: <dXcliFfn.1109075187.7909120.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190C6C@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190C6C@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Chunhao,

> We are going to test the 792 driver on another motherboard(AAA)
> with 792 chip:
> (...)
> But we meet a problem, that the the script sensors-detect in
> lm_sensors-2.9.0 can NOT find the 792 chip.

I'd bet one buck that this "AAA" board was made by Asus. Right?

> I'm sure that the sensors-detect and i2cdetect version is 2.9.0.

We have had a report already with an Asus NCL-DS board. We know it has a
W83792D chip, but it is somehow hidden. All our attempts to unhide it
failed.
http://archives.andrew.net.au/lm-sensors/msg28885.html

If you have a similar case, I am sorry but there's nothing we can do.
Your only hope is to ask the motherboard manufacturer for additional
information. Good luck... (that said you might have more chance to get
something because you work at Winbond...)

--
Jean Delvare
