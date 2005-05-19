From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: [PATCH 2.6] I2C sysfs interface documentation
Message-Id: <20031116230820.42c13d52.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031116203250.4bce6b7e.khali@linux-fr.org>
In-Reply-To: <20031116203250.4bce6b7e.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> current is in there because the IPMI spec includes current sensors
> so I added support to bmcsensors.
> Never had a report of a BMC that actually measures current, though...

Took a look at that document, it specifies hysteresis values for all
sensor types. It even specifies two values (one for negative-going
thresholds, one for positive-going thresholds).

BMC isn't in 2.6 yet anyway, so we can safely remove references to
current hysteresis for now.

That quick look at the IPMI specification once again raised the question
of what file naming convention to choose for storing hysteresis values
in sysfs. The fact that IPMI provides space for two hysteresis values
per sensor proves that names like "temp_hyst1" (as I did in the patch I
just sent to Greg) won't be sufficent to handle all cases. I'm still in
favor of storing hysteresis as a values linked to another limit, and not
as a limit per se. That is, temp_max1 and temp_max1_hyst (or
temp_max_hyst1, or even temp_hyst_max1, whatever fits better with the
current logic). Following Mark Hoffman's views, value in these files
would be an absolute temperature, regardless of how the chipset actually
handles it.

I would like everyone to comment on that if needed. If we can agree on a
clean, logic naming convention, I volunteer to update the documentation
accordingly and modify existing drivers.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
