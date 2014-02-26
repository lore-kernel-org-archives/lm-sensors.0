From: Josu Lazkano <josu.lazkano@gmail.com>
Date: Wed, 26 Feb 2014 07:41:50 +0000
Subject: Re: [lm-sensors] HP ProLiant MicroServer
Message-Id: <CAL9G6WXKt1kXjPgn7aA2iKrbTwomkcdWxQLu2j14ODSn3i73bg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAL9G6WVNxpchDgqTkUS7ad-j0f-h20YCo0FtCrVL0ra8F-ttYw@mail.gmail.com>
In-Reply-To: <CAL9G6WVNxpchDgqTkUS7ad-j0f-h20YCo0FtCrVL0ra8F-ttYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

2014-02-26 8:20 GMT+01:00 Jean Delvare <jdelvare@suse.de>:
> Hi Josu,
>
> On Tue, 25 Feb 2014 22:18:14 +0100, Josu Lazkano wrote:
>> Hello, I have a HP ProLiant MicroServer with Debian Wheezy (3.2 kernel).
>>
>> I want to get some hardware information such processor temperature, fan =
speed...
>>
>> I execute "sensors-detect" and it load the "jc42" module, but I just
>> have this information:
>>
>> # sensors
>> k10temp-pci-00c3
>> Adapter: PCI adapter
>> temp1:        +32.5=B0C  (high =3D +70.0=B0C)
>>                        (crit =3D +100.0=B0C, hyst =3D +95.0=B0C)
>>
>
> The jc42 driver doesn't appear to be loaded. Beware that sensors-detect
> only detects which drivers are needed, it doesn't load them by itself.
> Read carefully what it says at the end, you probably need to add the
> relevant drivers to /etc/modules, and then either reboot or load the
> modules manually once (using modprobe.)
>
>> Is it possible to get more information? disk temperature? fan speed?
>
> That I can't say without seeing the complete output of sensors-detect.
> If the hardware is recent, you may want to try the most recent version:
> http://dl.lm-sensors.org/lm-sensors/files/sensors-detect
>
> The jc42 driver will tell you the temperature of the memory modules,
> nothing else.
>
> Disk temperature is not yet supported by the lm-sensors framework. If
> you need it, check either hddtemp or smartctl (from smartmontools.)
>
> It is possible that your system needs SMBus multiplexing or support for
> extra SMBus channels, I seem to recall people mentioning that on the
> ProLiant MicroServer N36L and maybe N40L and N54L too.
>
> --
> Jean Delvare
> Suse L3 Support

Thanks Jean,

This the "sensors-detect" output: http://paste.debian.net/plain/84118

I notice that if I load manually the module, it does not exist:

# modprobe jc42
FATAL: Module jc42 not found.

Need I install more software?

Thanks for your help.

Regards.

--=20
Josu Lazkano

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
