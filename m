From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: Lm-sensors 2.8.0 on Asus P3B-F
Message-Id: <20030721084610.4e96adee.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <OFCA88DDCC.BD2AC8B4-ONC1256D69.007A5603-C1256D69.007B6BB2@apelseth.com>
In-Reply-To: <OFCA88DDCC.BD2AC8B4-ONC1256D69.007A5603-C1256D69.007B6BB2@apelseth.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Thank's for the fast reply and now i might hav another silly question.
> 
> How can i pick out the "temp2" value from sensors then?
> 
> With the sensors command:
> temp2:     +40.0?C  (limit =  +67?C, hysteresis =  +60?C)
> 
> but with the: head -1l /proc/sys/dev/sensors/as99127f-i2c-0-2d/temp2
> 60.0 50.0 22.0

As Mark told you, the values in /proc are raw ones, they don't have to
have a meaning. Use the values 'sensors' returns. That said, the support
for as99127f was made with no datasheet, so some values it reports may
be wrong, and there's nothing we can do until Asus accepts helping us -
which should not happend before one dozen centuries, as it turns out :(

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
