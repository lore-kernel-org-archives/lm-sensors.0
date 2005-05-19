From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: Wrong TEMP anc FAN speed.
Message-Id: <3EE4DE39.FB2917C2@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.GSO.3.95.1030609011547.11222A-100000@razor>
In-Reply-To: <Pine.GSO.3.95.1030609011547.11222A-100000@razor>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

it's unlikely you have a lm80.
2.6.3 is very old. Get release 2.7.0 and try again.

Nejc Buzinel wrote:
> 
> Hello. I'm writing you because i get the wrong values of cputemp and
> fan speed when running 'sensors'. I have MSI K7T Turbo motherboard
> with VIA VT8363 Chipset, AMD Thunderbird processor.
> The lm_sensors is version 2.6.3-5 and i'm running linux 2.4.18.
> 
> I inserted all the modules with help of 'sensors-detect', and when running
> 'sensors' it comes this out:
> 
> lm80-i2c-0-2d
> Adapter: SMBus Via Pro adapter at 5000
> Algorithm: Non-I2C SMBus adapter
> +5V:       +5.05 V  (min =  +4.74 V, max =  +6.71 V)   ALARM
> VTT:       +1.52 V  (min =  +1.90 V, max =  +2.10 V)   ALARM
> +3.3V:     +2.54 V  (min =  +3.13 V, max =  +3.46 V)   ALARM
> +Vcore:    +0.27 V  (min =  +1.80 V, max =  +1.99 V)   ALARM
> +12V:     +12.95 V  (min = +11.37 V, max = +12.57 V)   ALARM
> -12V:     -12.51 V  (min = -12.73 V, max = -11.53 V)
> -5V:       -4.59 V  (min =  -5.34 V, max =  -4.82 V)
> fan1:     10546 RPM  (min = 6000 RPM, div = 1)
> fan2:       -1 RPM  (min = 6000 RPM, div = 1)
> temp:     -128.00 0C (hot:limit =  +60C,  hysteresis =  +50C) ALARM
>          (os: limit =  +60C,  hysteresis =  +50C) ALARM
> alarms:   Board temperature input (LM75)               ALARM
> 
> eeprom-i2c-0-51
> Adapter: SMBus Via Pro adapter at 5000
> Algorithm: Non-I2C SMBus adapter
> Memory type:            SDRAM DIMM SPD
> SDRAM Size (MB):        128
> 
> Here is also an output of 'lspci':
> 
> 00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev
> 03)
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
> 00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
> (rev 40)
> 00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
> 00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
> 00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
> 00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
> (rev 40)
> 00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio
> Controller (rev 50)
> 00:0a.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev
> 08)
> 00:0a.1 Input device controller: Creative Labs SB Live! (rev 08)
> 00:0e.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
> (rev 34)
> 01:00.0 VGA compatible controller: nVidia Corporation NV11 (GeForce2 MX)
> (rev a1)
> 
> If it is possible, i would be really grateful if you can solve my problem.
> 
> Thanx for now and keep the good work!
> 
> Greetings
> 
> Nejc (Nejc.Buzinel@guest.arnes.si)
