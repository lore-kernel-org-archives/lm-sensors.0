From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Fri, 28 Oct 2005 05:24:35 +0000
Subject: [lm-sensors] smsc47b397 bug in libsensors?
Message-Id: <20051028032419.GB3981@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <t4IcaqD3.1129621770.0445230.khali@localhost>
In-Reply-To: <t4IcaqD3.1129621770.0445230.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2005-10-18 09:49:30 +0200]:
> I noticed that the smsc47b397_features table in lib/chips.c is not zero
> terminated. It should be, right?

Fixed, thanks.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

