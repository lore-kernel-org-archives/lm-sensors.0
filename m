From: bgardner@wabtec.com (Ben Gardner)
Date: Mon, 15 Aug 2005 16:37:20 +0000
Subject: [lm-sensors] [PATCH] w1: add ds2433 cache (0/3)
Message-Id: <200508150937.01419.bgardner@wabtec.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Evgeniy,

Here's my last modifications to the ds2433 w1 driver.
I added caching of the data if the 32-byte block contains the recommended 
crc16 in the last two bytes of each block. 
The driver only allows writes of full 32-byte blocks if the CRC16 in the block 
is correct.
I also added a family_data member to the w1_slave structure.

Also included in this series is lib/crc16.[ch], which is modeled after 
lib/crc_ccitt.[ch]

These patches are based off the w1 patches that Greg just applied.

Signed-off-by: Ben Gardner <bgardner@wabtec.com>

