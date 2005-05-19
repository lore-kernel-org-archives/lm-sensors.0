From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: sensors.conf database
Message-Id: <20040624194616.5d82c09d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <42212A45-C5EC-11D8-9B30-000A9599507E@pixelchaos.net>
In-Reply-To: <42212A45-C5EC-11D8-9B30-000A9599507E@pixelchaos.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I thought we might "steal" the DSDT reprository form acpi.sf.net
> Just replace dsdt with our sensors conf files.
> 
> And for each release export this database to tar.gz.
> 
> What others think ?

I definitely agree with Ruik here, providing someone really takes the
time to implement it.

Denken, I think that your solution, although nice from you, is not
bearable in the long term. Basically it relies on you handling all
requests manually. I don't think you'll find it pleasant anymore after a
few month, and chances are that you'll give it up. So the solution Marek
proposes seems to be better because it does require minimal
maintainance, the users themselves doing the work.

That said, I wouldn't mind using your solution until something more
automated is implemented, as long as you enjoy manually handling user
requests.

-- 
Jean Delvare
http://khali.linux-fr.org/
