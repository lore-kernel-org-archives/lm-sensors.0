From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 29 Sep 2006 07:37:28 +0000
Subject: [lm-sensors] Answer Epox - EPoX EP1308 sensor-chip
Message-Id: <20060929093728.af7157d0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <450B14DB.2090505@sh.cvut.cz>
In-Reply-To: <450B14DB.2090505@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Is it still necessary to unlock the superio and if so could to explain why?
> 
> It looks like its not nescesarry as it works without it.

Well, if we write a driver for this chip, it's always better to get the
address from the Super-I/O configuration address space, rather than
hardcoding an arbitrary address. This lets us detect much more reliably
whether the device is there or not, and also lets us deal with
different addresses without user intervention.

-- 
Jean Delvare

