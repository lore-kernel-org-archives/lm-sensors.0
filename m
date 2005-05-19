From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: p4b_smbus and other modules
Message-Id: <20040224205107.46fe98fe.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <485309134.20040121132926@spin.it>
In-Reply-To: <485309134.20040121132926@spin.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I removed lm_sensors' one, and now the system tells it's using its own
> one, but I get the same errors.
> 
> I also tried adding p4b_smbus in /etc/hotplug/blacklist (yes, it seems
> the right place to do it), but I still get the same identical errors.
> I also rebooted, just to be sure I tried on a clean startup.
> 
> Does anyone have any other clue?

Except trying the other way around (removing your distribution's one and
using lm_sensors one instead), no other ideas, sorry.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
