From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:44 +0000
Subject: kern2.6.3 - report busted PST laptop table in eMachines M5312 (
Message-Id: <20040228215422.0fef267d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <40409BEF.7070108@ameritech.net>
In-Reply-To: <40409BEF.7070108@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> copied to rgooch due to mtrr messages...
> copied to lm78 due to i2c radeon messages..

The radeonfb driver is not ours. Since the errors do not concern the i2c
layer as far as I can tell, we cannot help. See with BenH and Kronos
instead. That said, you could try to reproduce the bug without the
radeonfb driver. If the bug still happens, than it's not linked to the
radeonfb driver.

> copied to ndiswrapper folks as 2.6.3 is last version where ndiswrapper
> 
> runs before coredumping...   2.6.4-rc1 gives a fatal dump on wlan0 
> init with hard paging crash
> 
> 2.3.6 config is attached
> 
> btw 2.6.3 runs.  2.6.4-rc1 runs 2.6.4.rc1 with ndiswrapper doesn't.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
