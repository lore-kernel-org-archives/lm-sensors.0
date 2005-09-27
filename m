From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 27 Sep 2005 09:46:03 +0000
Subject: [lm-sensors] [PATCH] fix SW PEC for write byte data
Message-Id: <UoHUXn10.1127806597.6190400.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <200509240819.AA01317@k7.kit.hi-ho.ne.jp>
In-Reply-To: <200509240819.AA01317@k7.kit.hi-ho.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Mark, all,

On 2005-09-26, Mark Studebaker wrote:
> PEC really used for block transfers (including ARP and the IPMI-over-I2C),
> not familiar with any chip using it for single bytes.

Maybe the overhead in the case of short transactions frightened
designers. Nevertheless, I have an ADM1032 evaluation board, and the
ADM1032 is supposed to support PEC. I tried i2cdump in "bp" mode and
it failed, but I guess this isn't surprising with Hideki reporting
read_byte and read_byte_data w/PEC being broken. At least this should
help me test any fix (or rewrite) I may do on software PEC support.

--
Jean Delvare
