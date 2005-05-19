From: kmalkki@cc.hut.fi (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: ACPI and lm_sensors interaction
Message-Id: <Pine.OSF.4.50.0301161450170.16986-100000@kosh.hut.fi>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Issues to discuss, and put on TODO:

ACPI and SMBus host
 - ACPI subsystem may access SMBus host too. Locks?
 - On my ancient board using i2c-via, suspend and power switch status
   seems to be in the same register with SCL and SDA.

Suspend-to-disk, losing Vcc
 - Reset i2c client to avoid alarms and SCI interrupts. Currently
   sensors do not create interrupt with alarms.

Return from suspend
 - Reinitialize i2c client.

-- 
  Ky?sti M?lkki
  kmalkki@cc.hut.fi
