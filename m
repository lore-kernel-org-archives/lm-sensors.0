From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:23:53 +0000
Subject: Sis 650/961
Message-Id: <20030413141848.GA14659@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030413112035.GE1388@localhost.tiscalinet.it>
In-Reply-To: <20030413112035.GE1388@localhost.tiscalinet.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Sfilippo Filippone <sfilippone@tiscalinet.it> [2003-04-13 11:20:35 +0000]:
> Hi there,
> I got a notebook with the subject chipset (a very good notebook under any 
> other respect), and as you mention on the web site, it gets misdetected as 
> a SiS 5595. This means I cannot adjust the temperature limits, and the 
> notebook starts the fan  often and at high speed; the reading from the 
> chip is limit 51 C and hyst. 51 C which would explain the behaviour 
> (assuming the reading is correct even if the chip is detected as 5595).

SiS 650/961 is an I2C bus master only; it has no builtin sensors.
For that chipset, do not load the sis5595.c chip driver.  You must
have some other sensors chip.

Are you using sensors and i2c version 2.7.0?  Are you sure there are no
conflicting (old) sensors libraries on your system?  Does sensors-detect
find anything else?  Does your notebook maker provide any clue in docs
or on web about what sensors chip is used?

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
