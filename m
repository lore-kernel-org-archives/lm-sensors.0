From: david.c.hubbard@gmail.com (David Hubbard)
Date: Mon, 20 Nov 2006 03:48:24 +0000
Subject: [lm-sensors] W83627DHG
Message-Id: <4dfa50520611191948n5e7d40e3gac33afcfeb5dd640@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This is a summary of a conversation on irc.freenode.net #linux-sensors

Jean Delvare:
Looking at the w83627ehf driver again, I see that it is currently
based on i2c-isa, which I want to get rid of. Also, i2c-isa drivers
are a bit tricky as they use i2c structures all around the place
without a good reason. An intermediate step would be to convert it to
a platform driver. So I suggest the following plan:
1. Add support for the DHG chip.
2. Convert the driver to a platform driver.
3. Work on a cleaner super-io implementation.

Known good platform drivers are abituguru, f71805f, hdaps, pc87427 and
vt1211, but abituguru and hdaps are not super-I/O chips so they are
not good examples for you. This leaves you with 3 drivers to look at.
I'll need to convert the it87 driver to a platform driver too someday.
I could do it at the same time you do yours, so that we can share our
efforts.

David Hubbard:
#3 is the point where KMentors might be useful. Also discussed a
different plan where a separate patch would change the i2c-isa device
name to w83627dhg when that chip is detected. That plan is no good,
since it would break userspace compatibility. The device name should
be set in the same patch which adds DHG support.

Jean, feel free to correct/add if necessary.

