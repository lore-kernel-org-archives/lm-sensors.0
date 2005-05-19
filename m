From: ondrej.cecak@centrum.cz (Ondrej Cecak)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: i850 && lm_sensors (solved)
Message-Id: <200307271655.39929.ondrej.cecak@centrum.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dne so 26. ?ervence 2003 19:39 jste napsal(a):
> Hi Ondrej,
>
> > i2cdump 0 0x44:
>
> I don't know what this one is. Your main device (see below) has no
> sub-address AFAICT. If you re-run the command some times later, are the
> values still the same?

yes, it's same like yesterday.

> > (1) a hardware monitoring ASIC (Analog Devices ADM1025, Philips
> > Semiconductor NE1619, or equivalent) include:
> > (...)
> > (2) hardware monitoring and fan control ASIC (Analog Devieces ADM1027,
> > National Semiconductor LM85, Standart Microsystems SMSC EMC6D101, or
> > equivalent) include:
>
> We already have support for ADM1025, ADM1027, LM85 and EMC6D101, so your
> chip has to be a NE1619. I took a look at your i2cdump and it matches,
> I'm 95% sure it's a NE1619. The chip is pin-to-pin compatible with the
> ADM1025, and register compatible too as far as I can say.
>
> I just added detection for the NE1619 to our sensors-detect script.
> Please grab it there:
> http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/prog/detect/sensors-detect
>
> Could you please give it a try? It should detect your chip at 0x2d as a
> NE1619 with confidence 8, and suggest adm1025 as the driver. Then you
> could try forcing the adm1025 driver:
>
> modprobe adm1025 force_adm1025=0,0x2d
>
> Let us know how it works. Since both chips seem to be compatible, I
> expect it to give very good result. If you confirm that, I'll add the
> NE1619 ID to the driver so that the force parameter isn't necessary
> anymore.

good job, if I use new sensors-detect it write:

Probing for `Philips NE1619'... Success!
    (confidence 8, driver `adm1025')

and after force load adm1025 is output of sensors like this:

adm1025-i2c-0-2d
Adapter: SMBus I801 adapter at efa0
Algorithm: Non-I2C SMBus adapter
+2.5V:     +2.48 V  (min =  +2.22 V, max =  +2.72 V)
VCCP:      +1.46 V  (min =  +2.00 V, max =  +2.44 V)   ALARM
+3.3V:     +3.33 V  (min =  +2.93 V, max =  +3.59 V)
+5V:       +5.02 V  (min =  +4.45 V, max =  +5.44 V)
+12V:      +0.06 V  (min = +10.68 V, max = +13.06 V)   ALARM
VCC:       +3.26 V  (min =  +2.93 V, max =  +3.59 V)
SYS Temp:  +40.0?C  (min =   +0?C, max =  +60?C)
CPU Temp:  +41.0?C  (min =   +0?C, max =  +60?C)
vid:       +1.35 V

so, my problem look like solved ... 

Thanks a lot. 

Best Regards
-- 
Ondrej Cecak

