From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: i2c patch for 2.4.22 against 2.4.23-rc1
Message-Id: <20031115113558.3844a524.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> It applies cleanly except for bttv-if.c and tvmixer.c, which you can
> exclude from the patch, since the changes for i2c 2.8.0 and 2.8.1 are
> in the files already, they are wrapped in #ifdef I2C_PEC or #ifndef
> I2C_PEC, which is apparently only in the new i2c series...

Yes, I saw there had been some changes to these drivers. There's also a
new driver I ignore for now (w9968cf). Hopefully I'll have some time
left to update my patch someday.

I guess that parts of the patch are rejected for bttv-if.c and
tvmixer.c, still the resulting kernel tree should be working, since the
rejected parts shouldn't be needed anymore.

Thanks for the report.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
