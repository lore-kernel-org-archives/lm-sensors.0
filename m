From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: bug : mkdev.sh creates devices that sensors-detect cannot use
Message-Id: <20040711204810.1232a0d5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040708184144.4554439e@pegasus.ucs.co.za>
In-Reply-To: <20040708184144.4554439e@pegasus.ucs.co.za>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> >When I insmod i2c-viapro, devfs doesn't create any new devices.

Just had a similar problem today, with the same driver (i2c-viapro). Are you by any chance using any of 2.6.7-mm3, -mm5, -mm6 or -mm7 as your kernel, and are using ACPI?

Thanks.

-- 
Jean "Khali" Delvare
http://www.ensicaen.ismra.fr/~delvare/
