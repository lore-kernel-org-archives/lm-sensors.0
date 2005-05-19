From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: [PATCH 2.6] I2C: sysfs names: rename to cpu0_vid
Message-Id: <weA2O8fN.1115796710.6561900.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <hi6m71d93atlu1pci6jmqmt5ob58t6n0i8@4ax.com>
In-Reply-To: <hi6m71d93atlu1pci6jmqmt5ob58t6n0i8@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Grant,

> Oops, forgot that aspect.  I need to change adm9240 in libsensors too
> 'cos I renamed analog_out, does it need chassis_clear?  Nothing else
> has it.  I only put it in the driver 'cos old comment said they
> couldn't get chassis clear it to work, Intel doc. error :)

Don't worry about chassis clear, it wasn't supported so far so I guess
there's little need for it. But yes analog_out and I guess vid need a
patch.

> > Tag the old ones as "to remove after <some date>". Also, a patch to
> > libsensors to accept the new names is obviously needed.
>
> What sort of timeframe you suggest for remove after?

Hmm, 6 months after the original change maybe?

Thanks,
--
Jean Delvare
