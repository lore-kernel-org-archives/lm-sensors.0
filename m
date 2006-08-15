From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 15 Aug 2006 06:49:58 +0000
Subject: [lm-sensors] [PATCH 2/2 RESEND 2] hwmon: add vt1211
Message-Id: <20060815084958.09b33243.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060814143719.c2b61ce7.khali@linux-fr.org>
In-Reply-To: <20060814143719.c2b61ce7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > > +different thermal input but - and here's the weird part - only one set of
> > > +thermal thresholds exist that control both PWMs output duty cycles (??).
> >
> > Why these question marks?
> 
> Just to show my confusion why they implemented it that way. I'll take
> them out...

Yeah, every chip designer seems to be proud to add a new confusion
source. My experience is that, each time a chip tries to be smart and
spares registers by sharing values amongst different channels, it ends
up being a nightmare for us to implement support, and even more for the
end user to configure the chip to do what he/she wants.My advice to
chip designers, if it matters, would be: keep things simple, don't try
to be smart.

-- 
Jean Delvare

