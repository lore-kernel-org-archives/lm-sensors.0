From: jaszkows@ii.pw.edu.pl (Dariusz Jaszkowski)
Date: Thu, 19 May 2005 06:24:31 +0000
Subject: Asus A7V600 - temperature monitoring
Message-Id: <3FF07623.6010108@ii.pw.edu.pl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The Asus A7V600 motherboard uses IT8712F chip for hardware monitoring. 
Similar to Asus A7V8X-X, the A7600 has temperatures inverted, but the 
CPU Temp needs a different conversion formula:

label temp1       "CPU Temp"
label temp2       "M/B Temp"
compute temp1     (@+128)/3, (3*@-128)

Best regards,
Dariusz Jaszkowski

-- 
Dariusz Jaszkowski  <jaszkows@ii.pw.edu.pl>  PGP 0xA15CEAAB
GCS d- s: a C+++ ULS++++$ P+++ L+++ E--- W+(-) N++ o? K+ w--(---)
O M- V- PS+ PE Y+ PGP++ t 5- X- R tv- b++ DI++ D+ G++ e+++ h r y?

