From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: problems with supermicro X6DHE-XG2
Message-Id: <20050330204924.473682ce.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1112204227.6784.31.camel@bart>
In-Reply-To: <1112204227.6784.31.camel@bart>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Federico,

> It seem to be the National 87427 Super I/O chip.
> http://www.national.com/pf/PC/PC87427.html May be?

Yes, could be. Unfortunately the datasheet is somewhat incomplete, we
can't write a driver from this. We'd need National Semiconductor to
provide mode documentation.

-- 
Jean Delvare
