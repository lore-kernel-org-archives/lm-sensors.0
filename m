From: "Juerg Haefliger" <juergh@gmail.com>
Date: Mon, 01 Oct 2007 17:06:58 +0000
Subject: Re: [lm-sensors] lm-sensors with VIA vt82c596b
Message-Id: <191fb4ca0710011006p32dec261g398106f2301e2874@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070929033210.GA30044@cyberspace>
In-Reply-To: <20070929033210.GA30044@cyberspace>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Dimitry,


On 9/28/07, admin@incred.org <admin@incred.org> wrote:
> Hello!
>
> I have a trouble with detecting sensors.
> System:
>         $ sensors -v
>         sensors version 2.10.1 with libsensors version 2.10.1
>
>         Kernel 2.6.21 (Gentoo)
>
>         Hardware:
>         00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x
>         [Apollo PRO133x] (rev 44)
>         00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo
>         MVP3/Pro133x AGP]
>         00:07.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Mobile
>         South] (rev 23)
>         00:07.1 IDE interface: VIA Technologies, Inc.
>         VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 10)
>         00:07.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI
>         USB 1.1 Controller (rev 11)
>         00:07.3 Host bridge: VIA Technologies, Inc. VT82C596 Power
>         Management (rev 30)
>         00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
>         RTL-8139/8139C/8139C+ (rev 10)
>         00:0b.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev
>         02)
>         01:00.0 VGA compatible controller: nVidia Corporation NV11
>         [GeForce2 MX/MX 400] (rev b2)
> Actually, support for vt82c596b exists, but during detecting sensors i
> got:
>
> Driver `eeprom' (should be inserted):
>   Detects correctly:
>     * Bus `SMBus Via Pro adapter at 5000'
>         Busdriver `i2c-viapro', I2C address 0x51
>             Chip `eeprom' (confidence: 6)
>
>               EEPROMs are *NOT* sensors! They are data storage chips
>               commonly
>                 found on memory modules (SPD), in monitors (EDID), or in
>                 some
>                   laptops, for example.
>
>                   I will now generate the commands needed to load the
>                   required modules.
>                   Just press ENTER to continue:
>
>
>                   If you want to load the modules at startup, generate a
>                   config file
>                   below and make sure lm_sensors gets started at boot
>                   time; e.g
>                   $ rc-update add lm_sensors default
>                   To make the sensors modules behave correctly, add
>                   these lines to
>                   /etc/modules.d/lm_sensors and run modules-update:
>
>                   #----cut here----
>                   # I2C module options
>                   alias char-major-89 i2c-dev
>                   #----cut here----
>
>                   If you have some drivers built into your kernel, the
>                   list above will
>                   contain too many modules. Skip the appropriate ones!
>                   You really
>                   should try these commands right now to make sure
>                   everything is
>                   working properly. Monitoring programs won't work until
>                   the needed
>                   modules are loaded.
>
>                   To load everything that is needed, execute the
>                   commands below...
>
>                   #----cut here----
>                   # I2C adapter drivers
>                   modprobe i2c-viapro
>                   # Chip drivers
>                   modprobe eeprom
>                   # sleep 2 # optional
>                   /usr/bin/sensors -s # recommended
>                   #----end cut here----
>

Can you please post the full output of sensors-detect?

...juerg



> After load i2c-viapro and eeprom:
>
>  # sensors -s
>  No sensors found!
>  Make sure you loaded all the kernel drivers you need.
>  Try sensors-detect to find out which these are.
>
> how can i solve this trouble? (I want to look temperature of CPU )
>
> /Thank You...
>
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
