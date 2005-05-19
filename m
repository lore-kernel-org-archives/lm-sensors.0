From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 19 May 2005 06:24:44 +0000
Subject: kern2.6.3 - report busted PST laptop table in eMachines M5312
Message-Id: <1078035828.10428.30.camel@gaston>
List-Id: <lm-sensors.vger.kernel.org>
References: <40409BEF.7070108@ameritech.net>
In-Reply-To: <40409BEF.7070108@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Your message was mangled. Can you forward me some clear
report of the problem ?


On Sun, 2004-02-29 at 08:44, water modem wrote:
> Report is attached and forwarded to you per Jean Delvare's suggestion.
> Separate tests were not run without the radeonfb driver
> 
> 
> Jean Delvare wrote:
> >>copied to rgooch due to mtrr messages...
> >>copied to lm78 due to i2c radeon messages..
> > 
> > 
> > The radeonfb driver is not ours. Since the errors do not concern the i2c
> > layer as far as I can tell, we cannot help. See with BenH and Kronos
> > instead. That said, you could try to reproduce the bug without the
> > radeonfb driver. If the bug still happens, than it's not linked to the
> > radeonfb driver.
> > 
> > 
> >>copied to ndiswrapper folks as 2.6.3 is last version where ndiswrapper
> >>
> >>runs before coredumping...   2.6.4-rc1 gives a fatal dump on wlan0 
> >>init with hard paging crash
> >>
> >>2.3.6 config is attached
> >>
> >>btw 2.6.3 runs.  2.6.4-rc1 runs 2.6.4.rc1 with ndiswrapper doesn't.
> > 
> > 
> 
> 
> ______________________________________________________________________
> Date: Wed, 31 Dec 1969 23:59:59 +0000
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>
