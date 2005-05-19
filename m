From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: We will port w83792d.c to linux-2.6
Message-Id: <Pine.LNX.4.58.0503241317310.20694@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I must go to school so I will answer only to one part.

I2C WRITE QUICK is used to detect the devices. It is simply a "probe"
You will just issue bus transaction, Start cond, address, and you will
wait if some device will confirm its presence. I'm not expert on this
and I think then STOP is issued and thats all.

It does not read/write anything just probing address if someone respond
on this address.

I will take a look to logs this evening.

Regards

Rudolf
