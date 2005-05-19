From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: We will port w83792d.c to linux-2.6
Message-Id: <Pine.LNX.4.58.0503240937470.20694@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello

> Since our 792 Windows driver has been proved/test work well,
> I suggest that the i2c-ali1563 driver remove the HST_STS_DONE related check
> so that our 792 linux driver can work.

I'm sorry I cant give you authoritative answer. But from my point of
view it is not good strategy. I simply do not like "lets do something and
hope it worked)

Jean? MDS? Patrick? Philip?

I would like really to know if SMM code is talking to the bus same time.
If so, then it would explain a lot. And if we now how it is working, we
might find some more clean solution.

Regards

Rudolf
