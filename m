From: Muhammad Umair <muhammaduma1r@hotmail.com>
Date: Sat, 15 Feb 2014 19:23:39 +0000
Subject: Re: [lm-sensors] CPU temperatures not being showed?
Message-Id: <BLU0-SMTP133A316B53E79339C446626E19F0@phx.gbl>
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU0-SMTP159BE1B809DF98E17A3FC8EE19F0@phx.gbl>
In-Reply-To: <BLU0-SMTP159BE1B809DF98E17A3FC8EE19F0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sat, 15 Feb 2014 22:39:00 +0500, Guenter Roeck <linux@roeck-us.net> =20
wrote:

> On 02/15/2014 09:19 AM, Muhammad Umair wrote:
>> On Sat, 15 Feb 2014 21:03:23 +0500, Guenter Roeck <linux@roeck-us.net>  =

>> wrote:
>>
>>> On 02/15/2014 01:28 AM, Muhammad Umair wrote:
>>>> Hi,
>>>>
>>>>
>>>> I have a machine running Motherboard: Supermicro H8DGU with AMD =20
>>>> Opteron 6380 (16-core) x2 CPUs. Its running Ubuntu Server 12.04.3 =20
>>>> LTS, uname -a: Linux sysname 3.5.0-23-generic #35~precise1-Ubuntu SMP =
=20
>>>> Fri Jan 25 17:13:26 UTC 2013 x86_64 x86_64 x86_64 GNU/Linux
>>>>
>>>> I have installed sensors version 3.3.2 with libsensors version 3.3.1. =
=20
>>>> The output of sensors-detect is as follows:
>>>>
>>>> # sensors-detect revision 6031 (2012-03-07 17:14:01 +0100)
>>>> # System: Supermicro H8DGU [1234567890]
>>>>
>>>> This program will help you determine which kernel modules you need
>>>> to load to use lm_sensors most effectively. It is generally safe
>>>> and recommended to accept the default answers to all questions,
>>>> unless you know what you're doing.
>>>>
>>>> Some south bridges, CPUs or memory controllers contain embedded =20
>>>> sensors.
>>>> Do you want to scan for them? This is totally safe. (YES/no):
>>>>
>>>> Silicon Integrated Systems SIS5595...                       No
>>>> VIA VT82C686 Integrated Sensors...                          No
>>>> VIA VT8231 Integrated Sensors...                            No
>>>> AMD K8 thermal sensors...                                   No
>>>> AMD Family 10h thermal sensors...                           No
>>>> AMD Family 11h thermal sensors...                           No
>>>> AMD Family 12h and 14h thermal sensors...                   No
>>>> AMD Family 15h thermal sensors...                           Success!
>>>>      (driver `k10temp')
>>>> AMD Family 15h power sensors...                             Success!
>>>>      (driver `fam15h_power')
>>>> Intel digital thermal sensor...                             No
>>>> Intel AMB FB-DIMM thermal sensor...                         No
>>>> VIA C7 thermal sensor...                                    No
>>>> VIA Nano thermal sensor...                                  No
>>>>
>>>> Some Super I/O chips contain embedded sensors. We have to write to
>>>> standard I/O ports to probe them. This is usually safe.
>>>> Do you want to scan for Super I/O sensors? (YES/no):
>>>>
>>>> Probing for Super-I/O at 0x2e/0x2f
>>>> Trying family `National Semiconductor/ITE'...               No
>>>> Trying family `SMSC'...                                     No
>>>> Trying family `VIA/Winbond/Nuvoton/Fintek'...               Yes
>>>> Found `Winbond W83627DHG-P/W83527HG Super IO Sensors'
>>>>      (address 0xa10, but not activated)
>>>> Probing for Super-I/O at 0x4e/0x4f
>>>> Trying family `National Semiconductor/ITE'...               No
>>>> Trying family `SMSC'...                                     No
>>>> Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
>>>> Trying family `ITE'...                                      No
>>>>
>>>> Some systems (mainly servers) implement IPMI, a set of common =20
>>>> interfaces
>>>> through which system health data may be retrieved, amongst other =20
>>>> things.
>>>> We first try to get the information from SMBIOS. If we don't find it
>>>> there, we have to read from arbitrary I/O ports to probe for such
>>>> interfaces. This is normally safe. Do you want to scan for IPMI
>>>> interfaces? (YES/no):
>>>>
>>>> Found `IPMI BMC KCS' at 0xca2...                            Success!
>>>>      (confidence 8, driver `to-be-written')
>>>>
>>>> Some hardware monitoring chips are accessible through the ISA I/O =20
>>>> ports.
>>>> We have to write to arbitrary I/O ports to probe them. This is usually
>>>> safe though. Yes, you do have ISA I/O ports even if you do not have =20
>>>> any
>>>> ISA slots! Do you want to scan the ISA I/O ports? (YES/no):
>>>>
>>>> Probing for `National Semiconductor LM78' at 0x290...       No
>>>> Probing for `National Semiconductor LM79' at 0x290...       No
>>>> Probing for `Winbond W83781D' at 0x290...                   No
>>>> Probing for `Winbond W83782D' at 0x290...                   No
>>>>
>>>> Lastly, we can probe the I2C/SMBus adapters for connected hardware
>>>> monitoring devices. This is the most risky part, and while it works
>>>> reasonably well on most systems, it has been reported to cause trouble
>>>> on some systems.
>>>> Do you want to probe the I2C/SMBus adapters now? (YES/no):
>>>>
>>>> Using driver `i2c-piix4' for device 0000:00:14.0: ATI Technologies =20
>>>> Inc SB600/SB700/SB800 SMBus
>>>>
>>>> Next adapter: SMBus PIIX4 adapter at 0b00 (i2c-0)
>>>> Do you want to scan it? (YES/no/selectively):
>>>> Now follows a summary of the probes I have just done.
>>>> Just press ENTER to continue:
>>>>
>>>> Driver `to-be-written':
>>>>    * ISA bus, address 0xca2
>>>>      Chip `IPMI BMC KCS' (confidence: 8)
>>>>
>>>> Driver `fam15h_power' (autoloaded):
>>>>    * Chip `AMD Family 15h power sensors' (confidence: 9)
>>>>
>>>> Driver `k10temp' (autoloaded):
>>>>    * Chip `AMD Family 15h thermal sensors' (confidence: 9)
>>>>
>>>> Note: there is no driver for IPMI BMC KCS yet.
>>>> Check http://www.lm-sensors.org/wiki/Devices for updates.
>>>>
>>>> No modules to load, skipping modules configuration.
>>>>
>>>>
>>>>
>>>> And this is the is the output of sensors:
>>>>
>>>> fam15h_power-pci-00c4
>>>> Adapter: PCI adapter
>>>> power1:       41.15 W  (crit =3D 114.49 W)
>>>>
>>>> fam15h_power-pci-00d4
>>>> Adapter: PCI adapter
>>>> power1:       40.99 W  (crit =3D 114.49 W)
>>>>
>>>> k10temp-pci-00c3
>>>> Adapter: PCI adapter
>>>> temp1:        +15.0=B0C  (high =3D +70.0=B0C)
>>>>                         (crit =3D +70.0=B0C, hyst =3D +67.0=B0C)
>>>>
>>>> k10temp-pci-00cb
>>>> Adapter: PCI adapter
>>>> temp1:        +15.4=B0C  (high =3D +70.0=B0C)
>>>>
>>>> k10temp-pci-00d3
>>>> Adapter: PCI adapter
>>>> temp1:        +15.0=B0C  (high =3D +70.0=B0C)
>>>>                         (crit =3D +70.0=B0C, hyst =3D +67.0=B0C)
>>>>
>>>> k10temp-pci-00db
>>>> Adapter: PCI adapter
>>>> temp1:        +15.1=B0C  (high =3D +70.0=B0C)
>>>>
>>>>
>>>> I am getting no CPU/CPU core temperature readings at all. And I don't =
=20
>>>> know these PCI Adapter temperature readings exactly represent. Is my  =

>>>> motherboard and CPU supported? If so what am I doing wrong or not =20
>>>> doing? Kindly help me out here!
>>>>
>>>
>>> k10temp _is_ the CPU temperature. The readings are notoriously
>>> unreliable, especially at low temperatures. You should see
>>> the readings go up with higher load.
>>>
>>> Guenter
>>>
>>>
>>
>> Thanks for the info! but isn't it also supposed to show core =20
>> temperatures? And regardless of that, The machine has 2 AMD Opteron =20
>> 6380 CPUs, so why exactly is it showing 4 temperature readings? =20
>> Shouldn't they just be 2?
>>
>
> I don't know exactly what readings those CPUs provide. The datasheet =20
> should tell.
> The output itself suggests that it is for two different CPUs; you can =20
> see that there
> are four sensors, two of which support critical temperature readings and =
=20
> two don't.
> So it looks like you get two readings per CPU. Possibly one is the =20
> package temperature
> and one is the CPU temperature. Again, the datasheet should tell you =20
> what exactly
> it is (or maybe someone on the list knows better than me).
>
> Guenter
>
>
>
>

Okay thanks man! If anyone else has something more to add, please do so!

Also the reason I am trying to use lm-sensors is that because machines in  =

our lab with the same configuration are experiencing random spontaneous =20
reboots, which may occur with a gap of a few days or may not occur at all. =
=20
The logs show nothing so I was suspecting a hardware problem. Will the =20
readings from lm-sensors be atleast reliable enough in those regards? to =20
identify if maybe the reboots are somehow temperature related? I was =20
planning on scripting a small cron to log CPU temperatures using =20
lm-sensors periodically, so I could look at them the next time the machine =
=20
reboots.

Any thoughts on that?


Regards


--=20
Using Opera's mail client: http://www.opera.com/mail/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
