From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 21 Sep 2006 06:14:51 +0000
Subject: [lm-sensors] DME1737 specsheet dead end.
Message-Id: <20060921081451.6d90742b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4503968B.8010703@sandeen.net>
In-Reply-To: <4503968B.8010703@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Eric,

> > > FYI, DME1737 specsheet (a.k.a. Asus A8000) is apparently not available to mere 
> > > mortals... conversation follows:
> > 
> > I didn't know the SMSC DME1737 and the Asus A8000 were the same chip.
> > How did you find out?
> 
> Google :)
> 
> http://www.google.com/search?q=DME1737+Asus+A8000
> 
> http://www.lavalys.com/forum/lofiversion/index.php/t811.html
> 
> Granted not the most authoritative answer, but apparently someone else
> writing this sort of driver believes that it's true...
> 
> the lm-sensors wiki also makes such a statement.

Ah yeah, right. I don't know who added it... The reason why I'm
susprised is that the DME1737 is said to be a Super-I/O chip, while the
A8000 can be accessed through the SMBus and is supposed to have
similarities with the LM85, which is a dedicated hardware monitoring
chip with SMBus interface only.

But well we've seen Super-I/Os with SMBus interfaces as well, so it may
be true after all. Not that it really matters anymore...

-- 
Jean Delvare

