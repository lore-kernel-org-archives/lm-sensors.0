From: Carsten Emde <C.Emde@osadl.org>
Date: Mon, 17 May 2010 09:41:36 +0000
Subject: [lm-sensors] [PATCH 0/2] hwmon: Update coretemp to current Intel
Message-Id: <20100517094136.094800562@osadl.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100510035031.GD9181@owl> <20100514065808.GA11598@owl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jean Delvare <khali@linux-fr.org>, Huaxu Wan <huaxu.wan@intel.com>, Carsten Emde <C.Emde@osadl.org>, LM Sensors <lm-sensors@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>

Hi!

Here comes the current version of the coretemp patches. Huaxu did the initial
work; Jean suggested to submit them directly to Andrew.

I made some style changes as advised by checkpatch.

The patches have been tested successfully on Core 2 Duo and Quad, and on
Nehalem and Nehalem/Westmere where temperature readings were plausible and
changed with load as expected. When tested on an Atom processor (N270), the
temperature values were identical to previous versions of the coretemp
module and also changed with load. However, the readings should be higher
by 10 to 15C as compared to the outside temperature of the processor. Huaxu,
could you check? I would guess TjMax to be 105 instead of 90C in these
processors.

        Carsten.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
