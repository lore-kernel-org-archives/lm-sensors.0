From: udovdh@xs4all.nl (Udo van den Heuvel)
Date: Sun, 22 Oct 2006 09:26:20 +0000
Subject: [lm-sensors] w83627hf 9191-0290: If reset=1 solved a problem you
Message-Id: <453B393C.9000204@xs4all.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I report that I have to use reset=1 for w83627hf to make my fans start
again after booting the kernel on VIA Epia EK8000.
The w83629hf driver sees a w83697hf chip.

Also:

Sensors work better with:

   set sensor1 2
   set sensor2 2

and sensor -s afterwards.
Board sensor is a bit low, CPU sensor looks OK.
Could they be of different types? Who knows?

