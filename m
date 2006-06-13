From: laurent.pinchart@tbox.biz (Laurent Pinchart)
Date: Tue, 13 Jun 2006 08:49:04 +0000
Subject: [lm-sensors] Philips LM75A
Message-Id: <200606131049.05054.laurent.pinchart@tbox.biz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi everybody,

I tried to use the LM75 (temperature sensor) driver with a Philips LM75A.

The LM75 driver tries to identify the chip using a heuristic based on 
non-implemented registers:

- The LM75 ignores the 5 high address bits, register i is can thus be read at 
i+n*8 (0 <= i <= 7; n < 32). This is true for the LM75A as well.

- Reading unimplemented registers 0x04-0x07 from the LM75 returns the last 
read value. The LM75A returns 0xff.

Here is a patch (against 2.6.17-rc6) which modifies the unused addresses test 
to accept 0xff as 
valid values.

Laurent Pinchart
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm75a.diff
Type: text/x-diff
Size: 1646 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060613/7290691f/attachment.bin 
