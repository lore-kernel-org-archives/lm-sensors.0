From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: PC87366 support
Message-Id: <3CB34C1F.62A1207E@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020409180707.GK1677@irn-bru>
In-Reply-To: <20020409180707.GK1677@irn-bru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

We haven't looked at the datasheet closely and so we can't really say.
Generally the coding and testing is straightforward after
we get a board to work with.
mds

Andrew Greig wrote:
> 
> Greetings,
> 
> Firstly, you guys are doing a great job with the development of i2c and
> lm_sensors, this project really seems to be progressing.  It sure make
> life easier for the rest of us that you've already done so much work in
> this area.
> 
> Anyway, I've been trying to get sensor data from a system known as a
> Quanta, with a CP810E-FL motherboard, that features a (you guessed it)
> Intel 810E chipset.  According to the motherboard manual, it has a
> National Semiconductor PC87366 Super I/O controller that among other
> things does temperature and voltage monitoring.  The lm_sensors new
> drivers page lists this chip as having no planned driver.  I don't think I
> have the skills to volunteer to write one, but I am curious about how
> difficult it would be for this chip to be supported.  Is it greatly
> different to any of the other chips you have drivers for?
> 
> Thanks for your time.
> --
> Andrew Greig - Technical Support
> Internet Business Services Ltd.
> Beta Centre - Stirling Innovation Park - STIRLING - FK9 4NF - United
> Kingdom
> (tel) +44 (0)1786 451600  (fax) +44 (0)1786 451274  (web) www.mezzonet.net
