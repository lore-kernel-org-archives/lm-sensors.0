From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: Asus a7v266ex // lm_sensors // fan solution
Message-Id: <20030804113300.6eee445d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200308040114.06823.info@i-service.de>
In-Reply-To: <200308040114.06823.info@i-service.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> related to this part of your faq and to my motherboard Asus A7V266ex, 
> I want to report a solution for the fan settings in /etc/sensors.conf
> what actually didnt work with the default settings.
> 
> 4.17.1 Bad readings from the AS99127F!
> 
> The Asus AS99127F is a modified version of the Winbond W83781D. Asus
> will not release a datasheet. The driver was developed by tedious 
> experimentation. We've done the best we can. If you want to make 
> adjustments to the readings please edit /etc/sensors.conf. Please
> don't ask us to fix the driver. Ask Asus to release a datasheet.
> 
> - ----------------------
> 
> I tried to find out the correct settings and I've seen that the Asus
> tool for watching the sensors is using a switch fan_div 4 and I tried
> that to set for the AS99127F settings in /etc/sensors.conf

What tool are you talking about? SmartDoctor2? How could you seen the
flag there?

> What shell I say, it works and the fan speed is identic to that what
> my bios itself shows up in Hardware monitoring.

OK, great.

> CPU FAN:  2327 RPM  (min = 1328 RPM, div = 4)
> (...)
> and here is the /etc/sensors.conf:
> (...)
> set fan1_min 1800
> set fan1_div 4 			### this is what I changed so far

Well, you ask for 1800 and you get 1328, it's far from being perfect.
However, as mentioned in our FAQ, we won't try to fix the driver until
Asus releases a datasheet.


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
