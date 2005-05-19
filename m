From: erict@alum.rpi.edu (er0ck)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: Ticket #: 1659   it87: it8712f module stops working
Message-Id: <1083021688.1553.27.camel@localhost>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

see ticket for background.

basically the it87 module stops working on my system (it8712), and
answers 0x08 to any request.

i've confirmed that i can reload the module all i want prior to when it
craps the bed.  

i've also been logging sensors output, and time and it appears to always
stop working at 10 mins of uptime.   but i've only rebooted twice, which
is the only way to get the chip back...

i'm going to rewrite my script now so it logs the number of calls to
sensors, finer granularity of time ellapsed, and system state.  i'll
also turn on debug in lm-sensors.

any other suggestions?

thanks
-eric
