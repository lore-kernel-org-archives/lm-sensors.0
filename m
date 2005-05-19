From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:44 +0000
Subject: help lmsensors
Message-Id: <20021224093140.6b4dfcbc.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E075D5E.1070309@earthlink.com>
In-Reply-To: <3E075D5E.1070309@earthlink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> [root@localhost lm_sensors-2.7.0]# make
> grep: /lib/modules/2.4.18-18.7.x/build/Makefile: No such file or
> directory grep:
> /lib/modules/2.4.18-18.7.x/build/include/linux/autoconf.h: No such
> file or directory make: *** No rule to make target 
> `/lib/modules/2.4.18-18.7.x/build/include/linux/errno.h', needed by 
> `prog/detect/i2cdetect.rd'.  Stop.

You need to install whatever package it is for your distribution that
provides the kernel sources. We use some files from the kernel sources
to build lm_sensors, and the above messages show they were not found.


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
