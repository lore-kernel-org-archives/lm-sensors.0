From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:34 +0000
Subject: [PATCH 2.4] i2c cleanups, third wave
Message-Id: <20040111144214.7a6a4e59.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <sensors@Stimpy.netroedge.com>

I will be sending 8 patches to you, based on linux-2.4.25-pre4. They
contain cleanups for the i2c subsystem code, ported from LM Sensors' i2c
CVS repository [1]. Since that repository was also the base of the i2c
subsystem as is now in linux 2.6, one might also consider these patches
as backports from linux 2.6.

Details about what the patch does and credits will be found with each
patch.

Please apply,
thanks.

[1] http://www2.lm-sensors.nu/~lm78/cvs/browse.cgi/i2c

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
