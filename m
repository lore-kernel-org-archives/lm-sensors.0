From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: pc87360 sensor-driver results
Message-Id: <20040425174214.7845d488.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <408B1888.8050802@hot.rr.com>
In-Reply-To: <408B1888.8050802@hot.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > If possible, I would like to know if the temperature readings are a
> > bug or if there is way to adjust them to display correct
> > temperatures(my bios never reads more than about 130 degrees
> > fahrenheit or about 55 degrees celcius).

Yes, there was a bug in temperatures reporting, I just spotted it. A
stupid one, as usual. It's fixed in CVS. Can you please give it a try?
I've also added alert flags clearing, so fault conditions that have gone
shouldn't show forever anymore. Please enable DEBUG (in Makefile), I've
added some debug output as well.

The improved version of isadump is there too, if the driver still
doesn't work as intended I'll tell you how to use it.

Thanks for testing.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
