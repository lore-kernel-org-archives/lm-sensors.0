From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:13 +0000
Subject: i801 bus problems
Message-Id: <20040903114750.M79098@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0409022207200.19686@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0409022207200.19686@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Does the eeprom driver works?
> 
> it seems to load

But does "sensors" then display the corresponding memory information?

> > What does i2cdump on 0,0x2e or 0,0x50 returns?
> 
> i2cdump 0,0x2e
> Error: First argument not a number!

My bad, the syntax is "i2cdump 0 0x2e" (i.e. space, not comma). "0,0x2e" was
really only a way to refer to the chip, not what had to be typed on the
command line. Sorry.

-- 
Jean Delvare
http://khali.linux-fr.org/
