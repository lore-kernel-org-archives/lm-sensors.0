From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: errors in W83627THF data sheet
Message-Id: <1070890875.3fd47f7b67a64@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello,

I think I found two errors in your W83627THF data sheet (rev. 0.7), at
the top of page 32, about the -12V input:

1* The formula should read "VIN2 = ...", not "VIN0 = ...". VIN0 is +12V
according to the schematic on the previous page.

2* The resistor values are swapped. It says R3VK and R4#2K, but I
believe it has to be R3#2K and R4VK, or the computed value doesn't
make sense (not within the 0V..+4.096V range).

Could you please confirm?

If I'm right, you might also want to update your data sheet. Accurate
data sheets are very precious to us developpers :)

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
