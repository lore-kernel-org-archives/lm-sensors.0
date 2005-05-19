From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: Ticket 1833
Message-Id: <20041206211147.1428a870.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0412020915370.25485@boxer.fnal.gov>
In-Reply-To: <Pine.LNX.4.58.0412020915370.25485@boxer.fnal.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> The i2c address 0x2c is an alias for the super IO sensor that
> is found at ISA 0x0290 and is detected on the scan of the ISA 
> bus as well as the scan for super IO/sensors.  Those numbers 
> track exactly as I make the machine hotter and colder.
> It's the one at 0x2f which is the mystery chip.
> 
> Another examination of the file AllSuperD.ini which
> comes from Supermicro shows me that this chip is indeed a 
> W83792D chip.  Their .ini file says that, and also 
> gives me the offsets of which signal is where.

Great. Now I can update sensors-detect to put the correct ID in. I had
mixed it up with those of the W83791SD, it seems.

> How do I correlate that to what the w83781d driver thinks is 
> on a w83781d chip... i.e., how do I translate in0-in6 to their
> appropriate offsets?
> 
> In particular, the two fans I am interested in show up 
> as fan2 and fan3 at offset 29 and 2a respectively.  I have the
> information for what every offset of this chip means.  Does that do me
> any good?

It would certainly if we were not expecting a driver and datasheet from
Winbond for the next days or weeks. Trying to write a quick hack now
would obviously be a duplicate effort.

The only thing I'd suggest would be to try forcing a w83791d instead of
a w83781d. Maybe there are more similarities between these two.

-- 
Jean Delvare
http://khali.linux-fr.org/
