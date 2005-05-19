From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:57 +0000
Subject: i2c-dev.h
Message-Id: <3ED81794.9060303@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Kyosti took 173 lines out of i2c-dev.h in the main i2c branch
because userspace shouldn't include kernel headers,
and then merged that change into the lk2-4 branch too.

But I don't recall seeing any replacement.

Is there one?
Should we undo the changes so we have working userspace utilities
again or should we create a userspace version of i2c-dev.h?

I'm not claiming the old i2c-dev.h was pretty but we need something.
