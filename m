From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:13 +0000
Subject: i801 bus problems
Message-Id: <20040903104847.M55294@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0409022207200.19686@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0409022207200.19686@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > I may have jumped the gun a bit.  It looks like i801 is working but some
> > client chips are not responding or are missing?
> 
> Yes you got it :) The bus is simply not working even all modules for 
> bus and lm85 are loaded. I thought the bus is confused with autodetection
> process but it does not work even after powercycle and only lm85 
> loaded as client. The question is what to do with it? Is possible 
> somehow to change configuration of SMBUs controller, maybe it has 
> some slow devices???

Does the eeprom driver works?

What does i2cdump on 0,0x2e or 0,0x50 returns?

i2cdetect and i2cdump are really the basic tools to start with when
investigating this kind of issue IMO.

-- 
Jean Delvare
http://khali.linux-fr.org/
