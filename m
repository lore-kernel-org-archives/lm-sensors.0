From: David Highley <dhighley@highley-recommended.com>
Date: Tue, 04 Oct 2011 15:38:39 +0000
Subject: [lm-sensors] EVGA 132-BL-E758 motherboard, chip F71882FG
Message-Id: <201110041538.p94FcdZI008229@douglas.highley-recommended.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This question may have been asked before, but I have not found the
answer so far. It appears that a kernel change since version 2.36.1 is
now blocking by default the monitoring/probing of this board and
indicates that a driver should be used. I have not found a driver, but
the lm-sensor information lists a driver, LPC, for the chip F71882FG. So
I'm trying to understand why I still need to add
apci_enforce_resources=lax to get monitoring to work.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
