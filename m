From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: Problems with w83781d module
Message-Id: <20031115115643.4e237e4f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <2B6C784DD3723745978C27C72801F7F8AC80F8@cba0e2k04.cba0.centerbeam.com>
In-Reply-To: <2B6C784DD3723745978C27C72801F7F8AC80F8@cba0e2k04.cba0.centerbeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


From your sensors-detect output:

Driver `adm1021' (should be inserted but causes problems):
  Detects correctly:
  * Bus `SMBus I801 adapter at 0540' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x29
    Chip `Maxim MAX1617A' (confidence: 7)
  * Bus `SMBus I801 adapter at 0540' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x2a
    Chip `Maxim MAX1617A' (confidence: 7)
  Misdetects:
  * Bus `SMBus I801 adapter at 0540' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x29
    Chip `Maxim MAX1617' (confidence: 3)
  * Bus `SMBus I801 adapter at 0540' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x2a
    Chip `Maxim MAX1617' (confidence: 3)

I thought I had fixed that case (a driver returning both a detection and
a misdetetion for the same address) in mid-September. Could you please
double-check that the latest sensors-detect you got from CVS still does
the same? I read the code again and it really shouldn't.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
