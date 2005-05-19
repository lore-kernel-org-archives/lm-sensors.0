From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: ASB100 PWM
Message-Id: <20031118210701.1dea5aab.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031111062929.GA30118@earth.solarsys.private>
In-Reply-To: <20031111062929.GA30118@earth.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > Care to send me your dump? I already have Vitaly's one. I might see
> > something you missed. I've become quite good at reading dumps ;)
> 
> Thanks Jean...
> (...)
>   Probing bank 1 using bank register 0x4e.

Hu-oh. I had forgotten that this beast has several banks (I still can't
understand why manufacturers to this since there is less that 256
registers total).

Mark, can you explain to Vitaly how to produce a complete dump, as you
just did?

I'd also need at least a third user's dump, together with the model
information (A or not). Without that, there will be too many registers
that could be the one we are after. Of course, more dumps would be
welcome. The more we have, the easier the work will be.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
