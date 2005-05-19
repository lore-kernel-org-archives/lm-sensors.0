From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:11 +0000
Subject: [LM_SENSOR-2.8.7] lm_sensors.init and kernel 2.6.5
Message-Id: <20040811191851.3c5d577e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200408071426.51805.bepi@adria.it>
In-Reply-To: <200408071426.51805.bepi@adria.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks, I've commited the updated script.

> P.S. You have never thought to not only identify the sensor with the
> type but also considering to the model of motherboard?
> This would have to concur, after a several time, of having a series
> of configurations that would have need of least modifications on
> many systems.

We know this would be helpful, but never got to decide how to get the
whole thing to work. Several options have been proposed, including
distributing user-contributed motherboard-specific configuration files
in the lm_sensors package, or using a database with a web interface. I
know that someone had proposed such a site but I can't seem to remember
where.

I won't take care of this personally, as I already spend (too) much time
on this project, but help is certainly welcome.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
