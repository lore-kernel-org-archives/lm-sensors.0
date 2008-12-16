From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 16 Dec 2008 13:26:08 +0000
Subject: Re: [lm-sensors] F8000 support added to f71882fg driver,
Message-Id: <20081216142608.04300c82@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081215180300.GA6612@rho>
In-Reply-To: <20081215180300.GA6612@rho>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Chuan-kai, Ludovic,

Please provide a dump of your F8000 chip:

isadump 0xa05 0xa06

together with the output of "sensors" using Hans' latest f71882fg
driver at approximately the same time.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
