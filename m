From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:50 +0000
Subject: Sis 645DX problem
Message-Id: <20030322121021.14f8b877.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200303161357.19874.contact@haloscan.com>
In-Reply-To: <200303161357.19874.contact@haloscan.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> This is the output from dmesg:
> i2c-sis645.o: version 2.7.0 (20021208)
> i2c-sis645.o: Error: Can't find suitable south bridge!
> i2c-sis645.o: SiS645 not detected, module not inserted.
> 
> Any help would be greatly appreciated. Please email me if you need
> more information too.

I think your hardware is too recent and not supported by our driver for
now. Could you provide the output of "lspci -v" and "lspci -n"?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
