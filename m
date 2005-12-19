From: gardner.ben@gmail.com (Ben Gardner)
Date: Mon, 19 Dec 2005 18:48:12 +0000
Subject: [lm-sensors] [PATCH 0/7] i2c: scx200_acb - cleanup and add cs5535
Message-Id: <808c8e9d0512191048sec4f9c9pc799ba10cebcbb68@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Clean up the scx200_acb driver and add support for the AMD CS5535/CS5536 chips.

The series goes like this:
1. Whitespace and comment cleanup
2. debug log cleanup
3. refactor/simplify code (no functional changes)
4. remove use of lock_kernel()
5. Add support for the CS5535/CS5536
6. Fix and speed up the poll loop
7. Minimal documentation update

Signed-off-by: Ben Gardner <bgardner at wabtec.com>

