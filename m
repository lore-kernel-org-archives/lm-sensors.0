From: jsack@inostor.com (James G. Sack (jim))
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: eeprom 2.9.0 problems on SuperMicro P4SCT+II
Message-Id: <1108507598.2411.28.camel@jgs3>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I can report the eeprom.o module from 2.9.0 on a SuperMicro P4SCT+II
seems to produce the same bus problems reported elsewhere (intel boards,
I think).

The symptom is repeated log messages like
  PCI device 8086:25a4 (Intel Corp.): Reset failed! (01)
  eeprom.o: block read fail at 0x00!

The problem does NOT show up on a couple of Tyan boards I have
available, one a S2707 Trinity GC-SL and another of unknown ID (but it
has an ServerWorks CNB20LE northbridge and OSB4 southbridge if that's
any help)

I tried mhoffman's patch in 
 http://archives.andrew.net.au/lm-sensors/msg29196.html
and it regularly hits the 'timeout >= MAX_TIMEOUT' branch.

.jim
