From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: lm78 needs vrm 9.0
Message-Id: <20031124211601.4cf00d01.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1069701990.540.3.camel@agaliaretph>
In-Reply-To: <1069701990.540.3.camel@agaliaretph>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> The mother board is a Space Walker AV45GT.

Never heard of that brand.

> lm_sensors version 2.6.5.

It's a bit old. Please download the CVS version of sensors-detect:
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/prog/detect/sensors-detect

It'll probably tell you to use another driver instead (probably it87).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
