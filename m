From: linux@1g6.biz (Nicolas)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: sis5595
Message-Id: <200307161427.08403.linux@1g6.biz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello,

I am using 2.6.0-test1,
and I launched "sensors-detect",
it told me I have an sis5595.
So I began to port the 2.4.21 sis5595 driver to 2.6 kernel.
Here are the beginning of my work, but I am stuck here :
i2c_detect doesn't call sis5595_detect.

I don't know if it is because I haven't the good hardware or
if I made a mistake. I seems I have something at adress 8008, but I don't
have enougth experience in developping kernel drivers so I gived up,
and I send you my work.

Regards.

Nicolas Parpandet.

You can reply me on linux@1g6.biz

ul 15 23:41:17 hal9003 kernel: sis5595.o: version 2.7.0 (20021208)
Jul 15 23:41:17 hal9003 kernel: sis5595.o: before imposter
Jul 15 23:41:17 hal9003 kernel: sis5595.o: after imposter
Jul 15 23:41:17 hal9003 kernel: sis5595.o: after pci_read_config_word
Jul 15 23:41:17 hal9003 kernel: sis5595.o: addr 8008 force_addr 0
Jul 15 23:41:17 hal9003 kernel: sis5595.o: before i2c_add_driver
Jul 15 23:41:17 hal9003 kernel: sis5595.o: not class 2 1 0
Jul 15 23:41:17 hal9003 kernel: i2c_detect: is_isa 0
Jul 15 23:41:17 hal9003 kernel: i2c_detect: begin i2c_detect 0 to 7f
Jul 15 23:41:17 hal9003 kernel: i2c_detect: for addr 0
-------------- next part --------------
A non-text attachment was scrubbed...
Name: sis5595.c
Type: text/x-csrc
Size: 28747 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030716/beed2bbe/sis5595.bin
