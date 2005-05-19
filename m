From: chris@maybe.net (Chris Jantzen)
Date: Thu, 19 May 2005 06:23:49 +0000
Subject: Ticket #1167 Feedback (as per request)
Message-Id: <20030313195142.GA2065@maybe.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

(BTW-Line 577 of bmcsensors.c needs an additional right brace.)

With "#define DEBUG 1" in i2c-ipmi.c and bmcsensors.c:

i2c-core.o: i2c core module version 2.7.0 (20021208)
i2c-proc.o version 2.7.0 (20021208)
i2c-dev.o: i2c /dev entries driver module version 2.7.0 (20021208)
i2c-ipmi.o version 2.7.0 (20021208)
i2c-dev.o: Registered 'IPMI adapter' as minor 0
i2c-ipmi.o: Registered IPMI interface 0 with version 0.9
i2c-ipmi.o: BMC access for i2c modules initialized.
bmcsensors.o version 2.7.0 (20021208)
bmcsensors.o: Registered client, scanning for sensors...
bmcsensors.o: Send BMC msg, cmd: 0x22
i2c-ipmi.o: Send 0x22
bmcsensors.o: Got first resid 0x0001
bmcsensors.o: Get SDR 0x0 0x0 0x0
bmcsensors.o: Send BMC msg, cmd: 0x23
i2c-ipmi.o: Send 0x23 0x0 0x0
i2c-ipmi.o: Error 0xc9 on cmd 0xb/0x23
bmcsensors.o: Error 0xc9 on cmd 0xa/0x23; state = 2; probably fatal.

-- 
chris jantzen kb7rnl =->         __O
Insert witty comment here.     _`\<,_
http://www.maybe.net/         (*)/ (*)
