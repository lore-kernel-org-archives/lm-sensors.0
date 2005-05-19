From: olaf@fortytwo.eu.org (Olaf)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: Ticket #1545
Message-Id: <4014233D.8060207@fortytwo.eu.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <40140EAE.1010706@fortytwo.eu.org>
In-Reply-To: <40140EAE.1010706@fortytwo.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> This is the correct device. [...]

OK, I re-loaded the modules, now dmesg says:

i2c-core.o: i2c core module version 2.8.3 (20040115)
i2c-dev.o: i2c /dev entries driver module version 2.8.3 (20040115)
i2c-proc.o version 2.8.3 (20040115)
via686a.o version 2.8.3 (20040115)
via686a.o: base address not set - upgrade BIOS or use force_addr=0xaddr

Hmm, the BIOS is already the latest version...

Olaf
