From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:07 +0000
Subject: smsc47m1 ported to Linux 2.6
Message-Id: <20040731114734.16c911f4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040720225853.6f67122b.khali@linux-fr.org>
In-Reply-To: <20040720225853.6f67122b.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I finally got hands on that system, which appeared to be D815EEA, not 
> D815EEA2

I don't think this makes much difference, does it?

> It has only one fan (CPU) connected to fan3. Fan1 and fan2 are not 
> connected (according to labels on motherboard). however, fan3 is
> 3-wire. I do not know what else I could test as testing fan1 and fan2
> imo makes no sense.

Labels on the motherboad do not necessarily match those of the SMSC chip
(which is what lm_sensors use), but the 0 readings suggest that fans 1
and 2 on one side are 1 and 2 on the other side (exact matching
unknown), i.e. fan 3 (as labeled on your motherboard) is not monitored,
and most probably not controlable either.

If you have a spare 3-wire fan, you can just plug it into either fan 1
or 2 (as labeled on your motherboard) and see what happens. If not,
well, I guess that your testing is over.

Thanks.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
