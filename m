From: dirkleni@rendo.dekooi.nl (Franssens)
Date: Thu, 19 May 2005 06:23:47 +0000
Subject: gl518sm
Message-Id: <000e01c2ccef$228d97b0$0300a8c0@ZYNTH>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020205121432.I19496@Stimpy.netroedge.com>
In-Reply-To: <20020205121432.I19496@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'm having quit some difficulties with lm-sensors.
Everything, including installing and compiling worked great,
but now it doesn't seem to recognize my gl518sm detectors.
when I modprobe that module,
and then perform a "sensors -s", it says; no sensors found!.
But it really IS listed on your supported hardware page.

some help:
motherboard: FullYes (82440lx), pentiumII 300HMz, 96MB RAM.

lsmod:
Module                  Size  Used by
gl518sm                 8096   0  (unused)
i2c-proc                6064   0  [gl518sm]
i2c-dev                 3712   0
i2c-core               13328   0  [gl518sm i2c-proc i2c-dev]

the problem was, that sensordetect did not detect that gl518sm,
but a piix4 an an eeprom.
The only output sensors would give me then, was some info from eeprom,
NOT voltages or fans etc.
then I manually tried to modprobe gl518sm, with success. (as you can see)
but unfortunately;
sensors -s now says: no sensors found!

can you help me?

thnx!
Anne
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030205/8b1179f3/attachment.html
