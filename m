From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: Call for 2.8.2 soon
Message-Id: <20031202073156.778a57a2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FC1646D.18B8555A@paradyne.com>
In-Reply-To: <3FC1646D.18B8555A@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > I have two new items on my TODO list:
> > 6* Unknown adapters in sensors.
> > 7* Addresses exclusion mechanism in sensors-detect.
> 
> let's only do 6 and 7 if they aren't very disruptive.

6 should be rather safe. 7 is a bit more complex and can be delayed
until after 2.8.2 if you want.

> And let's spend the next 2-3 days reviewing and correcting all the top
> level documentation in both packages (README, INSTALL, etc...)

Interesting proposal, I'll try to help. BTW, let's not forget i2c in the
process. I wouldn't be surprised if that part of the documentation is
also slightly outdated.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
