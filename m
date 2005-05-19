From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: no sensors found! with 2.6.0 kernel
Message-Id: <20040110111200.6635b5df.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040109220819.F0E2E3945@sitemail.everyone.net>
In-Reply-To: <20040109220819.F0E2E3945@sitemail.everyone.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> thanks for the quick reply. i patched the kernel to 2.6.1 and
> recompiled it, and now w83781d is detected and loads, but still the
> sensors do not work. 

You forgot to load i2c-isa. OTOH it seems that you don't have to load
i2c-nforce2, it's unused.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
