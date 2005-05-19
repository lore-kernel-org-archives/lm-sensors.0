From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: Possible bug in i2c-nforce2
Message-Id: <20031126205657.3f965e47.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans-Frieder,

Recent failure reports with the i2c-nforce2+eeprom combination led me to
the conclusion that your i2c-norce2 module might not support
i2c_smbus_write_byte() correctly. It is used in the eeprom driver and
doesn't seem to set the address register as it should.

Could you please take a look?

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
