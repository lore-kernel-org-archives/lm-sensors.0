From: Juerg Haefliger <juergh@gmail.com>
Date: Wed, 20 Jan 2010 16:27:49 +0000
Subject: Re: [lm-sensors] proliant dl120
Message-Id: <191fb4ca1001200827o20141747q6a3e466d90475bc7@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4B56DB6B.4070109@anteasrl.it>
In-Reply-To: <4B56DB6B.4070109@anteasrl.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Lisa,


> Hi,
>
> I have a proliant dl120 server, with centos 5.4 and I want to monitoring =
the
> temperature and fault of the server but the software of hp seems don't wo=
rk.
> I have trid to install lm-sensor but the result is:

I never had problems with the hp software. Did you try the hplog
utility? It's part of the hpasm (or hphealth, depending on the version
you choose) package that you can get from hp.com.

>
> [root@serverhost bus]# yum install lm_sensors
> Loaded plugins: fastestmirror
> Loading mirror speeds from cached hostfile
> * addons: centos.intergenia.de
> * base: centos.xengage.it
> * extras: centos.xengage.it
> * updates: centos.intergenia.de
> Setting up Install Process
> Package lm_sensors-2.10.7-4.el5.x86_64 already installed and latest versi=
on
> Package lm_sensors-2.10.7-4.el5.i386 already installed and latest version
> Nothing to do
> [root@serverhost bus]# sensors-detect
> # sensors-detect revision 5291 (2008-06-23 23:40:46 -0700)

This is quite old. You might want to try the latest sensors-detect
version from lm-sensors.org

...juerg


> This program will help you determine which kernel modules you need
> to load to use lm_sensors most effectively. It is generally safe
> and recommended to accept the default answers to all questions,
> unless you know what you're doing.
>
> We can start with probing for (PCI) I2C or SMBus adapters.
> Do you want to probe now? (YES/no):
> Probing for PCI bus adapters...
> Use driver `i2c-i801' for device 0000:00:1f.3: Intel ICH9
>
> We will now try to load each adapter module in turn.
> Module `i2c-i801' already loaded.
> If you have undetectable or unsupported I2C/SMBus adapters, you can have
> them scanned by manually loading the modules before running this script.
>
> We are now going to do the I2C/SMBus adapter probings. Some chips may
> be double detected; we choose the one with the highest confidence
> value in that case.
> If you found that the adapter hung after probing a certain address,
> you can specify that address to remain unprobed.
>
> Next adapter: SMBus I801 adapter at 1c00 (i2c-0)
> Do you want to scan it? (YES/no/selectively):
> Client found at address 0x51
> Probing for `Analog Devices ADM1033'... No
> Probing for `Analog Devices ADM1034'... No
> Probing for `SPD EEPROM'... Yes
> (confidence 8, not a hardware monitoring chip)
> Probing for `EDID EEPROM'... No
> Client found at address 0x53
> Probing for `Analog Devices ADM1033'... No
> Probing for `Analog Devices ADM1034'... No
> Probing for `SPD EEPROM'... Yes
> (confidence 8, not a hardware monitoring chip)
> Probing for `EDID EEPROM'... No
>
> Some chips are also accessible through the ISA I/O ports. We have to
> write to arbitrary I/O ports to probe them. This is usually safe though.
> Yes, you do have ISA I/O ports even if you do not have any ISA slots!
> Do you want to scan the ISA I/O ports? (YES/no):
> Probing for `National Semiconductor LM78' at 0x290... No
> Probing for `National Semiconductor LM78-J' at 0x290... No
> Probing for `National Semiconductor LM79' at 0x290... No
> Probing for `Winbond W83781D' at 0x290... No
> Probing for `Winbond W83782D' at 0x290... No
>
> Some Super I/O chips may also contain sensors. We have to write to
> standard I/O ports to probe them. This is usually safe.
> Do you want to scan for Super I/O sensors? (YES/no):
> Probing for Super-I/O at 0x2e/0x2f
> Trying family `National Semiconductor'... No
> Trying family `SMSC'... No
> Trying family `VIA/Winbond/Fintek'... No
> Trying family `ITE'... No
> Probing for Super-I/O at 0x4e/0x4f
> Trying family `National Semiconductor'... No
> Trying family `SMSC'... No
> Trying family `VIA/Winbond/Fintek'... No
> Trying family `ITE'... No
>
> Some south bridges, CPUs or memory controllers may also contain
> embedded sensors. Do you want to scan for them? (YES/no):
> Silicon Integrated Systems SIS5595... No
> VIA VT82C686 Integrated Sensors... No
> VIA VT8231 Integrated Sensors... No
> AMD K8 thermal sensors... No
> AMD K10 thermal sensors... No
> Intel AMB FB-DIMM thermal sensor... No
>
> Sorry, no sensors were detected.
> Either your sensors are not supported, or they are connected to an
> I2C or SMBus adapter that is not supported. See doc/FAQ,
> doc/lm_sensors-FAQ.html or http://www.lm-sensors.org/wiki/FAQ
> (FAQ #4.24.3) for further information.
> If you find out what chips are on your board, check
> http://www.lm-sensors.org/wiki/Devices for driver status.
>
>
>
> What I have to do??
>
> Many thankx
> --
>
> Ing. Lisa Salvadorini
>
> Antea Projects
>
> projects@anteasrl.it
>
> Toscocom by Antea srl
>
> Via Pisana, 336 int.13
>
> 50018 OLMO =E2=80=93 SCANDICCI (FI)
>
> Tel. +39 055 790 600
>
> Fax +39 055 790 797
>
> ITALY
>
> P Before printing, think about the environment
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
