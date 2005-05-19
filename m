From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: Conversion guide for i2c chip drivers
Message-Id: <20031005113722.626f30b8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030927122451.191bb291.khali@linux-fr.org>
In-Reply-To: <20030927122451.191bb291.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> "porting-chip-drivers-2.4-to-2.6"?  Why make it short?  :)

Because all our other docs have short names. And I usually avoid names
longer than 23, to keep "ls -l" happy. I could place the document in our
doc/chips subdirectory and name it "PORTING-2.6". BTW, I don't think the
busses and chips documentation is included into Linux 2.6.0-testX. Is it
on purpose (users will want to download lm_sensors for at least
sensors-detect anyway)?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
