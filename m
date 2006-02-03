From: Uwe_Zeisberger@digi.com (Uwe Zeisberger)
Date: Fri, 03 Feb 2006 13:42:26 +0000
Subject: [lm-sensors] new [PATCH] I2C: add new rx8025 driver
Message-Id: <20060203134225.GA4398@digi.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Jean,

here comes a reworked driver (in a seperate e-mail to ease applying it).
I didn't implemented all your suggestions, as commented below.

I didn't (yet) used Alessandro's rtc core as it doesn't compile on
current HEAD.  (Moreover my driver has to work on 2.6.12.5, because
that's the version our customer has to stick to.)

You told me not to initialize a static global to NULL explicitly, I
thought about it and prefer to state this assumption just to make it
clear that I assume it to be zero.

Still open: I don't know if the mutex is needed.  I didn't see it in
other drivers but in my eyes it must be there.  Any comments?

I didn't switch over to smbus as you said in your follow-up mail[1].

I hope I catched all the remaining points to your satisfaction.

Best regards
Uwe

[1] Message-Id: <20060203101642.167cb18c.khali at linux-fr.org>

-- 
Uwe Zeisberger
FS Forth-Systeme GmbH, A Digi International Company
Kueferstrasse 8, D-79206 Breisach, Germany
Phone: +49 (7667) 908 0 Fax: +49 (7667) 908 200
Web: www.fsforth.de, www.digi.com

