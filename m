From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: lm_sensors problem booting after install
Message-Id: <20040302210438.0dd34585.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4044E51F.9050908@pacbell.net>
In-Reply-To: <4044E51F.9050908@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> My system is an AMD64 with Nforce3 and ite8712f-A chips.
> 
> I was hoping to get partial info from the ite chip.
> 
> after placing the following in the /etc/modules.conf
> 
> > alias eth1 tulip
> > alias char-major-195 nvidia
> > # I2C module options
> > alias char-major-89 i2c-dev
> > options it87 ignore=-1,0x290
> > # I2C adapter drivers
> > #modprobe i2c-isa
> > # I2C chip drivers
> > #modprobe it87
> > # sleep 2 # optional
> > #/usr/local/bin/sensors -s # recommended
> 
> when modprobe it87 activates it shuts down all my internal fans.

Bad. Which kernel? Which version of lm_sensors?

> Also when I rebooted the first time there were massive failures from 
> other devices such as mouse iptables ect...

I don't much see how this would be related. But if you can reproduce
that and can provide some more details proving that lm_sensors is
somehow responsible for it, we'll investigate.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
