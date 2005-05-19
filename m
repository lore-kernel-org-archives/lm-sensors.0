From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: ref 1501
Message-Id: <20040221230717.273de658.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <19808.1073178613@www49.gmx.net>
In-Reply-To: <19808.1073178613@www49.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I may have an idea to solve your problem. Please unload w83781d (while
still having i2c-ali1535 loaded) and dump the contents of your chip
(using "i2cdump 0 0x2d", adapt to your system if needed).

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
