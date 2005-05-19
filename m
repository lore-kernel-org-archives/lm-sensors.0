From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:46 +0000
Subject: Call for 2.9.1 soon
Message-Id: <20050327111430.4fff96fa.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <42374C41.8000401@mds.gotdns.com>
In-Reply-To: <42374C41.8000401@mds.gotdns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

> > > Khali mentioned i2c_adapter incompatibilities to be fixed.

On second thought this requires discussion (and not an easy one) so it
should be left for later. This is not a major issue (this is about
binary compatibility, not source copatibility).

> > Fix I2C block reads in i2c-i801?
>
> would be nice but AFAIK MMH is still stuck, couldn't get it to work.

OK so let's keep the stuff ifdef's out for now, fine with me.

> Everyone please test everything and review the docs.
> Let's release mid-late week.

Wow, that's a long time since I last saw you so motivated :) Good to
see.

Ruik and I searched the recent 2.6 changes for things to backport and
found quite some. I'll commit them today.

Thanks,
-- 
Jean Delvare
