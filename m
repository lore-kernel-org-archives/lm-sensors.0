From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 04 Jun 2005 17:37:31 +0000
Subject: [lm-sensors] RE: Fix one bug of w83792d under linux-2.4
Message-Id: <20050604173806.264f7575.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE54FCB2@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE54FCB2@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Chunhao,

> > OTOH, there are true alarm registers at registers 49h, 4Ah and 4Bh.
> > These show the realtime comparison result for all channels, not only
> > the temperatures. And these do not require to reconfigure the
> > interrupt mode for the temperatures.
> 
> I think you are meaning A9h, AAh and ABh, instead of 49h-4Bh.

Oops, yes, absolutely. My bad.

-- 
Jean Delvare
