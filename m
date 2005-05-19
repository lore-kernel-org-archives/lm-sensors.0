From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: unknown eeprom type (65) [ticket #1449]
Message-Id: <20031126215018.02c72648.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1069703037.8309.4.camel@localhost>
In-Reply-To: <1069703037.8309.4.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I'd like the two folks with the problem (or anybody else with a
> nforce2) try the new i2cdump in cvs to confirm.
> if 'i2cdump 0 50' works but 'i2cdump 0 50 c' fails then the problem
> is in the amd756 driver.

Bill, Fernando, if you please could get i2cdump from CVS and give it a
try... Thanks.

> Actually, if anybody has an amd756/66/68 then they could try this too.
> Maybe the nforce2 acts a little differently...

I think you're mixing things up. The i2c-amd756 driver covers the
nforce (1), not the nforce2. I2c-nforce2 is a different driver.

> Write quick doesn't have any data at all, other than the
> single read/write bit at the end of the address byte.

Interesting. So basically it is just meant to check wether someone would
acknoledge the address or not?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
