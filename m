From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: SAA1064 sensors chip driver
Message-Id: <20030718104253.760a4212.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307131153.24333.sascha@akv-soft.de>
In-Reply-To: <200307131153.24333.sascha@akv-soft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Maybe you'll do something for sensors-detect?

Done. Please checkout and test! I expect it to return a confidence value
of 7 if the device was just powered up, and 4 if not. In any case, it is
greater than the confidence 1 returned for the PCF8574A so
sensors-detect should tell you to use the saa1064 driver.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
