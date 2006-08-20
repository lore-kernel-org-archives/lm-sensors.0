From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 20 Aug 2006 10:46:05 +0000
Subject: [lm-sensors] Using ... SMSC EMC6W201
Message-Id: <44E83D6D.1010004@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060613202602.560.qmail@web81611.mail.mud.yahoo.com>
In-Reply-To: <20060613202602.560.qmail@web81611.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ric wrote:
> Hi:
> 
> I don't think so. The EMC6w201 uses the SMBus...
> Seems like, IIRC, that's why the smsc47* cannot be used.

Ok.

> Is it possible to make a usable driver by implementing only temperature
> readings first, then later adding voltages, then still later fans'
> RPMs, then PWM fan control, etc... rather than trying to get all of it
> done at one whack?

Sure, I think we can just start with fans and temps, same was for winbond EHF
driver.

Regards
Rudolf

