From: cedric.pradalier@inrialpes.fr (Cedric Pradalier)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: Adm1030 driver
Message-Id: <20040319224106.79f6cec3.cedric.pradalier@inrialpes.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

	I use debian on an ibook (2.2) and the chip which control the fan and
monitor temperature is an adm1030. I made a little kernel module for
2.6.4 which provides access to the chip through sysfs (temperature
reading and read/set the parameter of the integrated fan control
algorithm). I've seen that this chip driver is in development and I
wonder if my driver can help. 

Please let me know.

-- 
Cedric

"[Of course] I'm French! Why do think I have this outrageous 
accent, you silly king-a?!"  Monty Python and the Holy Grail
