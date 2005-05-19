From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:37 +0000
Subject: lm_sensors 2.6.4 on Tyan Thunder K7 (S2462) (w83781d driver)
Message-Id: <3D59BCE3.E25BDE5@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.44.0208131438430.9726-100000@madhouse.demon.co.uk>
In-Reply-To: <Pine.LNX.4.44.0208131438430.9726-100000@madhouse.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

see the many tickets on this topic.
links on our 'old news' page.

Andrew Bray wrote:
> 
> -----BEGIN PGP SIGNED MESSAGE-----
> 
> Folks,
> 
> This motherboard is claimed in its manual of having a Winbond W83627HF
> Super I/O ASIC and as a build option a Winbond W83627D hardware
> monitoring.
> 
> The Winbond W83627D hardware monitoring chip is claimed to include:
>         3-pin fan monitoring headers
>         2-pin chassis intrusion header
>         CPU temperature and voltage monitoring
> 
> The Winbond web site doesn't have data on the W83627D chip.
> 
> lm_sensors 2.6.4 detects a w83627hf at SMBUS address 0x2c, and a w83782d
> at address 0x2d.
> 
> There are only two subclients detected at addresses 0x48 and 0x49.
> 
> I have a suspidin that a W83627D is actually a W83782D with no subclients.
> 
> Anyway, I cannot have both installed at once, because of a lack of
> subclient addresses.
> 
> I have created a shell script that dumps all the files in
> /proc/sys/dev/sensors/w*/*.
> 
> Here is the output of my script and 'sensors' for the two chips (I used
> init=0 to retain the BIOS initialisation):
> 
> > insmod w83781d ignore=0,0x2d init=0
> >
> > w83627hf-i2c-0-2c:
> > alarms@96
> > beep=0 0
> > fan1u0 0
> > fan2u0 0
> > fan3u0 0
> > fan_div=8 8 8
> > in0=4.08 4.08 1.74
> > in1=4.08 4.08 1.72
> > in2=2.97 3.63 3.29
> > in3=2.68 3.26 2.94
> > in4=2.84 3.45 2.91
> > in5=0.33 0.78 0.59
> > in6=0.70 1.02 0.72
> > in7=2.68 3.26 3.21
> > in8=2.70 3.29 0.00
> > pwm1%5
> > pwm2%5
> > sensor1=2
> > sensor2=2
> > sensor3=2
> > temp1`.0 127.0 56.0
> > temp2r.5 32.0 40.5
> > temp3r.5 32.0 45.0
> > vid=1.850
> > vrm=8.2
> >
> > w83627hf-i2c-0-2c
> > Adapter: SMBus AMD766 adapter at 80e0
> > Algorithm: Non-I2C SMBus adapter
> > VCore 1:   +1.74 V  (min =  +4.08 V, max =  +4.08 V)
> > VCore 2:   +1.74 V  (min =  +4.08 V, max =  +4.08 V)
> > +3.3V:     +3.29 V  (min =  +2.97 V, max =  +3.63 V)
> > +5V:       +4.94 V  (min =  +4.50 V, max =  +5.48 V)
> > +12V:     +11.06 V  (min = +10.79 V, max = +13.11 V)
> > -12V:     -11.88 V  (min = -13.21 V, max = -10.90 V)
> > -5V:       -5.45 V  (min =  -5.51 V, max =  -4.51 V)       ALARM
> > V5SB:      +5.39 V  (min =  +4.50 V, max =  +5.48 V)
> > VBat:      +0.00 V  (min =  +2.70 V, max =  +3.29 V)
> 
> The BIOS hardware monitor page lists core voltages, plus +6 and +/-12V
> foltages, which closely match these here.
> 
> > fan1:        0 RPM  (min =  750 RPM, div = 8)
> > fan2:        0 RPM  (min =  750 RPM, div = 8)
> > fan3:        0 RPM  (min =  750 RPM, div = 8)
> 
> The BIOS lists 2 CPU fans, and 4 chassis fans.  The chassis fans were all
> reported at 0 RPM.
> 
> > temp1:       +55?C  (limit =  +60?C)                       sensor = 3904 transistor
> > temp2:     +41.5?C  (limit =  +72?C, hysteresis =  +32?C) sensor = 3904 transistor
> > temp3:     +45.0?C  (limit =  +72?C, hysteresis =  +32?C) sensor = 3904 transistor
> 
> The BIOS only lists 2 temperature for the two CPUs, which wwere both 43 degC
> 
> > vid:      +1.850 V
> > alarms:   Chassis intrusion detection                      ALARM
> 
> My case does not make any connection with the chassis intrusion connector
> on the mootherboard.
> 
> > beep_enable:
> >           Sound alarm disabled
> >
> > insmod w83781d ignore=0,0x2c init=0
> > w83782d-i2c-0-2d:
> > alarms8656
> > beep=1 0
> > fan1000 5314
> > fan2000 5152
> > fan300 0
> > fan_div=2 2 4
> > in0=4.08 4.08 1.76
> > in1=4.08 4.08 2.84
> > in2=2.97 3.63 1.52
> > in3=2.68 3.26 2.86
> > in4=2.84 3.45 1.23
> > in5=0.33 0.78 2.48
> > in6=0.70 1.02 3.29
> > in7=2.68 3.26 2.51
> > in8=2.70 3.29 0.00
> > pwm1%5
> > pwm2%5
> > pwm3%5
> > pwm4%5
> > sensor1=2
> > sensor2=2
> > sensor3=2
> > temp10.0 127.0 46.0
> > temp2r.5 32.0 41.5
> > temp3r.5 32.0 45.0
> > vid=1.850
> > vrm=8.2
> >
> > w83782d-i2c-0-2d
> > Adapter: SMBus AMD766 adapter at 80e0
> > Algorithm: Non-I2C SMBus adapter
> > VCore 1:   +1.76 V  (min =  +4.08 V, max =  +4.08 V)
> > VCore 2:   +2.84 V  (min =  +4.08 V, max =  +4.08 V)
> > +3.3V:     +1.53 V  (min =  +2.97 V, max =  +3.63 V)
> > +5V:       +4.80 V  (min =  +4.50 V, max =  +5.48 V)
> > +12V:      +4.56 V  (min = +10.79 V, max = +13.11 V)
> > -12V:      -2.16 V  (min = -13.21 V, max = -10.90 V)
> > -5V:       +2.62 V  (min =  -5.51 V, max =  -4.51 V)
> > V5SB:      +4.22 V  (min =  +4.50 V, max =  +5.48 V)
> > VBat:      +0.00 V  (min =  +2.70 V, max =  +3.29 V)
> 
> These voltages don't seem to corrrespond with anything reported by th
> BIOS.
> 
> > fan1:     5314 RPM  (min = 3000 RPM, div = 2)
> > fan2:     5113 RPM  (min = 3000 RPM, div = 2)
> 
> These are very close to the CPU fan speeds reported by the BIOS.
> 
> > fan3:        0 RPM  (min = 1500 RPM, div = 4)
> > temp1:       +46?C  (limit = +100?C)                       sensor = 3904 transistor
> > temp2:     +42.0?C  (limit =  +72?C, hysteresis =  +32?C) sensor = 3904 transistor
> > temp3:     +32.0?C  (limit =  +72?C, hysteresis =  +32?C) sensor = 3904 transistor
> 
> These traces were taken only a minute or two apart, as both tests were
> using the same subcliient addresses.
> 
> I would have expected the same temperature readings in both tests.
> 
> > vid:      +1.850 V
> > alarms:
> > beep_enable:
> >           Sound alarm enabled
> 
> To conclude:
> 
> 1. Does it look like I have analysed things correctly?
> 
> 2. Is there a way I can use force_subclients to operate one of the two
>    Winbond chips without subclients, and have both installed at once?
> 
> Regards,
> 
> Andy
> 
> - --
> - -----------------------------------------------------------------------------
> Andrew Bray, PWMS, MA,              |  preferred:    mailto:andy@chaos.org.uk
> London, England                     |  or:   mailto:andy@madhouse.demon.co.uk
> PGP id/fingerprint:  D811F5C9/26 B5 42 C6 F4 00 B2 71 BA EA 9B 81 6C 65 59 07
> 
> -----BEGIN PGP SIGNATURE-----
> Version: 2.6.2i
> 
> iQCVAwUBPVkbl0jMoRfYEfXJAQHS8AP/egFwnjH/EsJfHZSNGq85PPsjZbH8ldNa
> FxEblvX/MJXorQQQDnZB2PMf097qERo3dEhqc6f527q1081udxkATnjB6KnWYFZY
> 5ZKq+yR2vxx4lwPPWGYTZi01Kz41IAlKHg45ztPXrAmjLBwVMzey/mASKuVpO93O
> BrGCE2eEdUU> =HhjT
> -----END PGP SIGNATURE-----
