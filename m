From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:42 +0000
Subject: 2.7.0 testings
Message-Id: <20021202114549.2c37b67b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021127213903.5b84866d.khali@linux-fr.org>
In-Reply-To: <20021127213903.5b84866d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Khali, you fixed the makefiles and I fixed the request_regions.
> I think we're only awaiting your compile test for 2.2
> and then we're ready for release??

Sorry, I've been away for some days for a M:TG tournament. I'm back now,
and tested CVS on a 2.2(.22) kernel again. While i2c is OK, lm_sensors2
isn't.

make: *** No rule to make target `linux/bootmem.h', needed by
`kernel/busses/dmi_scan.d'.  Stop.

Actually, 2.2 kernels don't have the include/linux/bootmem.h file. As
2.4.0 does have it, the file must have been added in a 2.3 kernel.

Have to go out to buy something to eat, to be continued later ;)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
