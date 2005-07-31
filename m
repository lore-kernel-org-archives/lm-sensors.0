From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 31 Jul 2005 20:27:05 +0000
Subject: [lm-sensors] Support for Winbond W83687THF in Lm_sensors-2.9.1
Message-Id: <20050731202629.4311c839.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050726214252.85202.qmail@web31008.mail.mud.yahoo.com>
In-Reply-To: <20050726214252.85202.qmail@web31008.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hugo,

> > You need another "else if" statement for the
> > W83687THF here, and it should be OK after that.
> 
> I got that one after I posted, still "no sensors found".

I appreciate when people follow up on the mailing-list when they were
able to solve their problem (even partly). That way we don't try to
solve problems that are already solved.

Make sure you loaded i2c-isa and i2c-proc.

Check the logs and see if at least the chip is detected when you load
the w83627hf driver.

Make sure you patched the user-space part of lm_sensors to add the
w83687thf support.

http://jdelvare.net1.nerim.net/sensors/CVS-w83687thf.diff

-- 
Jean Delvare
