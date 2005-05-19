From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: lm75 compute
Message-Id: <20031027224702.7854fcad.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F9C884D.93E32BDA@paradyne.com>
In-Reply-To: <3F9C884D.93E32BDA@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> who made the default compute for lm75 temperature be divide by 2
> (attributed to the Asus TX97-E)?!?!

Me.

> Ticket 1423 complains.

Interesting.

> I can't tell from the CVS log for sensors.conf.eg how it happened.

----------------------------
revision 1.77
date: 2002/11/08 12:06:53;  author: khali;  state: Exp;  lines: +119 -94
(Khali) Add section for lm75 in sensors.conf.eg
        Complete the lm78 section in sensors.conf.eg
----------------------------

> Or did this get in by mistake?

No, I made this on purpose.

> Let's not change a years-old default for the sake of one
> motherboard!!!

I wouldn't have changed an existing configuration, but it happens that
the LM75 had no section at that time, so I simply made one based on the
only board I had with a LM75 on it - an Asus TX97-E.

Now I admit that what's said on ticket 1423 is plain right. The LM75
cannot be configured in any way, so I hardly can understand how the
reported temperature could require scaling. On the other hand, which
chip would it be on my TX97-E, if not a LM75? There's also a LM78 on
that board, so it sound rather logical that the other monitoring chip
would be from National Semiconductor too.

I'll open the case and take a look, in case I'm able to see the
monitoring chips.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
