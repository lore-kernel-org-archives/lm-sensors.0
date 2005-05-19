From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: i2c-sis645
Message-Id: <Pine.LNX.4.58.0405311653260.1458@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello,

> Hey
>
> I have an ASUS P4S8X motherboard, and I'm running a 2.6.3 kernel. The
> problem is, any 2.6.x kernel doesnt include the sis645 module which,
> according to sensors-detect, is appropriate for my mo/bo. What can I do?

Yes your ASB100 chip is smbus only so you need some. According to
lm_sensors pages  no-one is trying to port it to 2.6. However module
i2c-sis96x may work too. Would you be so kind and give a try?

If it does not work, I have motherboard with 645 smbus host
compatible (Sis 745), maybe I can port it for 2.6, if you dont have enough
skills.

Regards

Rudolf



