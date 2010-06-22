From: Severin Strobl <lists@severin-strobl.de>
Date: Tue, 22 Jun 2010 16:16:35 +0000
Subject: [lm-sensors] Fintek F71889ED and Core i5 650
Message-Id: <7d5085f2fc67887ccbfebd0f0041558f@mail.blue-neutrino.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

recently I upgraded some hardware and got a MSI H55-GD65 (MS-7637) board
and a Intel Core i5 650 CPU. The board features a Fintek 
F71889ED sensor chip. From what I've gathered from the archives, there was
one request some time ago
(http://lists.lm-sensors.org/pipermail/lm-sensors/2010-May/028636.html),
but as there is no data sheet available, adapting the f71882fg driver is
not possible at the moment. So I guess until the data sheet is released
there will be no progress regarding the driver. Once this will change, I'm
more than willing to assist in testing the driver. Is there anything I can
do right now?
The other issue is the i5 650 CPU. When running kernel version 2.6.34 the
coretemp driver did not recognize the CPU at all, but with the 2.6.35-rc3
this changed. If I interpreted the changes correctly, the coretemp driver
switched from checking the CPU model to detecting special registers?
However the CPU is not recognized by sensors-detect (version 3.1.2 or svn
r5842). The kernel messages produced by coretemp using 2.6.35-rc3 are:

coretemp coretemp.0: TjMax is 105 C.
coretemp coretemp.1: TjMax is 105 C.
coretemp coretemp.2: TjMax is 105 C.
coretemp coretemp.3: TjMax is 105 C.

Is there any information on whether this is a problem with the coretemp
driver or the user space utils?

Thanks a lot,
Severin

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
