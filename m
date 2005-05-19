From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: dmi_scan: exporting dmi_broken
Message-Id: <20040404211712.32e9ec6f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040119090235.GB22028@neu.nirvana>
In-Reply-To: <20040119090235.GB22028@neu.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I tried them and couldn't compile. I applied the patches to lm_sensors
> 2.8.5 and used its mkpatch to generate the kernel patch. I also
> applied the linux-2.4.22-dmi_scan.diff. Did I miss something?

Bad. That was the correct procedure...

Could you please try the kernel patch only, to start with? No
lm_sensors, only the kernel dmi_scan patch. This is independant and
should work.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
