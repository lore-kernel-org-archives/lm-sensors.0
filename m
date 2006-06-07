From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 07 Jun 2006 21:06:55 +0000
Subject: [lm-sensors] [PATCH] W83627EHF driver update
Message-Id: <44873FEF.3070106@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4485CB7A.9050209@sh.cvut.cz>
In-Reply-To: <4485CB7A.9050209@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

> I like the added mutex locking. It's a good idea. It sounds like
> you'll be modifying it a little?

I hope not.

There is just a place that Jim mentioned with the lock in both branches of if.
It is not elegant, but without more temporary variables or multiple lock/unlock 
it wont simply work as expected.

Thanks for the testing. If you have better idea how to handle the particular 
place it would be good.

Otherwise if Jim has not any ideas I would like Jean to accept it as it is.

Thanks,
Regards
Rudolf


