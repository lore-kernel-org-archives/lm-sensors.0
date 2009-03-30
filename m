From: badarbo <badarbo@hotmail.it>
Date: Mon, 30 Mar 2009 07:23:13 +0000
Subject: [lm-sensors] Module it87 not loading
Message-Id: <20090330092313.5db8acd2@pantagruel.manuelito.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
today the module it87, which always loaded and worked without problems, stopped loading giving this message:

FATAL: Error inserting it87
(/lib/modules/2.6.24-23-generic/kernel/drivers/hwmon/it87.ko): No such
device

I didn't change anything in my software-hardware setup since yesterday, when it still worked, so I don't have a clue. The only "particular" thing is that today, when turning on the pc, ubuntu (hardy) did a fsck (with no problems).
I wonder if manually creating the missing device would solve this, but I dont't know how to do it.
Thanks for any suggestions, bye

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
