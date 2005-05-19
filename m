From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: Data block transactions fail on i2c-i801 controller?
Message-Id: <20041207164142.GC5295@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <13938324.1095712833883.JavaMail.root@scooter.psp.pas.earthlink.net>
In-Reply-To: <13938324.1095712833883.JavaMail.root@scooter.psp.pas.earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi MDS, David:

* Mark D. Studebaker <mds4@verizon.net> [2004-12-07 10:14:54 -0500]:
> wow, a week turned into 2 1/2 months :)
> sorry for the delay.
> 
> There is no problem in the i801 block code.
> The bug is in the lm93 driver. 
> There is no check for success in lm93_read_block().
> Therefore every block transaction is called 5 times (MAX_RETRIES).
> What should have been 9 transactions turned into 45.
> Rather obvious from the logs (which are still at the link David posted - 
> thanks David).
> I'll fix lm93.

Yikes.

Yes it is obvious.  I'm eating my foot as I type this... or as my boss would
say, working on a case of athlete's tongue. :)  I'm sorry about that Mark -
thanks for fixing it.

David: please let us know how that works out when you get the chance.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
