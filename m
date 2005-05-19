From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:01 +0000
Subject: mkpatch works
Message-Id: <3EF5B5CE.6050103@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I got mkpatch working on both i2c and sensors,
both configuring as modules and compiling-in.
Please test.

A few hints:

- Follow steps in order: generate and apply i2c patch; then generate and apply sensors patch.

- As a compile test you can compile-in all drivers. But actually running that kernel takes
forever to load (bus scanning) and you hit all the driver quantity limits
(see the top of i2c.h). For easiest testing of compiled-in drivers only compile-in a few at a time.

- Don't enable bttv or other non-compatible i2c stuff in kernel.
