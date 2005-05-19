From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: High, low and crit are in a boat...
Message-Id: <20030814220049.42e1ec14.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030814183949.5d14ed41.khali@linux-fr.org>
In-Reply-To: <20030814183949.5d14ed41.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I would suggest that the critical and hyst values belong in a
> *seperate* proc entry.  The /proc entries for temperature should
> always and only be:
> 
>     high, low, current
> or
>     over, hyst, current
> 
> as appropriate to the sensor.

Thanks for the suggestion, I just did that. As a side effect, it saved
me from another problem (on the LM90, remote temp and remote tcrit have
different magnitudes).

> The whole /proc stuff is going away as Greg KH is so fond of
> repeating and with sysfs, you've only got one value per entry so
> this whole problem goes away.

Still we have to live with it until the whole universe is using 2.6.

BTW my driver is finished, I now need to update the library and sensors.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
