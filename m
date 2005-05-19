From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: w83792d_driver-1.0.1.patch: Winbond W83792D driver for
Message-Id: <20050315212422.30614070.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE245CA3@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE245CA3@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Chunhao,

> I noticed the subclient registration when I started to write 792
> driver, I'm not
> familiar with subclient and sent lm_sensors group a mail for your
> introduction
> about it about several month ago, but do not receive any response.
> Since I'm not familiar with it, I discard it just like the other chip
> drivers:
> lm90.c and lm83.c, finding it can work well.

Just a couple clarifications:

1* Not all chips have subclients, in fact most haven't, only Winbond
chips and Asus clones have.

2* In our current implementation, subclients are registered only to
prevent other drivers to use them. They are not accessed by their
address (the same functions are available from the main address).

-- 
Jean Delvare
