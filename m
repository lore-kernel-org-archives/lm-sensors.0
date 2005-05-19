From: khali@linux-fr.org (Khali)
Date: Thu, 19 May 2005 06:23:40 +0000
Subject: Ticket #1018
Message-Id: <20020930074919.633A840F3A@kraid.nerim.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <E17viwV-0006OX-00@mendel.bio.caltech.edu>
In-Reply-To: <E17viwV-0006OX-00@mendel.bio.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> lm_sensors 2.6.4, RH 7.3, PS fan not showing up.

> I've narrowed down the problem.  The configuration switch
> "set  fan3_div 8"  is ignored even though it is in the
> relevant chip section for chip as99127f.  I even tried
> setting all 3 fans and it was still ignored.

Didn't you forget to run "sensors -s" once (as root) before running "sensors" again?

-- 
Khali



___________________________________
Webmail Nerim, http://www.nerim.net/

