From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: lm_sensors2/prog/eeprom Module.mk
Message-Id: <20031123152941.32bf4eab.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Update of /home/cvs/lm_sensors2/prog/eeprom
> In directory mordac.netroedge.com:/tmp/cvs-serv31752/prog/eeprom
> 
> Added Files:
> 	Module.mk 
> Log Message:
> (mds) add more programs installed in /usr/local/sbin

I can't see no reason why we install them in sbin, since regular users
can run these scripts too (decode-*.pl).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
