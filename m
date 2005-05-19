From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: lm_sensors2/kernel/chips lm75.h lm75.c
Message-Id: <20031203034233.GB13028@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031202053341.GB19505@earth.solarsys.private>
In-Reply-To: <20031202053341.GB19505@earth.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Jean Delvare <khali@linux-fr.org> [2003-12-02 23:13:13 +0100]:
> Gave it a try on my old system with a real LM75 on it. Looks OK,
> although I did not test negative values (how would you do that??) nor
> did I do extended tests. Just seems to work :)

Thanks!  I test the negative values (actually all range of values)
by writing max and/or hyst with `sensors -s` and then reading
them back with `sensors`.  In between, I use i2cdump to verify the
register values.

No need to put your machine in the freezer. :)

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
