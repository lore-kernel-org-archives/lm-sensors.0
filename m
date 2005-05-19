From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: lm_sensors/i2c for Red Hat Linux flavours
Message-Id: <20040110174126.4c30cf31.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040107224757.GB11093@neu.nirvana>
In-Reply-To: <20040107224757.GB11093@neu.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Thanks! There are also kernel, userland & kernel modules for Fedora
> Core 1 (FC1), Red Hat's former version 10.

Oh OK, sorry I had missed it at first. I've updated the news item to
reflect that.

> Will the next release (2.8.3) which is mainly for 2.6.1 support be
> compatible with i2c 2.8.3 (i.e. is it enough for me to build kernel
> modules only, or should I prepare for new kernel releases?)

I guess you mean "compatible with i2c 2.8.2". Theoretically it isn't,
since i2c 2.8.3 offers new protocols, but since they aren't used in
lm_sensors (nor anywhere else as far as I know), I think you can just
consider it is compatible, and go for a lm_sensors only release.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
