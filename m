From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: lm77 on national sc1100
Message-Id: <20040702235508.50278696.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1088690691.2862.25.camel@null>
In-Reply-To: <1088690691.2862.25.camel@null>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > I wonder if unused addresses (0x4-0x7 on LM75, 0x6-0x7 on LM77) will
> > always return the value of the last existing register (0x3 and 0x05,
> > respectively), or those of the previously read register.
> 
> It's the previously read register on the LM77.

OK, I reworked both the LM75 and the LM77 detection routines to take
benefit of that singularity. It should make detection of these chips
quite reliable now.

Andras, Mark, can you please test again? Confidence 6 is expected. Mark,
please fake the LM77 address range again, so that the test is even more
interesting.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
