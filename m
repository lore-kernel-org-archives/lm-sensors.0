From: pitt@segfault.info (Christoph Pittracher)
Date: Sat, 23 Sep 2006 14:28:20 +0000
Subject: [lm-sensors] ADT7468 support
Message-Id: <200609231628.20146.pitt@segfault.info>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello list,
what's the state in supporting the ADT7468 chip? I've got a Tyan mainboard 
using this one and tried the lm85 adt7463 module forcing the address.
I get valid FAN values (the voltage values seems ok too) but the temperature 
values are completely wrong.

Is there ongoing support for the ADT7468? Anybody working on it?
Should I try to hack a driver myself? If yes, patching the lm85 driver or 
writing a completely new one?

regards,
Christoph

