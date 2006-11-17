From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 17 Nov 2006 07:37:12 +0000
Subject: [lm-sensors] EPoX EP1308 driver progress
Message-Id: <20061117083712.366f0444.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

Any progress on your driver for the EPoX EP1308?

I found recently that Fintek makes a chip named F71882FG which has the
exact same ID as the EP1308, and the same register map as well. So it
means that the EP1308 is really only a rebranded F71882. I had one user
querying me privately for F71882FG support, which is how I discovered
that fact.

This means two things:
* Your driver would better be named f71882fg than ep1308, as the Fintek
chip is the original and the EPoX chip is the clone, rather than the
other way around.
* The same driver should support both chips with no additional effort,
which is great, as it also means broader testing.

I already updated sensors-detect to advertise both chips as being the
Fintek F71882FG, as we don't seem to have any way to differenciate
between both variants.

Thanks,
-- 
Jean Delvare

