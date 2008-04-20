From: "Juerg Haefliger" <juergh@gmail.com>
Date: Sun, 20 Apr 2008 19:00:39 +0000
Subject: Re: [lm-sensors] lm-sensors dme1737 driver
Message-Id: <191fb4ca0804201200r1147eb3cp5a77799bb662633f@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0804191351p1459f2c2g8d61e0170e32262e@mail.gmail.com>
In-Reply-To: <191fb4ca0804191351p1459f2c2g8d61e0170e32262e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Antonio,


On Sun, Apr 20, 2008 at 1:07 AM, Antonio Exp=F3sito <aelorenzo@gmail.com> w=
rote:
> Hi Juerg,
>
> I don't know any mail list information, so if you can give it to me I will
> be pleased to do it.
>
> 1) I have made the test that you ask me for:
>
>
>
> eye4:~# echo 100000 > /sys/class/hwmon/hwmon1/device/temp1_max
>
> eye4:~# sensors
> k8temp-pci-00c3
> Adapter: PCI adapter
> Core0 Temp:  +29.0=B0C
> Core1 Temp:  +31.0=B0C
>
> dme1737-i2c-0-2e
> Adapter: SMBus nForce2 adapter at 1c00
> V5stby:      +2.61 V  (min =3D  +0.00 V, max =3D  +6.64 V)
> Vccp:        +1.38 V  (min =3D  +0.00 V, max =3D  +2.99 V)
> V3.3:        +3.38 V  (min =3D  +0.00 V, max =3D  +4.38 V)
>
>  V5:          +5.07 V  (min =3D  +0.00 V, max =3D  +6.64 V)
> V12:        +11.94 V  (min =3D  +0.00 V, max =3D +15.94 V)
>
> V3.3stby:    +3.32 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> Vbat:        +3.01 V  (min =3D  +0.00 V, max =3D  +4.38 V)
>  CPU_Fan:    9608 RPM  (min =3D  800 RPM)
> Fan2:       2960 RPM  (min =3D  800 RPM)
> Fan3:       4166 RPM  (min =3D  800 RPM)
>
> Fan4:       9358 RPM  (min =3D  800 RPM)
> RD1 Temp:    +39.3=B0C  (low  =3D -20.0=B0C, high =3D +100.0=B0C)
>
>  Int Temp:    +28.6=B0C  (low  =3D -20.0=B0C, high =3D +60.0=B0C)
> CPU Temp:    +25.1=B0C  (low  =3D -20.0=B0C, high =3D +60.0=B0C)
> cpu0_vid:   +1.550 V
>
> dme1737-i2c-1-2e
> Adapter: SMBus nForce2 adapter at 1c40
> V5stby:      +2.61 V  (min =3D  +0.00 V, max =3D  +6.64 V)
> Vccp:        +1.38 V  (min =3D  +0.00 V, max =3D  +2.99 V)
> V3.3:        +3.37 V  (min =3D  +0.00 V, max =3D  +4.38 V)
>  V5:          +5.07 V  (min =3D  +0.00 V, max =3D  +6.64 V)
> V12:        +11.93 V  (min =3D  +0.00 V, max =3D +15.94 V)
> V3.3stby:    +3.32 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> Vbat:        +3.01 V  (min =3D  +0.00 V, max =3D  +4.38 V)
>  CPU_Fan:    9625 RPM  (min =3D  800 RPM)
> Fan2:       2957 RPM  (min =3D  800 RPM)
> Fan3:       4163 RPM  (min =3D  800 RPM)
> Fan4:       9326 RPM  (min =3D  800 RPM)
> RD1 Temp:    +39.7=B0C  (low  =3D -20.0=B0C, high =3D +100.0=B0C)
>
>  Int Temp:    +28.6=B0C  (low  =3D -20.0=B0C, high =3D +60.0=B0C)
> CPU Temp:    +25.1=B0C  (low  =3D -20.0=B0C, high =3D +60.0=B0C)
> cpu0_vid:   +1.550 V
>
> You are right, only one chip.

OK, that confirms the theory.


> So I decided to restart server because I was making a lot of testing with
> ipmi and sensors last day.
>
> Now, everything is fine (but it is only by now, later we recover the rare
> behaviour):
>
> eye4:~# sensors
> k8temp-pci-00c3
> Adapter: PCI adapter
> Core0 Temp:  +28.0=B0C
> Core1 Temp:  +31.0=B0C
>
> dme1737-i2c-0-2e
> Adapter: SMBus nForce2 adapter at 1c00
> V5stby:      +2.61 V  (min =3D  +0.00 V, max =3D  +6.64 V)
> Vccp:        +1.38 V  (min =3D  +0.00 V, max =3D  +2.99 V)
> V3.3:        +3.38 V  (min =3D  +0.00 V, max =3D  +4.38 V)
>
>  V5:          +5.07 V  (min =3D  +0.00 V, max =3D  +6.64 V)
> V12:        +11.95 V  (min =3D  +0.00 V, max =3D +15.94 V)
>
> V3.3stby:    +3.32 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> Vbat:        +3.02 V  (min =3D  +0.00 V, max =3D  +4.38 V)
>  CPU_Fan:    9591 RPM  (min =3D  800 RPM)
> Fan2:       2952 RPM  (min =3D  800 RPM)
> Fan3:       4147 RPM  (min =3D  800 RPM)
> Fan4:       9326 RPM  (min =3D  800 RPM)
> RD1 Temp:    +39.2=B0C  (low  =3D -20.0=B0C, high =3D +80.0=B0C)
>  Int Temp:    +27.2=B0C  (low  =3D -20.0=B0C, high =3D +60.0=B0C)
> CPU Temp:    +24.1=B0C  (low  =3D -20.0=B0C, high =3D +60.0=B0C)
>
> cpu0_vid:   +1.550 V
>
>
> Only a big temperature offset between k8 and dme drivers, May I calibrate=
 it
> using as reference ipmitool readings?

Some AMD chips are broken and report incorrect temps via the k8
driver. You have to ignore those values and trust ipmi or the dme1737
driver. The values between ipmi and dme1737 obviously match since they
both read from the same chip. Just some of the labels in sensors.conf
are swapped. I.e., V5stby should be Vddr, RD1 temp should be CPU temp,
CPU temp should be SYS temp and the fan  numbers need to be adjusted
to match the ipmi output. Having said that, I don't think it is safe
to use both ipmi and dme1737 at the same time since they both access
the same HW and there is no handshaking between the two. You could end
up with request collisions and unexpected and undesired results.


> 2) For testing loading dme driver log messages I unloaded the module and
> loaded it again (I unloaded also ipmi related drivers). Then, bogus
> behaviour is back again, two chips readings:
>
> eye4:~# /etc/init.d/ipmievd stop
> Stopping IPMI event daemon ipmievd.
>
>
> eye4:~# rmmod ipmi_si
>
>
> eye4:~# rmmod ipmi_devintf
>
>
> eye4:~# rmmod ipmi_msghandler
>
>
> eye4:~# rmmod dme1737
>
>
> eye4:~# sensors
> k8temp-pci-00c3
> Adapter: PCI adapter
> Core0 Temp:  +30.0=B0C
> Core1 Temp:  +33.0=B0C
>
> eye4:~# modprobe dme1737
>
>
> eye4:~# !ta
> tail -f /var/log/messages
>
> Apr 20 09:38:31 eye4 kernel:  : Read from register 0x3e failed! Please
> report to the driver maintainer.
> Apr 20 09:38:31 eye4 ipmievd: Waiting for events...
> Apr 20 09:38:32 eye4 kernel: warning: `ntpd' uses 32-bit capabilities
> (legacy support in use)
>  Apr 20 09:40:36 eye4 kernel: dme1737 0-002e: Read from register 0x67
> failed! Please report to the driver maintainer.
> Apr 20 09:46:10 eye4 kernel: dme1737 0-002e: Found a DME1737 chip at 0x2e
> (rev 0x89).
> Apr 20 09:46:10 eye4 kernel: dme1737 0-002e: Optional features: pwm3=3Dye=
s,
> pwm5=3Dno, pwm6=3Dno, fan3=3Dyes, fan4=3Dyes, fan5=3Dno, fan6=3Dno.
>  Apr 20 09:46:10 eye4 kernel: dme1737 0-002e: Non-standard fan to pwm
> mapping: fan1->pwm1, fan2->pwm2, fan3->pwm1, fan4->pwm3. Please report to
> the driver maintainer.
> Apr 20 09:46:10 eye4 kernel: dme1737 1-002e: Found a DME1737 chip at 0x2e
> (rev 0x89).
>  Apr 20 09:46:10 eye4 kernel: dme1737 1-002e: Optional features: pwm3=3Dy=
es,
> pwm5=3Dno, pwm6=3Dno, fan3=3Dyes, fan4=3Dyes, fan5=3Dno, fan6=3Dno.
> Apr 20 09:46:10 eye4 kernel: dme1737 1-002e: Non-standard fan to pwm
> mapping: fan1->pwm1, fan2->pwm2, fan3->pwm1, fan4->pwm3. Please report to
> the driver maintainer.
>  ^C
>
> (only messages at and after Apr 20 09:46:10 are relevant. Module loaded
> manually)
>
> At boot time I only get one set of these messages (at and after Apr 20
> 09:38:31 until Apr 20 09:38:31):
>
> Apr 20 09:38:30 eye4 kernel: NET: Registered protocol family 10
> Apr 20 09:38:30 eye4 kernel: lo: Disabled Privacy Extensions
> Apr 20 09:38:30 eye4 ipmievd: Reading sensors...
> Apr 20 09:38:31 eye4 kernel: dme1737 0-002e: Found a DME1737 chip at 0x2e
> (rev 0x89).
>  Apr 20 09:38:31 eye4 kernel: dme1737 0-002e: Optional features: pwm3=3Dy=
es,
> pwm5=3Dno, pwm6=3Dno, fan3=3Dyes, fan4=3Dyes, fan5=3Dno, fan6=3Dno.
> Apr 20 09:38:31 eye4 kernel: dme1737 0-002e: Non-standard fan to pwm
> mapping: fan1->pwm1, fan2->pwm2, fan3->pwm1, fan4->pwm3. Please report to
> the driver maintainer.
>  Apr 20 09:38:31 eye4 kernel:  : Read from register 0x3e failed! Please
> report to the driver maintainer.
> Apr 20 09:38:31 eye4 ipmievd: Waiting for events...
> Apr 20 09:38:32 eye4 kernel: warning: `ntpd' uses 32-bit capabilities
> (legacy support in use)
>  Apr 20 09:40:36 eye4 kernel: dme1737 0-002e: Read from register 0x67
> failed! Please report to the driver maintainer.
> Apr 20 09:46:10 eye4 kernel: dme1737 0-002e: Found a DME1737 chip at 0x2e
> (rev 0x89).
> Apr 20 09:46:10 eye4 kernel: dme1737 0-002e: Optional features: pwm3=3Dye=
s,
> pwm5=3Dno, pwm6=3Dno, fan3=3Dyes, fan4=3Dyes, fan5=3Dno, fan6=3Dno.
>  Apr 20 09:46:10 eye4 kernel: dme1737 0-002e: Non-standard fan to pwm
> mapping: fan1->pwm1, fan2->pwm2, fan3->pwm1, fan4->pwm3. Please report to
> the driver maintainer.
> Apr 20 09:46:10 eye4 kernel: dme1737 1-002e: Found a DME1737 chip at 0x2e
> (rev 0x89).
>  Apr 20 09:46:10 eye4 kernel: dme1737 1-002e: Optional features: pwm3=3Dy=
es,
> pwm5=3Dno, pwm6=3Dno, fan3=3Dyes, fan4=3Dyes, fan5=3Dno, fan6=3Dno.
> Apr 20 09:46:10 eye4 kernel: dme1737 1-002e: Non-standard fan to pwm
> mapping: fan1->pwm1, fan2->pwm2, fan3->pwm1, fan4->pwm3. Please report to
> the driver maintainer.
>
>
> And now, after loading manually dme driver, I get two chip data reading w=
ith
> sensors:
>
> eye4:~# sensors
> k8temp-pci-00c3
> Adapter: PCI adapter
> Core0 Temp:  +30.0=B0C
> Core1 Temp:  +31.0=B0C
>
> dme1737-i2c-0-2e
> Adapter: SMBus nForce2 adapter at 1c00
> V5stby:      +2.61 V  (min =3D  +0.00 V, max =3D  +6.64 V)
> Vccp:        +1.38 V  (min =3D  +0.00 V, max =3D  +2.99 V)
> V3.3:        +3.37 V  (min =3D  +0.00 V, max =3D  +4.38 V)
>  V5:          +5.07 V  (min =3D  +0.00 V, max =3D  +6.64 V)
> V12:        +11.93 V  (min =3D  +0.00 V, max =3D +15.94 V)
> V3.3stby:    +3.32 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> Vbat:        +3.01 V  (min =3D  +0.00 V, max =3D  +4.38 V)
>  CPU_Fan:    9608 RPM  (min =3D  800 RPM)
> Fan2:       2954 RPM  (min =3D  800 RPM)
> Fan3:       4153 RPM  (min =3D  800 RPM)
> Fan4:       9326 RPM  (min =3D  800 RPM)
> RD1 Temp:    +40.6=B0C  (low  =3D -20.0=B0C, high =3D +80.0=B0C)
>
>  Int Temp:    +28.6=B0C  (low  =3D -20.0=B0C, high =3D +60.0=B0C)
> CPU Temp:    +25.1=B0C  (low  =3D -20.0=B0C, high =3D +60.0=B0C)
> cpu0_vid:   +1.550 V
>
> dme1737-i2c-1-2e
> Adapter: SMBus nForce2 adapter at 1c40
> V5stby:      +2.61 V  (min =3D  +0.00 V, max =3D  +6.64 V)
> Vccp:        +1.38 V  (min =3D  +0.00 V, max =3D  +2.99 V)
> V3.3:        +3.37 V  (min =3D  +0.00 V, max =3D  +4.38 V)
>  V5:          +5.07 V  (min =3D  +0.00 V, max =3D  +6.64 V)
> V12:        +11.93 V  (min =3D  +0.00 V, max =3D +15.94 V)
> V3.3stby:    +3.32 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> Vbat:        +3.01 V  (min =3D  +0.00 V, max =3D  +4.38 V)
>  CPU_Fan:    9608 RPM  (min =3D  800 RPM)
> Fan2:       2952 RPM  (min =3D  800 RPM)
> Fan3:       4153 RPM  (min =3D  800 RPM)
> Fan4:       9326 RPM  (min =3D  800 RPM)
> RD1 Temp:    +40.4=B0C  (low  =3D -20.0=B0C, high =3D +80.0=B0C)
>  Int Temp:    +28.4=B0C  (low  =3D -20.0=B0C, high =3D +60.0=B0C)
>
> CPU Temp:    +25.1=B0C  (low  =3D -20.0=B0C, high =3D +60.0=B0C)
> cpu0_vid:   +1.550 V
>
> It seems that when I loaded dme driver manually it interacts with another
> drivers and get bogus information.
>
> Is there any way to know the moduled loading sequence?

Not that I'm aware of. Watch the log for driver messages.


> 3) Then, I do a clean reboot to avoid any interference in the query resul=
ts
> for lsmod and lspci (to get clean rebooted state), but when I ran sensors=
...
>
> eye4:~# sensors
> k8temp-pci-00c3
> Adapter: PCI adapter
> Core0 Temp:  +30.0=B0C
> Core1 Temp:  +31.0=B0C
>
> dme1737-i2c-0-2e
> Adapter: SMBus nForce2 adapter at 1c00
> V5stby:      +2.61 V  (min =3D  +0.00 V, max =3D  +6.64 V)
> Vccp:        +1.38 V  (min =3D  +0.00 V, max =3D  +2.99 V)
> V3.3:        +3.38 V  (min =3D  +0.00 V, max =3D  +4.38 V)
>
>  V5:          +5.07 V  (min =3D  +0.00 V, max =3D  +6.64 V)
> V12:        +11.94 V  (min =3D  +0.00 V, max =3D +15.94 V)
>
> V3.3stby:    +3.32 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> Vbat:        +3.02 V  (min =3D  +0.00 V, max =3D  +4.38 V)
>  CPU_Fan:    9591 RPM  (min =3D  800 RPM)
> Fan2:       2957 RPM  (min =3D  800 RPM)
> Fan3:       4153 RPM  (min =3D  800 RPM)
>
> Fan4:       9342 RPM  (min =3D  800 RPM)
> RD1 Temp:    +40.1=B0C  (low  =3D -20.0=B0C, high =3D +80.0=B0C)
>  Int Temp:    +27.8=B0C  (low  =3D -20.0=B0C, high =3D +60.0=B0C)
> CPU Temp:    +24.7=B0C  (low  =3D -20.0=B0C, high =3D +60.0=B0C)
>
> cpu0_vid:   +1.550 V
>
> dme1737-i2c-1-2e
> Adapter: SMBus nForce2 adapter at 1c40
> V5stby:      +2.61 V  (min =3D  +0.00 V, max =3D  +6.64 V)
> Vccp:        +1.38 V  (min =3D  +0.00 V, max =3D  +2.99 V)
> V3.3:        +3.38 V  (min =3D  +0.00 V, max =3D  +4.38 V)
>
>  V5:          +5.07 V  (min =3D  +0.00 V, max =3D  +6.64 V)
> V12:        +11.93 V  (min =3D  +0.00 V, max =3D +15.94 V)
> V3.3stby:    +3.32 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> Vbat:        +3.01 V  (min =3D  +0.00 V, max =3D  +4.38 V)
>  CPU_Fan:    9591 RPM  (min =3D  800 RPM)
> Fan2:       2957 RPM  (min =3D  800 RPM)
> Fan3:       4153 RPM  (min =3D  800 RPM)
> Fan4:       9326 RPM  (min =3D  800 RPM)
> RD1 Temp:    +40.2=B0C  (low  =3D -20.0=B0C, high =3D +80.0=B0C)
>  Int Temp:    +27.9=B0C  (low  =3D -20.0=B0C, high =3D +60.0=B0C)
> CPU Temp:    +24.7=B0C  (low  =3D -20.0=B0C, high =3D +60.0=B0C)
>
> cpu0_vid:   +1.550 V
>
>
> AAAAAAAAAAAAAGGGGGGGGGGGGGGGGGG!!!!!!!!!!!!!!!!!!
>
> Same bogus readings, two chips!
>
> Is it random?

I don't think it's random we just don't know yet what causes this
behavior. My guess is it's the ipmi driver. Can you completely disable
it, reboot and check for the number of detected dme1737s? And then do
a couple of manual dme1737 module reloads and check if the problem
shows up again.

Also, can you run the following commands for both cases (one dme1737
and 2 dme1737s detected)?
modprobe i2c-dev
i2cdetect -y 0
i2cdetect -y 1


...juerg


> I give you a real sequence of the things that I have done:
>
> Here you have lsmod and lspci data:
>
> eye4:~# lsmod
> Module                  Size  Used by
> dme1737                46496  0
> hwmon_vid               7552  1 dme1737
> ipv6                  280808  22
> dm_mod                 65584  0
> ipmi_devintf           16144  2
>  ipmi_si                49132  1
> ipmi_msghandler        43000  2 ipmi_devintf,ipmi_si
> ide_generic             5760  0 [permanent]
> ide_disk               20224  0
> ide_cd_mod             41760  0
> cdrom                  39720  1 ide_cd_mod
>  ata_generic            13700  0
> amd74xx                13704  0 [permanent]
> usbhid                 35296  0
> hid                    37636  1 usbhid
> psmouse                45852  0
> ide_pci_generic         9604  0 [permanent]
>  forcedeth              55308  0
> pcspkr                  8064  0
> evdev                  17408  0
> serio_raw              11908  0
> k8temp                 10624  0
> tg3                   118020  0
> ide_core              133544  5
> ide_generic,ide_disk,ide_cd_mod,amd74xx,ide_pci_generic
>  ehci_hcd               39180  0
> ohci_hcd               27908  0
> thermal                26784  0
> i2c_nforce2            11648  0
> i2c_core               30880  2 dme1737,i2c_nforce2
> processor              48748  1 thermal
>  button                 13984  0
> sd_mod                 33984  7
>
>
>
> eye4:~# lspci -vnn
> 00:00.0 Memory controller [0580]: nVidia Corporation CK804 Memory Control=
ler
> [10de:005e] (rev a3)
>         Subsystem: Sun Microsystems Computer Corp. Unknown device
> [108e:5348]
>         Flags: bus master, 66MHz, fast devsel, latency 0
>          Capabilities: [44] HyperTransport: Slave or Primary Interface
>         Capabilities: [e0] HyperTransport: MSI Mapping
>
> 00:01.0 ISA bridge [0601]: nVidia Corporation CK804 ISA Bridge [10de:0050]
> (rev a3)
>         Subsystem: Sun Microsystems Computer Corp. Unknown device
> [108e:5348]
>         Flags: bus master, 66MHz, fast devsel, latency 0
>
> 00:01.1 SMBus [0c05]: nVidia Corporation CK804 SMBus [10de:0052] (rev a2)
>         Subsystem: Sun Microsystems Computer Corp. Unknown device
> [108e:5348]
>         Flags: 66MHz, fast devsel, IRQ 5
>         I/O ports at fc00 [size2]
>          I/O ports at 1c00 [sized]
>         I/O ports at 1c40 [sized]
>         Capabilities: [44] Power Management version 2
>
> 00:02.0 USB Controller [0c03]: nVidia Corporation CK804 USB Controller
> [10de:005a] (rev a2) (prog-if 10 [OHCI])
>         Subsystem: Sun Microsystems Computer Corp. Unknown device
> [108e:5348]
>         Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 21
>          Memory at fe02f000 (32-bit, non-prefetchable) [size=3D4K]
>         Capabilities: [44] Power Management version 2
>
> 00:02.1 USB Controller [0c03]: nVidia Corporation CK804 USB Controller
> [10de:005b] (rev a3) (prog-if 20 [EHCI])
>         Subsystem: Sun Microsystems Computer Corp. Unknown device
> [108e:5348]
>         Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 20
>          Memory at feb00000 (32-bit, non-prefetchable) [size%6]
>         Capabilities: [44] Debug port
>         Capabilities: [80] Power Management version 2
>
> 00:06.0 IDE interface [0101]: nVidia Corporation CK804 IDE [10de:0053] (r=
ev
> f2) (prog-if 8a [Master SecP PriP])
>         Subsystem: Sun Microsystems Computer Corp. Unknown device
> [108e:5348]
>         Flags: bus master, 66MHz, fast devsel, latency 0
>          [virtual] Memory at 000001f0 (32-bit, non-prefetchable) [disable=
d]
> [size=3D8]
>         [virtual] Memory at 000003f0 (type 3, non-prefetchable) [disabled]
> [size=3D1]
>         [virtual] Memory at 00000170 (32-bit, non-prefetchable) [disabled]
> [size=3D8]
>          [virtual] Memory at 00000370 (type 3, non-prefetchable) [disable=
d]
> [size=3D1]
>         I/O ports at e800 [size=16]
>         Capabilities: [44] Power Management version 2
>
> 00:07.0 IDE interface [0101]: nVidia Corporation CK804 Serial ATA Control=
ler
> [10de:0054] (rev f3) (prog-if 85 [Master SecO PriO])
>         Subsystem: Sun Microsystems Computer Corp. Unknown device
> [108e:5348]
>         Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 23
>          I/O ports at 09f0 [size=3D8]
>         I/O ports at 0bf0 [size=3D4]
>         I/O ports at 0970 [size=3D8]
>         I/O ports at 0b70 [size=3D4]
>         I/O ports at d400 [size=16]
>         Memory at fe02c000 (32-bit, non-prefetchable) [size=3D4K]
>          Capabilities: [44] Power Management version 2
>
> 00:08.0 IDE interface [0101]: nVidia Corporation CK804 Serial ATA Control=
ler
> [10de:0055] (rev f3) (prog-if 85 [Master SecO PriO])
>         Subsystem: Sun Microsystems Computer Corp. Unknown device
> [108e:5348]
>         Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 22
>          I/O ports at 09e0 [size=3D8]
>         I/O ports at 0be0 [size=3D4]
>         I/O ports at 0960 [size=3D8]
>         I/O ports at 0b60 [size=3D4]
>         I/O ports at c000 [size=16]
>         Memory at fe02b000 (32-bit, non-prefetchable) [size=3D4K]
>          Capabilities: [44] Power Management version 2
>
> 00:09.0 PCI bridge [0604]: nVidia Corporation CK804 PCI Bridge [10de:005c]
> (rev a2) (prog-if 01 [Subtractive decode])
>         Flags: bus master, 66MHz, fast devsel, latency 0
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency2
>          I/O behind bridge: 0000a000-0000afff
>         Memory behind bridge: fb000000-fcffffff
>         Prefetchable memory behind bridge: fdf00000-fdffffff
>
> 00:0a.0 Bridge [0680]: nVidia Corporation CK804 Ethernet Controller
> [10de:0057] (rev a3)
>         Subsystem: Sun Microsystems Computer Corp. Unknown device
> [108e:5348]
>         Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 23
>          Memory at fe02a000 (32-bit, non-prefetchable) [size=3D4K]
>         I/O ports at bc00 [size=3D8]
>         Capabilities: [44] Power Management version 2
>
> 00:0b.0 PCI bridge [0604]: nVidia Corporation CK804 PCIE Bridge [10de:005=
d]
> (rev a3) (prog-if 00 [Normal decode])
>         Flags: bus master, fast devsel, latency 0
>         Bus: primary=00, secondary=02, subordinate=02, sec-latency=3D0
>          I/O behind bridge: 00009000-00009fff
>         Memory behind bridge: fde00000-fdefffff
>         Prefetchable memory behind bridge: 00000000fdd00000-00000000fddff=
fff
>         Capabilities: [40] Power Management version 2
>          Capabilities: [48] Message Signalled Interrupts: Mask- 64bit+
> Queue=3D0/1 Enable+
>         Capabilities: [58] HyperTransport: MSI Mapping
>         Capabilities: [80] Express Root Port (Slot+) IRQ 0
>
> 00:0c.0 PCI bridge [0604]: nVidia Corporation CK804 PCIE Bridge [10de:005=
d]
> (rev a3) (prog-if 00 [Normal decode])
>         Flags: bus master, fast devsel, latency 0
>         Bus: primary=00, secondary=03, subordinate=03, sec-latency=3D0
>          I/O behind bridge: 00008000-00008fff
>         Memory behind bridge: fdc00000-fdcfffff
>         Prefetchable memory behind bridge: 00000000fdb00000-00000000fdbff=
fff
>         Capabilities: [40] Power Management version 2
>          Capabilities: [48] Message Signalled Interrupts: Mask- 64bit+
> Queue=3D0/1 Enable+
>         Capabilities: [58] HyperTransport: MSI Mapping
>         Capabilities: [80] Express Root Port (Slot+) IRQ 0
>
> 00:0d.0 PCI bridge [0604]: nVidia Corporation CK804 PCIE Bridge [10de:005=
d]
> (rev a3) (prog-if 00 [Normal decode])
>         Flags: bus master, fast devsel, latency 0
>         Bus: primary=00, secondary=04, subordinate=04, sec-latency=3D0
>          I/O behind bridge: 00007000-00007fff
>         Memory behind bridge: fda00000-fdafffff
>         Prefetchable memory behind bridge: 00000000fd900000-00000000fd9ff=
fff
>         Capabilities: [40] Power Management version 2
>          Capabilities: [48] Message Signalled Interrupts: Mask- 64bit+
> Queue=3D0/1 Enable+
>         Capabilities: [58] HyperTransport: MSI Mapping
>         Capabilities: [80] Express Root Port (Slot+) IRQ 0
>
> 00:0e.0 PCI bridge [0604]: nVidia Corporation CK804 PCIE Bridge [10de:005=
d]
> (rev a3) (prog-if 00 [Normal decode])
>         Flags: bus master, fast devsel, latency 0
>         Bus: primary=00, secondary=05, subordinate=05, sec-latency=3D0
>          I/O behind bridge: 00006000-00006fff
>         Memory behind bridge: fd800000-fd8fffff
>         Prefetchable memory behind bridge: 00000000fd700000-00000000fd7ff=
fff
>         Capabilities: [40] Power Management version 2
>          Capabilities: [48] Message Signalled Interrupts: Mask- 64bit+
> Queue=3D0/1 Enable+
>         Capabilities: [58] HyperTransport: MSI Mapping
>         Capabilities: [80] Express Root Port (Slot+) IRQ 0
>
> 00:18.0 Host bridge [0600]: Advanced Micro Devices [AMD] K8
> [Athlon64/Opteron] HyperTransport Technology Configuration [1022:1100]
>         Flags: fast devsel
>         Capabilities: [80] HyperTransport: Host or Secondary Interface
>
> 00:18.1 Host bridge [0600]: Advanced Micro Devices [AMD] K8
> [Athlon64/Opteron] Address Map [1022:1101]
>         Flags: fast devsel
>
> 00:18.2 Host bridge [0600]: Advanced Micro Devices [AMD] K8
> [Athlon64/Opteron] DRAM Controller [1022:1102]
>         Flags: fast devsel
>
> 00:18.3 Host bridge [0600]: Advanced Micro Devices [AMD] K8
> [Athlon64/Opteron] Miscellaneous Control [1022:1103]
>         Flags: fast devsel
>
> 01:05.0 VGA compatible controller [0300]: ATI Technologies Inc Rage XL
> [1002:4752] (rev 27) (prog-if 00 [VGA])
>         Subsystem: Sun Microsystems Computer Corp. Unknown device
> [108e:5347]
>         Flags: bus master, stepping, medium devsel, latency 32, IRQ 5
>          Memory at fb000000 (32-bit, non-prefetchable) [size=16M]
>         I/O ports at ac00 [size%6]
>         Memory at fcfff000 (32-bit, non-prefetchable) [size=3D4K]
>         Capabilities: [5c] Power Management version 2
>
> 04:00.0 Ethernet controller [0200]: Broadcom Corporation NetXtreme BCM5721
> Gigabit Ethernet PCI Express [14e4:1659] (rev 11)
>         Subsystem: Sun Microsystems Computer Corp. Unknown device
> [108e:5348]
>         Flags: bus master, fast devsel, latency 0, IRQ 19
>          Memory at fdaf0000 (64-bit, non-prefetchable) [sizedK]
>         Capabilities: [48] Power Management version 2
>         Capabilities: [50] Vital Product Data
>         Capabilities: [58] Message Signalled Interrupts: Mask- 64bit+
> Queue=3D0/3 Enable-
>          Capabilities: [d0] Express Endpoint IRQ 0
>
>
>
> Any clue?
>
> Best regards,
>
> Antonio
>
>
> 2008/4/19, Juerg Haefliger <juergh@gmail.com>:
>
>
>
> > Hi Antonio,
> >
> > CC'ing the list for others to enjoy :-)
> >
> >
> > > Hi Juerg:
> > >
> > > I am using sensors version 3.0.1 with libsensors version 3.0.1, with
> driver
> > > dme1737 kernel 2.6.25 in 8 Sun Fire X2100 servers. I get the following
> > > output from sensors and ipmitool (ipmitool give similar results than
> BIOS
> > > HWMON so I think that everything is correct):
> > >
> > > eye4:~# sensors
> > >
> > > k8temp-pci-00c3
> > > Adapter: PCI adapter
> > > Core0 Temp:  +31.0=B0C
> > > Core1 Temp:  +32.0=B0C
> > >
> > >
> > > dme1737-i2c-0-2e
> > > Adapter: SMBus nForce2 adapter at 1c00
> > > V5stby:      +2.61 V  (min =3D  +0.00 V, max =3D  +6.64 V)
> > > Vccp:        +1.38 V  (min =3D  +0.00 V, max =3D  +2.99 V)
> > > V3.3:        +3.37 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> > >  V5:          +5.07 V  (min =3D  +0.00 V, max =3D  +6.64 V)
> > > V12:        +11.93 V  (min =3D  +0.00 V, max =3D +15.94 V)
> > > V3.3stby:    +3.32 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> > > Vbat:        +3.01 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> > >  CPU_Fan:    9608 RPM  (min =3D  800 RPM)
> > > Fan2:       2965 RPM  (min =3D  800 RPM)
> > > Fan3:       4169 RPM  (min =3D  800 RPM)
> > > Fan4:       9358 RPM  (min =3D  800 RPM)
> > > RD1 Temp:    +40.3=B0C  (low  =3D -20.0=B0C, high =3D +80.0=B0C)
> > >  Int Temp:    +28.6=B0C  (low  =3D -20.0=B0C, high =3D +60.0=B0C)
> > > CPU Temp:    +25.1=B0C  (low  =3D -20.0=B0C, high =3D +60.0=B0C)
> > > cpu0_vid:   +1.550 V
> > >
> > > dme1737-i2c-1-2e
> > > Adapter: SMBus nForce2 adapter at 1c40
> > > V5stby:      +2.61 V  (min =3D  +0.00 V, max =3D  +6.64 V)
> > > Vccp:        +1.38 V  (min =3D  +0.00 V, max =3D  +2.99 V)
> > > V3.3:        +3.37 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> > >  V5:          +5.07 V  (min =3D  +0.00 V, max =3D  +6.64 V)
> > > V12:        +11.93 V  (min =3D  +0.00 V, max =3D +15.94 V)
> > > V3.3stby:    +3.32 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> > > Vbat:        +3.01 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> > >  CPU_Fan:    9608 RPM  (min =3D  800 RPM)
> > > Fan2:       2963 RPM  (min =3D  800 RPM)
> > > Fan3:       4169 RPM  (min =3D  800 RPM)
> > > Fan4:       9342 RPM  (min =3D  800 RPM)
> > > RD1 Temp:    +41.1=B0C  (low  =3D -20.0=B0C, high =3D +80.0=B0C)
> > >  Int Temp:    +28.6=B0C  (low  =3D -20.0=B0C, high =3D +60.0=B0C)
> > > CPU Temp:    +25.2=B0C  (low  =3D -20.0=B0C, high =3D +60.0=B0C)
> > > cpu0_vid:   +1.550 V
> >
> > Two dme1737 detected? That looks fishy. According to some SUN
> > documents, there's only a single Super-IO in the X2100 server. Could
> > it be that you have two i2c masters connected to the same bus? Try to
> > write one of the temp limit registers in one dme1737 (see below) and
> > check if the value in the other one changes as well. That would
> > indicate a single dme1737 chip but seen twice by the driver.
> >
> > Do
> > echo 100000 > /sys/class/hwmon/hwmon1/device/temp1_max
> > followed by 'sensors'. Check if both high limits for RD1 temp schow 100C
> now.
> >
> >
> >
> > > eye4:~# ipmitool sdr
> > > DDR 2.6V         | 2.60 Volts        | ok
> > > CPU core Voltage | 1.37 Volts        | ok
> > > VCC 3.3V         | 3.35 Volts        | ok
> > > VCC 5V           | 5.04 Volts        | ok
> > > VCC 12V          | 11.97 Volts       | ok
> > >  Battery Volt     | 2.99 Volts        | ok
> > > CPU TEMP         | 40 degrees C      | ok
> > > SYS TEMP         | 25 degrees C      | ok
> > > CPU FAN          | 9540 RPM          | ok
> > > SYSTEM FAN3      | 2970 RPM          | ok
> > >  SYSTEM FAN1      | 4140 RPM          | ok
> > > SYSTEM FAN2      | 9270 RPM          | ok
> > >
> > >
> > > Only some readings seem to be swapped, I will change them in the
> > > sensors.conf. But I get the following messages in
> > >
> > > eye4:~# grep "dme" /var/log/messages
> > > Apr 18 15:50:48 eye4 kernel: dme1737 0-002e: Found a DME1737 chip at
> 0x2e
> > > (rev 0x89).
> > > Apr 18 15:50:48 eye4 kernel: dme1737 0-002e: Optional features:
> pwm3=3Dyes,
> > > pwm5=3Dno, pwm6=3Dno, fan3=3Dyes, fan4=3Dyes, fan5=3Dno, fan6=3Dno.
> > >  Apr 18 15:50:48 eye4 kernel: dme1737 0-002e: Non-standard fan to pwm
> > > mapping: fan1->pwm1, fan2->pwm2, fan3->pwm1, fan4->pwm3. Please report
> to
> > > the driver maintainer.
> > > Apr 18 15:50:59 eye4 kernel: dme1737 0-002e: Read from register 0x32
> failed!
> > > Please report to the driver maintainer.
> > >  Apr 18 16:36:47 eye4 kernel: dme1737 0-002e: Found a DME1737 chip at
> 0x2e
> > > (rev 0x89).
> > > Apr 18 16:36:47 eye4 kernel: dme1737 0-002e: Optional features:
> pwm3=3Dyes,
> > > pwm5=3Dno, pwm6=3Dno, fan3=3Dyes, fan4=3Dyes, fan5=3Dno, fan6=3Dno.
> > >  Apr 18 16:36:47 eye4 kernel: dme1737 0-002e: Non-standard fan to pwm
> > > mapping: fan1->pwm1, fan2->pwm2, fan3->pwm1, fan4->pwm3. Please report
> to
> > > the driver maintainer.
> > > Apr 18 16:36:47 eye4 kernel: dme1737 1-002e: Found a DME1737 chip at
> 0x2e
> > > (rev 0x89).
> > >  Apr 18 16:36:47 eye4 kernel: dme1737 1-002e: Optional features:
> pwm3=3Dyes,
> > > pwm5=3Dno, pwm6=3Dno, fan3=3Dyes, fan4=3Dyes, fan5=3Dno, fan6=3Dno.
> > > Apr 18 16:36:47 eye4 kernel: dme1737 1-002e: Non-standard fan to pwm
> > > mapping: fan1->pwm1, fan2->pwm2, fan3->pwm1, fan4->pwm3. Please report
> to
> > > the driver maintainer.
> > >  Apr 18 16:37:44 eye4 kernel: dme1737 0-002e: Read from register 0x2d
> > > failed! Please report to the driver maintainer.
> > > Apr 18 16:39:52 eye4 kernel: dme1737 0-002e: Found a DME1737 chip at
> 0x2e
> > > (rev 0x89).
> > > Apr 18 16:39:52 eye4 kernel: dme1737 0-002e: Optional features:
> pwm3=3Dyes,
> > > pwm5=3Dno, pwm6=3Dno, fan3=3Dyes, fan4=3Dyes, fan5=3Dno, fan6=3Dno.
> > >  Apr 18 16:39:52 eye4 kernel: dme1737 0-002e: Non-standard fan to pwm
> > > mapping: fan1->pwm1, fan2->pwm2, fan3->pwm1, fan4->pwm3. Please report
> to
> > > the driver maintainer.
> > > Apr 18 16:39:52 eye4 kernel: dme1737 1-002e: Found a DME1737 chip at
> 0x2e
> > > (rev 0x89).
> > >  Apr 18 16:39:52 eye4 kernel: dme1737 1-002e: Optional features:
> pwm3=3Dyes,
> > > pwm5=3Dno, pwm6=3Dno, fan3=3Dyes, fan4=3Dyes, fan5=3Dno, fan6=3Dno.
> > > Apr 18 16:39:52 eye4 kernel: dme1737 1-002e: Non-standard fan to pwm
> > > mapping: fan1->pwm1, fan2->pwm2, fan3->pwm1, fan4->pwm3. Please report
> to
> > > the driver maintainer.
> > >  Apr 18 16:43:03 eye4 kernel: dme1737 0-002e: Read from register 0x52
> > > failed! Please report to the driver maintainer.
> > > Apr 18 17:29:52 eye4 kernel: dme1737 0-002e: Read from register 0x48
> failed!
> > > Please report to the driver maintainer.
> > >  Apr 18 17:29:52 eye4 kernel: dme1737 0-002e: Read from register 0x4c
> > > failed! Please report to the driver maintainer.
> > > Apr 18 17:29:52 eye4 kernel: dme1737 0-002e: Read from register 0x9b
> failed!
> > > Please report to the driver maintainer.
> > >  Apr 18 17:29:53 eye4 kernel: dme1737 1-002e: Read from register 0x2c
> > > failed! Please report to the driver maintainer.
> > > Apr 19 10:02:15 eye4 kernel: dme1737 0-002e: Read from register 0x6b
> failed!
> > > Please report to the driver maintainer.
> >
> > Hmm... did you reload the dme1737 module multiple times? Can you
> > unload the module, reload it and send the messages generated from that
> > single module load operation?
> >
> >
> > >
> > > Is everything OK?
> >
> > Not really :-) The failed register reads and non-standard fan-pwm
> > mappings aren't good. Maybe there's a conflict with ACPI (or IPMI).
> > I'm assuming you have a bmc or ipmi module loaded. Can you send the
> > outputs of 'lsmod' and 'lspci -vnn'? And please run 'cat
> > /proc/acpi/dsdt > dsdt.aml' and send me the dsdt.aml file in private.
> > Try unloading the ipmi/bmc module and reload the dme1737 module and
> > check if the read errors went away.
> >
> > ...juerg
> >
> >
> >
> > > If you need more information about hardware or software setup, plz,
> don't
> > > hesitate to ask me.
> > >
> > > I would like to thank you for the development of the dme driver... It
> was
> > > long time awaited!
> > >
> > > Best regards,
> > >
> > > Antonio Exp=F3sito
> >
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
