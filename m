From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:40 +0000
Subject: A follow-up with Ticket #659 (Sensors voltages incorrect GL518)
Message-Id: <3DA772D3.43F29132@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.44.0210061636490.11096-100000@home.apu.edu>
In-Reply-To: <Pine.LNX.4.44.0210061636490.11096-100000@home.apu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

strange. the only thing I can think is that the CPU change sped up the
i2c clock which caused reads to be unreliable or something.
If so, repeated i2cdumps (for example i2cdump 0 0x50 or i2cdump 0 0x2d)
might show differences or failures.
But not so likely.
You could try upgrading lm_sensors but I don't see anything in the gl518
changelog that would make a difference.
Perhaps there is a bug in setting iterate?

good luck
mds


Phillip Pi wrote:
> 
> I recently replaced the CPU from a Pentium II 300 Mhz to a Pentium III 600
> Mhz on the motherboard. I also switched NIC (3com to Intel), but I didn't
> think this affected lm_sensors.
> 
> The problem is that I lost the voltage values in lm_sensors from minor
> hardware upgrade. I can see the values in BIOS and with Windows programs
> (e.g., Motherboard Monitor [new version]). I reread the ticket and
> doc/chips/gl518sm documentation, and tried set iterate, but it was already
> set. I am still using the same versions (never upgraded) of i2c and
> lm_sensors: lm_sensors-2.5.5-3 lm_sensors-devel-2.5.5-3
> 
> Kernel is v2.4.9-34: Linux ANTux-P3 2.4.9-34 #1 Sat Jun 1 06:25:16 EDT
> 2002 i686 unknown ... I upgraded from RedHat's up2date program.
> 
> [ant@ANTux-P3 ant]$ sensors -f
> gl518sm-i2c-0-2d
> Adapter: SMBus PIIX4 adapter at 5000
> Algorithm: Non-I2C SMBus adapter
> +5V:       +0.00 V  (min =  +4.50 V, max =  +5.49 V)
> +3.3V:     +0.00 V  (min =  +2.96 V, max =  +3.62 V)
> +12V:      +0.00 V  (min = +10.81 V, max = +13.12 V)
> Vcore:     +1.52 V  (min =  +2.33 V, max =  +2.85 V)   ALARM
> fan1:     9230 RPM  (min = 3000 RPM, div = 2)
> fan2:     9795 RPM  (min = 3000 RPM, div = 2)
> temp:     +104.0F  (limit = +140F, hysteresis = +122F)
> beep_enable:
>           Sound alarm disabled
> 
> eeprom-i2c-0-50
> Adapter: SMBus PIIX4 adapter at 5000
> Algorithm: Non-I2C SMBus adapter
> Memory type:            SDRAM DIMM SPD
> SDRAM Size (MB):        128
> 
> eeprom-i2c-0-51
> Adapter: SMBus PIIX4 adapter at 5000
> Algorithm: Non-I2C SMBus adapter
> Memory type:            SDRAM DIMM SPD
> SDRAM Size (MB):        128
> 
> eeprom-i2c-0-52
> Adapter: SMBus PIIX4 adapter at 5000
> Algorithm: Non-I2C SMBus adapter
> Memory type:            SDRAM DIMM SPD
> SDRAM Size (MB):        128
> 
> Thank you in advance.
> --
>       "...[Let us inquire] what glory there was in an omnipotent being
>    torturing forever a puny little creature who could in no way defend
>   himself? Would it be to the glory of a man to fry ants?" --Charlotte
>                                                         Perkins Gilman
> --
>   /\___/\                                             Phillip Pi (Ant)
>  / /\ /\ \              E-Mail: philpi@earthlink.net or philpi@apu.edu
> | |o   o| |
>    \ _ /                            The Ant Farm: http://antfarm.ma.cx
>     ( )                                               ICQ UIN: 2223658
