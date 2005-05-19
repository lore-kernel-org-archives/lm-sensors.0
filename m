From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: Ticket #1545
Message-Id: <20040125214923.548e49cf.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <40140EAE.1010706@fortytwo.eu.org>
In-Reply-To: <40140EAE.1010706@fortytwo.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> OK, I re-loaded the modules, now dmesg says:
> 
> i2c-core.o: i2c core module version 2.8.3 (20040115)
> i2c-dev.o: i2c /dev entries driver module version 2.8.3 (20040115)
> i2c-proc.o version 2.8.3 (20040115)
> via686a.o version 2.8.3 (20040115)
> via686a.o: base address not set - upgrade BIOS or use
> force_addr=0xaddr
> 
> Hmm, the BIOS is already the latest version...

So you are supposed to force the address, but I don't know where you get
the value from... The docs (doc/chips/via686a) suggest 0x290. Mark, any
advice?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
