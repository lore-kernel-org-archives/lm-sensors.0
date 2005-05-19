From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:38 +0000
Subject: lm_sensors 2.8.3
Message-Id: <1075713406.401e157e38542@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <200401291139.58838.jumpyboy@infinito.it>
In-Reply-To: <200401291139.58838.jumpyboy@infinito.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[Please CC: the mailing-list on reply.]

> VCore 1:   +1.76 V  (min =  +1.56 V, max =  +1.72 V)
> (...)
> Sorry I told you bad. XP not Windows XP, but Athlon XP. I take look
> at the  Athlon XP's data sheets on AMD site and the told VCore 1.65.

Oh OK. You should be able to select the voltage either in the BIOS setup
screen or using switches or jumpers on your motherboard. It is
obviously set to 1.75V at the moment. If you really believe that your
CPU needs 1.65 instead, go change (unless your CPU is overclocked,
which I don't recommend BTW).

> No, it's the real temperature. I've got Asus A7V600 and in config
> file I found  the right formula form my motherboard :D. And the BIOS
> sensors tell me 56?C  at start up when I reboot machene after about 2
> hours of activity. I think in winter 60 ? C it's too much.

I don't think my Athlon is much colder than that. These beasts tend to
heat much, I fear.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
