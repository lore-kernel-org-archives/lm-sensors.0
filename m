From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 19 Apr 2006 21:03:48 +0000
Subject: [lm-sensors] netfinity 6000r crash running sensors-detect
Message-Id: <4446A5B4.9030107@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <a0fb11cc0604031304m792d8a8oef1f1a81c10e23ad@mail.gmail.com>
In-Reply-To: <a0fb11cc0604031304m792d8a8oef1f1a81c10e23ad@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark Lybarger wrote:
> here's the output from when it crashed.  note that the sensors modules
> were all loaded, but sensors wasn't working.  also, the box doesn't
> come up so cleanly after it crashes.
> arabica mark # sensors
> Can't access procfs/sysfs file
> Unable to find i2c bus information;
> For 2.6 kernels, make sure you have mounted sysfs and libsensors
> was compiled with sysfs support!
> For older kernels, make sure you have done 'modprobe i2c-proc'!
> arabica mark # lsmod
> Module                  Size  Used by
> i2c_dev                10112  0
> nfs                   187588  1
> lockd                  57736  2 nfs
> sunrpc                137660  3 nfs,lockd
> lm92                   10384  0
> eeprom                  7696  0
> pcspkr                  3076  0
> rtc                     9748  0
> parport_pc             37572  0
> parport                33864  1 parport_pc
> floppy                 57188  0
> i2c_piix4               9488  0
> i2c_savage4             4740  0
> i2c_algo_bit            9352  1 i2c_savage4
> i2c_core               20736  5 i2c_dev,lm92,eeprom,i2c_piix4,i2c_algo_bit

How did you find out that you have lm92?

> pcnet32                27780  0
> mii                     6272  1 pcnet32
> sworks_agp              9888  0
> agpgart                33484  1 sworks_agp
> dm_mirror              21200  0
> dm_mod                 53656  1 dm_mirror
> sbp2                   22788  0
> ohci1394               32052  0
> ieee1394               91704  2 sbp2,ohci1394
> sl811_hcd              13056  0
> ohci_hcd               19972  0
> uhci_hcd               30992  0
> usb_storage            67264  0
> usbhid                 43872  0
> ehci_hcd               29192  0
> usbcore               115460  7
> sl811_hcd,ohci_hcd,uhci_hcd,usb_storage,usbhid,ehci_hcd
> arabica mark # sensors-detect
> # sensors-detect revision 1.413 (2006/01/19 20:28:00)
> 

> Next adapter: SMBus PIIX4 adapter at 0440
> Do you want to scan it? (YES/no/selectively):
> Client found at address 0x21
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Client found at address 0x22
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Client found at address 0x23
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Client at address 0x50 can not be probed - unload all client drivers first!
> Client at address 0x51 can not be probed - unload all client drivers first!
> Client found at address 0x52

So it crashes right here?

Please can you send output of following:

power cycle system
lspci -xxx
modprobe i2c-dev
modprobe i2c-piix4
i2cdump -y 0 0x50
i2cdetect 0

(so without savage drivers and lm92)

It should not crash yet. I guess it may crash due to 0x69 clockchip

You may also try:
Do you want to scan it? (YES/no/selectively): selectively
0x69

this will avoid the clockchip and maybe it will not crash.

Regards
Rudolf

