From: aurelien@aurel32.net (Aurelien Jarno)
Date: Mon, 05 Sep 2005 22:48:07 +0000
Subject: [lm-sensors] Strange Values with pcf8591 chip driver
Message-Id: <431CAEDA.5040704@aurel32.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <431C9BDD.3020708@buholzer.com>
In-Reply-To: <431C9BDD.3020708@buholzer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi!

Mirko Buholzer a ?crit :
> I am using a pcf8591 chip on a linux 2.6.8 Kernel. The Adapter Driver is 
> the scx200_i2c. When I do a sensors command I get random values on each 
> input channel. Channel 1/2/3 are all set to 0V.
> 
> voyage:~# sensors
> pcf8591-i2c-1-49
> Adapter: NatSemi SCx200 I2C
> Chan. 0:    1.28 V
> Chan. 1:    1.28 V
> Chan. 2:    1.28 V
> Chan. 3:    1.28 V
> Output:     0.00 V (enabled)
> 
> Does anyone have any hints or tricks on how I can proceed with debugging 
> and error correction? Or is this a known problem?

Have you set the voltage reference of the chip correctly?

Note that you can also change the mode of the chip (single ended or 
differential inputs) with the input_mode parameter.

Aurelien

-- 
   .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
  : :' :  Debian GNU/Linux developer | Electrical Engineer
  `. `'   aurel32@debian.org         | aurelien@aurel32.net
    `-    people.debian.org/~aurel32 | www.aurel32.net
