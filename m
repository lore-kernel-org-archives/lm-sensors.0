From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: lm_sensors: output for all sensors?
Message-Id: <Pine.LNX.4.58.0406161547330.20062@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200406161539.50952.haimat@lame.at>
In-Reply-To: <200406161539.50952.haimat@lame.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello

>
> Aren't there any other sensors like temp., voltage and so on?
> How can I access these?

You have loaded driver for i2c bus (via pro) buy I guess you need
one more module for sensors which is as I hope called via686a

Plz try

modprobe via686a

And let me know. Please CC to list too.

Thanks

Rudolf
