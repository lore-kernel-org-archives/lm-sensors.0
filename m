From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:38 +0000
Subject: i2c-2.6.4 in kernel 2.5.32
Message-Id: <20020830005251.2b25d3d8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3D6D80CA.4373486@paradyne.com>
In-Reply-To: <3D6D80CA.4373486@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> BTW- Mark, have you had a chance to play with a sample of that chip 
> yet?  Also, it sounded like DMI detection was nearly complete?

I did the work for sensors-detect, and it is supposed to work. Testers
welcome.

Anyway, I may have an even better way of detecting IBMs. There is a
memory zone near dmi anchor called "RSD PTR". It contains a 6-char
string representing the system vendor, "IBM   " in case this is an IBM
system. This is really easy to detect. Thus, I would not need to call
dmidecode from sensors-detect, which means we wouldn't need to
support/distribute dmidecode anymore (but we still need to be root to do
the test). I'll work an a perl test script and let you know when it's
ready. Maybe asking people on the thinkpad to test it then would be a
clever idea.

-- 
Jean "Khali" Delvare
http://www.ensicaen.ismra.fr/~delvare/
