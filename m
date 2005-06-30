From: david.knierim@gmail.com (David Knierim)
Date: Thu, 30 Jun 2005 16:38:47 +0000
Subject: [lm-sensors] LM93 PWM polarity bit "flips" state
Message-Id: <84ab3f2e05063007382e7e8f86@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

We have a bunch of servers based on the Intel 7520 chipset with
ESB6300 south bridge (which is capable of block transfers).   The
server uses an LM93 and an LM87 for sensors.

The servers are all running the sernsors and i2c version 2.9.1.  The
OS is CentOS 3.4, which is basically Red Hat Enterprise Linux 3,
update 4.

We have a diagnostic suite based on CTCS
(http://sourceforge.net/projects/va-ctcs/) with some additional tests
for sensors added.  One of these tests changes the PWM settings of the
LM93 and verifies that the fan speeds change.

When running this test, occationally the PWM polarity bit "flips"
state.  Once this happens, the fans change speed, but not in the
direction that is intended.   If the test is run long enough, the
polarity bit that is wrong will usually flip back to the correct
value.  The changing of the polarity bit status seems to be random. 
However, it does not seem to occur if the server is not heavily loaded
(or it takes much longer to occur).

Changing the bit using i2cset works and will cause the test to work
correctly again.

The lm93 driver is loaded using the disable_block=1 option.  I can
retest using block mode if it is felt that this may help isolate the
issue.

I am concerned that this issue is a symptopm of a larger problem.

This problem has been observed on at least 6 different servers, so
it's not just a hardware issue with a single server.

I'm also unsure how to proceed.   Any suggestions??

Thanks,
   David
