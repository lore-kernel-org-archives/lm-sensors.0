From: mlybarger@gmail.com (Mark Lybarger)
Date: Fri, 21 Apr 2006 10:50:15 +0000
Subject: [lm-sensors] netfinity 6000r crash running sensors-detect
Message-Id: <a0fb11cc0604210350v2ab8a155j5bb3a138eba0fff2@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <a0fb11cc0604031304m792d8a8oef1f1a81c10e23ad@mail.gmail.com>
In-Reply-To: <a0fb11cc0604031304m792d8a8oef1f1a81c10e23ad@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I seem to have gotten by the scanning.  Here's your requested output. 
Sensors still doesn't work, but at least it doesn't crash my machine:

arabica mark # lspci -xxx
00:00.0 Host bridge: Broadcom CNB20HE Host Bridge (rev 21)
00: 66 11 08 00 00 00 00 00 21 00 00 06 08 60 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 02 08 00 00 00 61 01 3b 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 02 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

05:02.0 RAID bus controller: IBM ServeRAID Controller
00: 14 10 bd 01 56 01 80 22 00 00 04 01 08 60 00 00
10: 08 e0 ff ec 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 be 01
30: 00 00 00 00 80 00 00 00 00 00 00 00 0a 01 00 00
40: 00 e0 ff ff 00 10 00 00 08 00 00 a0 00 00 00 fc
50: 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 88 00 00 00 00
70: 00 00 00 00 00 80 ff ff 00 00 e0 fe 00 00 00 00
80: 01 00 02 00 00 00 00 00 06 01 20 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 56 03 00 00 00 00 00 8c
a0: 00 00 00 00 00 00 00 00 1c 01 08 00 14 10 be 01
b0: 04 00 04 88 00 00 00 00 00 00 00 00 00 01 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

05:04.0 RAID bus controller: IBM ServeRAID Controller
00: 14 10 bd 01 56 01 80 22 00 00 04 01 08 60 00 00
10: 08 c0 ff ec 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 be 01
30: 00 00 00 00 80 00 00 00 00 00 00 00 0a 01 00 00
40: 00 e0 ff ff 00 10 00 00 08 00 00 a0 00 00 00 fc
50: 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 88 00 00 00 00
70: 00 00 00 00 00 80 ff ff 00 00 e0 fe 00 00 00 00
80: 01 00 02 00 00 00 00 00 06 01 20 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 56 03 00 00 00 00 00 8c
a0: 00 00 00 00 00 00 00 00 1c 01 08 00 14 10 be 01
b0: 04 00 04 88 00 00 00 00 00 00 00 00 00 01 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

arabica mark # modprobe i2c-dev
arabica mark # modprobe i2c-piix4
arabica mark # i2cdump -y 0 0x50
No size specified (using byte-data access)
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................

arabica mark # i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c/0.
I will probe address range 0x03-0x77.
Continue? [Y/n] Y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f
10: 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f
20: 20 21 22 23 24 25 26 27 28 29 2a 2b 2c 2d 2e 2f
30: 30 31 32 33 34 35 36 37 38 39 3a 3b 3c 3d 3e 3f
40: 40 41 42 43 44 45 46 47 48 49 4a 4b 4c 4d 4e 4f
50: UU UU UU UU UU UU UU UU 58 59 5a 5b 5c 5d 5e 5f
60: 60 61 62 63 64 65 66 67 68 69 6a 6b 6c 6d 6e 6f
70: 70 71 72 73 74 75 76 77

arabica mark # sensors
Can't access procfs/sysfs file
Unable to find i2c bus information;
For 2.6 kernels, make sure you have mounted sysfs and libsensors
was compiled with sysfs support!
For older kernels, make sure you have done 'modprobe i2c-proc'!



On 4/19/06, Rudolf Marek <r.marek at sh.cvut.cz> wrote:
> Mark Lybarger wrote:
> > here's the output from when it crashed.  note that the sensors modules
> > were all loaded, but sensors wasn't working.  also, the box doesn't
> > come up so cleanly after it crashes.
> > arabica mark # sensors
> > Can't access procfs/sysfs file
> > Unable to find i2c bus information;
> > For 2.6 kernels, make sure you have mounted sysfs and libsensors
> > was compiled with sysfs support!
> > For older kernels, make sure you have done 'modprobe i2c-proc'!
> > arabica mark # lsmod
> > Module                  Size  Used by
> > i2c_dev                10112  0
> > nfs                   187588  1
> > lockd                  57736  2 nfs
> > sunrpc                137660  3 nfs,lockd
> > lm92                   10384  0
> > eeprom                  7696  0
> > pcspkr                  3076  0
> > rtc                     9748  0
> > parport_pc             37572  0
> > parport                33864  1 parport_pc
> > floppy                 57188  0
> > i2c_piix4               9488  0
> > i2c_savage4             4740  0
> > i2c_algo_bit            9352  1 i2c_savage4
> > i2c_core               20736  5 i2c_dev,lm92,eeprom,i2c_piix4,i2c_algo_bit
>
> How did you find out that you have lm92?

I don't know how this got loaded.

>
> > pcnet32                27780  0
> > mii                     6272  1 pcnet32
> > sworks_agp              9888  0
> > agpgart                33484  1 sworks_agp
> > dm_mirror              21200  0
> > dm_mod                 53656  1 dm_mirror
> > sbp2                   22788  0
> > ohci1394               32052  0
> > ieee1394               91704  2 sbp2,ohci1394
> > sl811_hcd              13056  0
> > ohci_hcd               19972  0
> > uhci_hcd               30992  0
> > usb_storage            67264  0
> > usbhid                 43872  0
> > ehci_hcd               29192  0
> > usbcore               115460  7
> > sl811_hcd,ohci_hcd,uhci_hcd,usb_storage,usbhid,ehci_hcd
> > arabica mark # sensors-detect
> > # sensors-detect revision 1.413 (2006/01/19 20:28:00)
> >
>
> > Next adapter: SMBus PIIX4 adapter at 0440
> > Do you want to scan it? (YES/no/selectively):
> > Client found at address 0x21
> > Probing for `National Semiconductor LM78'... Failed!
> > Probing for `National Semiconductor LM78-J'... Failed!
> > Probing for `National Semiconductor LM79'... Failed!
> > Probing for `Winbond W83781D'... Failed!
> > Probing for `Winbond W83782D'... Failed!
> > Probing for `Winbond W83627HF'... Failed!
> > Client found at address 0x22
> > Probing for `National Semiconductor LM78'... Failed!
> > Probing for `National Semiconductor LM78-J'... Failed!
> > Probing for `National Semiconductor LM79'... Failed!
> > Probing for `Winbond W83781D'... Failed!
> > Probing for `Winbond W83782D'... Failed!
> > Probing for `Winbond W83627HF'... Failed!
> > Client found at address 0x23
> > Probing for `National Semiconductor LM78'... Failed!
> > Probing for `National Semiconductor LM78-J'... Failed!
> > Probing for `National Semiconductor LM79'... Failed!
> > Probing for `Winbond W83781D'... Failed!
> > Probing for `Winbond W83782D'... Failed!
> > Probing for `Winbond W83627HF'... Failed!
> > Client at address 0x50 can not be probed - unload all client drivers first!
> > Client at address 0x51 can not be probed - unload all client drivers first!
> > Client found at address 0x52
>
> So it crashes right here?
>
> Please can you send output of following:
>
> power cycle system
> lspci -xxx
> modprobe i2c-dev
> modprobe i2c-piix4
> i2cdump -y 0 0x50
> i2cdetect 0
>
> (so without savage drivers and lm92)
>
> It should not crash yet. I guess it may crash due to 0x69 clockchip
>
> You may also try:
> Do you want to scan it? (YES/no/selectively): selectively
> 0x69
>
> this will avoid the clockchip and maybe it will not crash.
>
> Regards
> Rudolf
>

