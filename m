From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: New LM83 driver
Message-Id: <20030813105553.12295ff8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030809231304.74f73999.khali@linux-fr.org>
In-Reply-To: <20030809231304.74f73999.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > (Message received 12 times, what happened?)
> Nothing happened when I pressed the send button. But it seems like
> something did happen...

OK, no problem. Just wanted to make sure it wasn't a mailing-list issue.

> > Could you try setting some limits (through the config file or
> > manually,
> Tried setting both critical and high. When temp was over high I got:
> temp1:       +38?C  (limit =  +47?C, critical =  +60?C)   ALARM

I don't understand. In this example, 38 < 47 and 38 < 60 so no alarm
should trigger at all - yet the high alarm seems to be set. Looks like a
bug in my driver :(

> I had a look at the wiring diagram and all D+ ports are wired
> together. But as said before the temperatures differ with as much as 7
> degrees within a single reading I find that hard to believe.

Sure, I just can't believe it. BTW, where did you got that diagram? I
know no motherboard manufacturer that give a full wiring diagram for
their motherboard (and I don't blame them, most people just wouldn't
care).

Thanks for testing :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
