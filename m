From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: Who should I write to about this OOPS in 2,6,11-mm3?
Message-Id: <7ftaDFi0.1111481976.4208750.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050315050746.GB13009@kroah.com>
In-Reply-To: <20050315050746.GB13009@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Greg, Andrew, all,

> > Do we consider this to all be fixed up now?
>
> I thought so.  Jean?

No, not all is fixed. There were originally two different bug reports. In
the first place I thought they were related, but in turns out that I was
wrong.

So, the eeprom oops that was reported on bugzilla (#4347) by Salah
Coronya is now fixed, with the critical part of the fix already in
2.6.12-rc1 and candidate for 2.6.11.6, the other part being on its way
to Greg's bk-i2c tree. But the other oops, reported by Miles Lane on
LKML and then discussed on the sensors list, is not fixed yet, although
we are probably not so far from a fix now.

Thanks,
--
Jean Delvare
