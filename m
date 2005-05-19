From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: ATI i2c bus driver
Message-Id: <20040102115144.219b5579.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Any reason why we don't have a i2c bus driver for ATI video adapters?
Looks like all other brands are supported (Voodoo and S3 in lm_sensors2
CVS, Matrox in kernel and Nvidia by the rivatv project) but not ATI. I
do own such an adapter (actually my laptop's video chip) and plan to buy
another one for my desktop system soon. I'd enjoy playing with their I2C
busses if they do have one.

Where should I start if I want to write a new bus driver for ATI Radeon
chips?

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
