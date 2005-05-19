From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: [PATCH] prog/init/lm_sensors.init: reduce verbosity, MAKEDEV,
Message-Id: <tis3qjaJ.1102412033.0479260.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041207014837.GC23447@neu.nirvana>
In-Reply-To: <20041207014837.GC23447@neu.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


Hi Philip,

> This patch has me thinking...
>
> What do people think about changing the format of the
> sysconfig/lm_sensors config file from
>
> MODULE_0=3Di2c-i801
> MODULE_1=3Di2c-isa
> MODULE_2=3Dlm85
> MODULE_3=EEprom
> MODULE_4=3Dw83781d
>
> to
>
> BUSES=3D"i2c-i801 i2c-isa"
> MODULES=3D"lm85 eeprom w83781d"

The names you pick are confusing. Bus drivers are modules too. BUSES and
CHIPS would be better.

> If we did this, then we could get rid of the confusing and obscure
> backticks and eval in the module loading loop, replacing it with
> something simple like:
>
>   for module in $MODULES ; do
>      echo -n __$module__
>      modprobe $module
>   done
>
> Which seems much clearer to me.

Agreed. However, I wonder why things were done that way in the first
place. Were we following some Red Hat standard? I have no Red Hat-like
system to verify that. If there is no standard to follow, any code
simplification is welcome.

Thanks,
