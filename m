From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:53 +0000
Subject: Ticket #: 1955
Message-Id: <20050422200124.42816260.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1980615917@web.de>
In-Reply-To: <1980615917@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Christian,

> As you can see in my sensors.conf I sent along with my ticket, I tried
> this before, but just ignoring the fans don't work. I tried the
> version 2.9.1 as you suggested and the error-messages of fans 1 & 3
> disappeared, but oddly enough fan2 causes still problems.

My fault. When I fixed "sensors" I missed fan2, and only really fixes
fan1 and fan3. This explains what you observe.

You can fetch the latest version from CVS, I just committed a fix.
Thanks for reporting.

> Did you heard of someone who got an answer from Soekris about their
> resistor-network, used sensors etc. because 50?C seems a little to
> high to me for the internal thermal reading of the mio-chip.

The other report I had for a net4801 was 83 degrees, so you shouldn't
complain with 50 ;) For other PC87366 chips, temperature was between 32
and 53.

-- 
Jean Delvare
