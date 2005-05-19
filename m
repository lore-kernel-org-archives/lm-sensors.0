From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: [IMPORTANT] i2c CVS change
Message-Id: <20030725100654.212f509a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi all,

I moved the lk2-4 branch of i2c CVS to HEAD using a big patch between
HEAD and that branch, as suggested by Philip Pokorny. Not necessarily
the cleanest way but it should work. Philip Edelbrock has a backup just
in case things end up being wrong.

Everyone must stop using the lk2-4 branch. Commits to that branch will
be lost. Delete your local i2c directory and checkout a fresh copy from
CVS without specifying any branch.

I tagged the CVS (HEAD) with HEAD-BEFORE-LK2-4-MERGE right before the
operation, and with HEAD-AFTER-LK2-4-MERGE right after. It should help
us figure what happened if any problem arise.

I left the i2c-iop3xx driver untouched but commented it out in Module.mk
so that it doesn't prevent checkouts from compiling (since I guess it
won't work out of the box). If anyone is interested in fixing this
driver, just go.

Just tell me if anything goes wrong.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
