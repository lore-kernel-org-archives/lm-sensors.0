From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: Issues with lm_sensors on Intel SE7501cw2
Message-Id: <20031022231213.7fd5ccbb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <9D8C1A43309BAD4A9B46071DAF911D9E3E237D@exch01.paracel.com>
In-Reply-To: <9D8C1A43309BAD4A9B46071DAF911D9E3E237D@exch01.paracel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I agree that Super I/O detection is quite reliable and that the
> confidence for these should be increased to 9.
> Khali, feel free to do it if you get to it before I do.

Done.

That said, shoudln't the w83781d driver handle the ISA Winbond W83627HF?
That's not the first report of it being detected but not working,
although it works OK with the w83627hf driver. I know that the w83627hf
driver is prefered in that case, still we have to be consistent. If
sensors-detect says the w83781d driver can be used, it has to work.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
