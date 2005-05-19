From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: Ticket #1851
Message-Id: <20050101001205.6b2a44d3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <41D5D075.4000200@paradyne.com>
In-Reply-To: <41D5D075.4000200@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> anybody see how to get a divide by zero in 2.6 adm1026 set_fan_1_min()
> ??? It looks fine to me...
> 
> <http://secure.netroedge.com/~lm78/readticket.cgi?ticket51>

Easy. Try setting fan1_min or fan1_div before ever *reading* from the
sysfs files. The update fonction not having been called, fan_div[0] is
equal to 0.

Justin, can you confirm and provide a patch to fix the issue?

I also wonder if the 2.4 driver has the same problem. I would say it
does, but the ticket specifically names the 2.6 version.

-- 
Jean Delvare
http://khali.linux-fr.org/
