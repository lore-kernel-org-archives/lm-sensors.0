From: Brian Dunlavey <bdunlavey@seegrid.com>
Date: Mon, 22 Nov 2010 20:14:07 +0000
Subject: [lm-sensors] W83627DHG - Writing to gpio pins?
Message-Id: <85B02441538E404DB862BA0BC9D57BBD057FE822@vmexchange01.seegrid.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have an Advantech AIMB-270 with the W83627DHG-P SuperIO chip.  The motherboard has a 10 pin GPIO header (VCC, ground and 8 IO pins).  The current w83627ehf driver supports the chip, and without doing any additional work I can read the 8 GPIO pins as digital inputs.  I'd like to write output to these pins.  Looking at the source in adm1026.c suggests this might be possible.  I suspect the proper approach would be to write a mfd driver, but I'm not sure.  Anyone out there have advice or suggestions as to where I could get help with such a task?

Thanks
Brian
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
