From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: KT400a / VT8235
Message-Id: <20040125185407.3845c81d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1075043549.1154.39.camel@flaptop>
In-Reply-To: <1075043549.1154.39.camel@flaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> here is sensors output:
> (...)

No luck :( There's really nothing in there. Your only chance is that you
have a Super-I/O chip that wasn't supported in 2.8.1 and is supported
now. Get sensors-detect from CVS:
http://www2.lm-sensors.nu/%7Elm78/cvs/lm_sensors2/prog/detect/sensors-detect
and see if it finds something. If it doesn't, well I'm sorry but we
can't do anything for you.

The other possibility to get temperature and/or fan information is ACPI,
especially for laptops. This is how I get temperature from mine. LM
Sensors doesn't provide anything but eeproms, as it seems to be the case
for you.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
