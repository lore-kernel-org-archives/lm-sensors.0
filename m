From: com.ea@tinet.org (com.ea)
Date: Sun, 02 Jul 2006 19:30:08 +0000
Subject: [lm-sensors] w83627hf, fan speed always high, unchangeable?
Message-Id: <0d7ga2dpkisdr8foe38ioh394sh3dqi8ft@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <43692C12.90301@gmail.com>
In-Reply-To: <43692C12.90301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


You are right, the problem is related with the PWMCLK parameter.
Im currently working on a set of patches for the winbond family, 
including w83627 and w83697 to enable access to these registers.

You may want to take a look at
http://www.tinet.org/~com.ea/rtsensors/

that application works for w83697 and most likely for w83627 in the
isa range.

Regards
Carlos
http://www.tinet.org/~com.ea

