From: Wolfgang Grandegger <wg@grandegger.com>
Date: Mon, 16 Feb 2009 10:11:34 +0000
Subject: [lm-sensors] DS75: 12-bit support question
Message-Id: <49993BD6.7000303@grandegger.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I have just realized that there have already been an attempt to get
12-bit support into the LM75 driver:

  http://marc.info/?t0836918500008&r=1&w=4

But it's not obvious too me why it was finally abandoned. In the GIT log
I just find:

     - More careful initialization.  Chips are put into 9-bit mode so
       the current interconversion routines will never fail.

What have I missed?

Thanks,

Wolfgang.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
