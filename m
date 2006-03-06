From: Uwe_Zeisberger@digi.com (Uwe Zeisberger)
Date: Mon, 06 Mar 2006 07:30:09 +0000
Subject: [lm-sensors] new [PATCH] I2C: add new rx8025 driver
Message-Id: <20060306073008.GA2745@digi.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060203134225.GA4398@digi.com>
In-Reply-To: <20060203134225.GA4398@digi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean, hello list,

Jean Delvare wrote:
> > here comes a reworked driver (in a seperate e-mail to ease applying it).
> > I didn't implemented all your suggestions, as commented below.
> > 
> > I didn't (yet) used Alessandro's rtc core as it doesn't compile on
> > current HEAD.  (Moreover my driver has to work on 2.6.12.5, because
> > that's the version our customer has to stick to.)
> 
> True, but if we merge your driver in the main Linux tree, it'll happen
> at best in 2.6.17-rc1 so the version we'll merge will not be compatible
> with 2.6.12.5 anyway. You must have noticed that the i2c subsystem had
> a few minor changes in the last few Linux releases. So, given that you
> will have to maintain a separate version for your customer anyway, we
> better make the merged driver comply with the latest standards.
Maybe I need still more time to investigate there.  I'm planning to
rework all our Linux code for the NetSilicon platform and submit it.
Now the code is running on 2.6.15.3, but it's a big mess.  I'd prefer
testing on that new implementation.  So it came in handy that I don't
have maintainer duties.  Moreover the board with that chip is currently
at the customer's.  So I plan to resubmit a reworked driver when I
finished the rework of our platform here.

Best regards
Uwe

-- 
Uwe Zeisberger
FS Forth-Systeme GmbH, A Digi International Company
Kueferstrasse 8, D-79206 Breisach, Germany
Phone: +49 (7667) 908 0 Fax: +49 (7667) 908 200
Web: www.fsforth.de, www.digi.com

