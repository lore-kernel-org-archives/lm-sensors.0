From: Dexter.Filmore@gmx.de (Dexter Filmore)
Date: Thu, 19 May 2005 06:25:12 +0000
Subject: Bogus readings on GA 7N400 and ECS N2U400-A
Message-Id: <20040819115718.28d02717@shodan.citadel>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi, tried 2.8.7 on 2.6 kernel on these boards, both of which carry the ITE
8712F chip. Vcore is always somewhere around 4.2V, 3.3V is doubled, CPU temps
are too low, 12V seems odd, too.
I installed last version of MBM5 in Windows and noticed there are exception
rules for those two boards. 
Seems like MoBo manufacturers are making great efforts to lock out 3rd party
software these days. Wonder why.

Had an idea about how to guess calc formulas, in case you haven't figured that
yourself: run Windows in a virtual machine with MBM5 or such, then push CPU to
the limits and compare how values behave on MBM and lm_sensors.

The thing why I'm so fond of MBM is, the author got info directly from board
manufacturers. Unfortunately it's NDA, so he said he won't hand it out.
Well, guess it's happy tinkering then.

Dex


-- 
-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCS d--(+)@ s-:+ a- C+++(++++) UL+>++++ P+>++ L+++>++++ E-- W++ N o? K-
w--(---) !O M+ V- PS++(+) PE(-) Y+ PGP(-) t++(---)@ 5 X+(++) R+(++) tv--(+)@ 
b+(+++) DI+++ D G++ e* h>++ r%>* y?
------END GEEK CODE BLOCK------

http://www.againsttcpa.com - nothing fights like the opposition
