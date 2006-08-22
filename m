From: anthony.calabro@lmco.com (Calabro, Anthony)
Date: Tue, 22 Aug 2006 17:38:59 +0000
Subject: [lm-sensors] Flex Scanner Jammed Problem
Message-Id: <ECFA7CB48E408A45987215BF5593E04708A1724D@emss09m08.us.lmco.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1064332995.5787.33.camel@nils>
In-Reply-To: <1064332995.5787.33.camel@nils>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean, 
	kernel 2.6.9 does not have the class hwmon. 


Anthony W. Calabro

Voice: 703.367.3138 
Email:  anthony.calabro at lmco.com

-----Original Message-----
From: Jean Delvare [mailto:khali at linux-fr.org] 
Sent: Friday, August 11, 2006 8:15 AM
To: Calabro, Anthony
Cc: LM Sensors
Subject: Re: [lm-sensors] Flex Scanner Jammed Problem

> No additional patches applied....
> 
> ~@> systool -c hwmon -v
> Error opening class hwmon
> ~@>

Hm, and what other things fail mysteriously on that machine? ;) I start
suspecting that your machine has specific problems beyond libsensors.

--
Jean Delvare


