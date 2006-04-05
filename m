From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 05 Apr 2006 08:28:17 +0000
Subject: [lm-sensors] Question on my mainboard
Message-Id: <44337FA1.3070407@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200603282150.16130.dieter.jurzitza@t-online.de>
In-Reply-To: <200603282150.16130.dieter.jurzitza@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dieter Jurzitza wrote:
> Dear Rudolf, dear listmembers,
> unfortunately it was not the problem that both drivers (w83781d and w83627hf) 
> are running (apparently). Today the same thing happened again even though the 
> 83627hf is not loaded any more.
> 
> The "D"-state:
> fred/Downloads> ps ax | grep sensors
>  2980 ?        D      0:00 /usr/bin/sensors -c /etc/sensors.tempconf
> 
> and cat hangs when trying a
> fred/Downloads> cat /sys/bus/i2c/devices/0-002c/alarms 
> but only for a while, then comes back with -257
> (strange value, isn't it?)
> 

This sounds like bus problem to me, If you use only the w83627hf, I think the
issue should disappear.

If you wish to help solve the issue continue using the w93781d and
tick in the config of i2c the debug stuff. (Bus driver debug) So we will see if
there are some problems with transaction.

Regards
Rudolf



