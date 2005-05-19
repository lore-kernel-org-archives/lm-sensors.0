From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:59 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc4 15/15]
Message-Id: <e9iUj0EZ.1116327879.1515720.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <2538186705051703479bd0c29@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: yani.ioannou@gmail.com
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>


Hi Yani,

> Again I'd prefer someone test this particular patch before it be
> applied, because I haven't got an adm1026 to test it with :-).

If you could come up with an additional demonstration patch for either
the lm90 driver or the it87 driver, I would happily give it a try. The
adm1026 has very few users AFAIK so it might not be the best choice to
find testers, although I agree that it was a convenient way to
demonstrate how drivers could benefit from the proposed change.

And, once again, thanks *a lot* for looking into this, this is very much
appreciated.

--
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
