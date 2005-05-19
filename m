From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: We will port w83792d.c to linux-2.6
Message-Id: <Pine.LNX.4.58.0503310853260.21101@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I'm sorry I'm out of ideas right now. Maybe you can modify program
eeprom.c in lmsensors package (the prog/ directory) and try to read
firts 16 bytes of EEPROM again and again if you get same results.
Or first four bytes, I think first two should not be zeros.

As from the logs I can see that the wrong values were supplied by SMBus
host controller so there is not much left.

Please can you obtain several dumps from the bus?

like:
      #!/bin/bash
      while true ; do
      i2cdump -y 0 0x50 >>eeprom
      i2cdump -y 0 0x50 >>eeprom
      i2cdump -y 0 0x2f >>winbon <=your chip adr I think is this one
      i2cdump -y 0 0x2f >>winbon <=your chip adr I think is this one
      done
(ctrl c to stop after several thousends cycles please)

Also I would like to see correct i2cdump of SAME memory module.
Maybe we can guess something from different values. So you need to
put the module to some other motherboard and perform i2cdump on it.

As for the weekend. Bad luck with me. I will go to mountain cottage
so I will be offline. (but I can take the dumps to my notebook and
study them when I will have some time :) Today and tomorrow I'm busy
with programming school stuff. But of course I will find like hour or so
to think about it :)

Regards

Rudolf

