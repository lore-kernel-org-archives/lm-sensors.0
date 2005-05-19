From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: ref 1501
Message-Id: <20040217211945.00b43251.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <19808.1073178613@www49.gmx.net>
In-Reply-To: <19808.1073178613@www49.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Ok, there it's kernel 2.6.2 lm_sensors 2.8.4 and all debugging options
> on

Stupid me. There is a bug in i2c-core debugging in Linux 2.6.2 (causing
the segmentation fault). Please disable debugging of i2c-core, recompile
and try again.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
