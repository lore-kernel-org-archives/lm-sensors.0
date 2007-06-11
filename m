From: "Juerg Haefliger" <juergh@gmail.com>
Date: Mon, 11 Jun 2007 18:31:11 +0000
Subject: [lm-sensors] sensor-detect and non-compliant SMSC Super I/Os
Message-Id: <191fb4ca0706111131w61cc4abfo31ba33bba90a3314@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

All,

I looked through a lot of SMSC datasheets the last couple of days with
the goal to improve sensor-detect to correctly identify more SMSC
Super I/Os. I noticed that some of the chips don't conform to the ISA
PNP standard with the device ID register living at a different address
(0x0d instead of 0x20). In order to correctly identify those chips, a
somewhat ugly (and totally SMSC specific) hack would be necessary.
Something like reading from both addresses and then using the value
from 0x0d for some of the SMSC chips.

I wonder how much value this adds given that none of these Super IOs
have HW monitoring capabilities? The only benefit I can see is that
the chip is correctly identified and we can flag it as not being a
sensor and thus users won't bug us for adding support.

Any thoughts, comments, ideas?

Thanks
...juerg

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
