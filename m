From: christophe.dr@free.fr (christophe)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: lm_sensors-2.8.6 for asus p4c800 (w83627thf) on mandrake10.0 (kernel
Message-Id: <200407251519.17699.christophe.dr@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

sensors-detect generates a wrong module to load in /etc/sysconfig/lm_sensors : 
module should be w83781d instead of w83627hf.
Everything is explained in these threads :
http://www.linuxquestions.org/questions/showthread.php?s=&threadid 4617&highlight=asus+p4c800+sensors
http://www.linuxquestions.org/questions/showthread.php?s=&threadid 3987&highlight=asus+p4c800+sensors
But there is still a problem with the w83781d that does not get any fan 
speed...
Thank you for lm_sensors. Very helpful and efficient on many motherboards.
