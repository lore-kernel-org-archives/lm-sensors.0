From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:13 +0000
Subject: sensors-detect segmentation fault.
Message-Id: <20030823215846.7f3b2999.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <OF2A643F2F.52CE6915-ONC1256D86.0058E32A-C1256D86.005966AD@nl.ibm.com>
In-Reply-To: <OF2A643F2F.52CE6915-ONC1256D86.0058E32A-C1256D86.005966AD@nl.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I checked and the i2c-viapro.o file is standard delivered with my
> current kernel: 2.4.20-19.9

That's what is bad. You *need* to use an AT kernel if you want to be
able to use lm_sensors 2.8.0. Regular Red Hat kernels won't work, as you
see.

All other problems you mentioned will probably solve by themselves as
soon as you have the right kernel.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
