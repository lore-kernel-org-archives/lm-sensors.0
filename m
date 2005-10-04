From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 04 Oct 2005 23:46:33 +0000
Subject: [lm-sensors] Patch for i2c-elektor driver
Message-Id: <20051004234507.1ea0b3ec.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <eeae3ce2cd160ac835fcb05bb9a2d829@lizardlogic.co.uk>
In-Reply-To: <eeae3ce2cd160ac835fcb05bb9a2d829@lizardlogic.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Oh, BTW...

> +#if __alpha__

This really should be #ifdef __alpha__, else I get a warning at
compilation time (due to -Wundef which was recently added to the build
system).

Thanks,
-- 
Jean Delvare
