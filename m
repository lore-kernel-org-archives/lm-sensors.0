From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:12 +0000
Subject: lm_sensors ain't updating cpu temp
Message-Id: <20040829174252.1980567d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1093792983.3809.5.camel@84.xa.interkam.pl>
In-Reply-To: <1093792983.3809.5.camel@84.xa.interkam.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I've got this problem with lm_sensors that it doesn't update my cpu
> temperature, though my mibi temp is constantly updated, which leads to
> mibi's temp getting bigger that cpu's.
> 
> I'm using lm_sensors 2.8.5 with 2.6.3-7mdk kernel.

Which driver ? Which chip ? Anything relevant in the logs? Sample output
from "sensors" ?

If you have the possibility to upgrade kernels (and lm_sensors) I would
try that, since 2.6.3 is somewhat old now.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
