From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:11 +0000
Subject: national sensorpath bus
Message-Id: <Pine.LNX.4.58.0408141706280.3039@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <41181309.8020806@verizon.net>
In-Reply-To: <41181309.8020806@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello

Here is the format of the bus transaction

http://www.reed-electronics.com/ednmag/filtered/pdfs/contents/images/333665fa.pdf

Some article about thermal management in PC and about buses it uses.
http://www.reed-electronics.com/ednmag/article/CA339714

Here is what is relevant:

SensorPath offloads traffic from the SMBus onto a single-wire digital bus
that's controlled by a dedicated I/O chip. The scheme accommodates as many
as seven devices per bus, each of which can accommodate three functions.
As well as temperature sensing, possible functions include system-voltage
sensing (with or without core-voltage support) and support for EEPROM
devices. Uwe Kopp, National Semiconductor's European marketing manager for
its data-conversion-systems group, explains that in common with SMBus,
SensorPath employs master/slave architecture; however, SensorPath masters
exchange data with slaves using an unusual pulse-width-coding scheme. A
"0" data bit is the shortest at 11.8 to 17.0 usec, and a "1" occupies 30.7
to 42.5 usec. A "start" bit is 63.7 to 87 usec long, attention requests
take 130 to 180 usec and reset is the longest pulse at 236 to 370 usec.
Thus, the minimum tolerance for the 360-kHz reference oscillator is more than
15% to  allow for low-cost oscillators. The maximum operating frequency of
100 kHz  retains compatibility with SMBus.

The data-exchange protocol is simple, with the master initiating a
transfer with a start bit and device number, followed by a data field.
Slaves respond with an acknowledge signal and can also signal the master
via an attention sequence (Figure A). A minimum bus-inactive period of 7.1
usec separates data exchanges. Each device on the bus senses attention
requests, which allows the protocol to negotiate and regain control in
case of bus contention. Both masters and slaves can force a reset; hence,
a single wire accommodates all data-transfer requirements. Devices can use
hard-wired addresses to save register space and die area, or respond to
programmable addresses that the master issues. In each case, the master
has to send an appropriate address to talk to a device.

Regards

Rudolf
