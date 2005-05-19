From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: tickets needing help
Message-Id: <20040104103332.0111e59c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FF64825.9060808@verizon.net>
In-Reply-To: <3FF64825.9060808@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> For 2.6 kernel stuff I'd recommend pointing people to use the
> bugzilla.kernel.org system instead.

We would then need:
1* A write access to the system.
2* A way to locate the tickets related to lm_sensors. Looks like we
would search with Component=I2C, but actually the only bug that has i2c
in its body has Component=Sound, because the driver concerned, although
using the i2c interface, is a sound driver. BTW, the problem mentioned
in this ticket (#611) seems to have been solved in 2.5.71, so the bug
should be closed.

Greg, how do we proceed?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
