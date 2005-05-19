From: trini@kernel.crashing.org (Tom Rini)
Date: Thu, 19 May 2005 06:23:33 +0000
Subject: i2c patches for 2.5.15
Message-Id: <20020525183527.GC12561@opus.bloom.county>
List-Id: <lm-sensors.vger.kernel.org>
References: <3CED7BC6.99258BEB@paradyne.com>
In-Reply-To: <3CED7BC6.99258BEB@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, May 23, 2002 at 10:22:36PM -0400, Mark D. Studebaker wrote:

> Note this recent change,
> not sure what it does, this is post-2.5.17.
> Anybody understand this change?
> 
> http://linux.bkbits.net:8080/linux-2.5/diffs/drivers/i2c/i2c-proc.c@1.3?nav=index.html|src/.|src/drivers|src/drivers/i2c|hist/drivers/i2c/i2c-proc.c

This appears to be removing compatibility #ifdefs to make things more
readable (Which of course is a PITA for out-of-kernel things and
projects which still support 2.2.x/2.4.x/2.0.x) and proc
cleanups/updates.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
