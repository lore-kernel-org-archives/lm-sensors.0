From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: COMPILE_KERNEL
Message-Id: <20030806170131.107b7afb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Looks like the COMPILE_KERNEL variable in lm_sensors' Makefile has been
superseded by "make user" and "make user_install". What's more, it seems
to be broken. May I remove it completely, and any references to it in
the INSTALL file?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
