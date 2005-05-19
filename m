From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: [PATCH] Fix for i2c-piix4 with on some boards
Message-Id: <20030815001504.33a1fcb4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030811181001.GE807@ip68-0-152-218.tc.ph.cox.net>
In-Reply-To: <20030811181001.GE807@ip68-0-152-218.tc.ph.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Take Tom's original patch and then change the wording to what he just
> said.  My patch will not apply to 2.4 due to the dev_info() change I
> have made.

OK, patch commited. I took the liberty to change "temp = temp & 0xfd"
into "temp &= 0xfd".

I'll test it on my piix4 chipsets tomorrow (no time left tonight).

Thanks Tom for the patch!

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
