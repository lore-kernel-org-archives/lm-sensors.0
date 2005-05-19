From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: LM77
Message-Id: <20030730143536.097fda2d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030723112935.5a857970.khali@linux-fr.org>
In-Reply-To: <20030723112935.5a857970.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > 1* Add a different detection routine for the LM77 to sensors-detect.
> > I think we can assume that the registers cycle over 8-byte [1]
> > boundaries. Since cycling over 4-byte boundaries implies cycling
> > over 8-byte boundaries, we would have to give it a lower confidence
> > value than the LM75.
> > 
> > 2* Update the docs to explain the force parameter has to be used.
> 
> I guess the collective silence here means "we don't care", so I'll do
> just as described above.

After reading the LM75 and LM77 data sheets, and a part of the SMBus
specs, it turned out that my understanding of how the word-mode works
was bad, as was my understanding of how the registers are "cycling" on
these chips. So I may be plain wrong, the LM77 may be well detected by
our code and useable as a LM75 without anyone seeing any difference.

So I won't touch anything.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
