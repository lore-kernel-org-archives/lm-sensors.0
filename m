From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: driver initialization of chips
Message-Id: <20031115120926.596368a7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FB5ADC8.A055A6E5@paradyne.com>
In-Reply-To: <3FB5ADC8.A055A6E5@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I'd like to modify all the drivers to not initialize the chips unless
> there's an init=1 argument (i.e. init=0 is the default).
> I know there's been some who favor this change...
> comments?

I'm in favor of this, although I never took the time to change all the
drivers. Please take a look at the following thread:
  http://archives.andrew.net.au/lm-sensors/msg04549.html
Quite a long thread, I now, still this expresses the opinion of some of
us about the topic, so it might help you.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
