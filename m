From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:01 +0000
Subject: 1250
Message-Id: <20030620083543.2370c4ab.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200306021011.37032.decibel8@charter.net>
In-Reply-To: <200306021011.37032.decibel8@charter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> 2)  Installed fine. Tried several things. Still get same error. I
> restarted lm_sensors and rebooted. Still:
> #sensors -s
> via686a-isa-6000: Can't access /proc file for writing;
> Run as root?

OK, so the patch doesn't work. Or, at least, it doesn't fix *that*
problem. Philip, should we remove the fix from CVS?

Do you by any chance have any additional patch to your kernel, such as
GRSEC or ACL?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
