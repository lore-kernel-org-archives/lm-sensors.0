From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: lm77 on national sc1100
Message-Id: <20040702035002.GA30896@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <1088690691.2862.25.camel@null>
In-Reply-To: <1088690691.2862.25.camel@null>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2004-07-01 23:19:29 +0200]:
> OK, I added support for the LM77 to sensors-detect and refined the LM75
> detection.
> 
> Mark, please test and confirm that your LM75s are still detected as
> such (with confidence at least 4).

Exactly 4 for both.  BTW it also claimed this, which is probably expected...

Chip `Maxim MAX6633/MAX6634/MAX6635' (confidence: 2)

> Andras, please test and confirm that your LM77 is correctly detected as
> a LM77 (with confidence at least 3).
> 
> If it works OK, we will have to do similar changes to the lm75 driver.
> 
> I'm still not sure whether we want to do a separate lm77 driver or not.
> The two chips are definitely not compatible but handling both in a
> single driver gives more control over detection.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
