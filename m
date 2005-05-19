From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:48 +0000
Subject: lm_sensor in IBM Servers?
Message-Id: <20030220094127.11aaf5f3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E544936.FCA4C470@fi.ibm.com>
In-Reply-To: <3E544936.FCA4C470@fi.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> if I understood right, that problem with IBM is only in laptops
> which have RFID. The servers should not have such a feature,
> so should I compile and run the packet without problem?

Negative, it won't work. We had at least one report of someone running
lm_sensors on a non-laptop IBM system and having the RFID issue on it,
so we decided to blacklist all IBM systems at once. This may change in
the future though, providing we at last get a list of affected systems
from IBM, or some way to detect the RFID without breaking anything.

Sorry.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
