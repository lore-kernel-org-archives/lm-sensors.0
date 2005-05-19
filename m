From: khaqq@free.fr (khaqq)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: asus tusl2-c
Message-Id: <20050330213629.75c0ccbc.khaqq@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050228204516.5c4dd1b9.khaqq@free.fr>
In-Reply-To: <20050228204516.5c4dd1b9.khaqq@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 30 Mar 2005 20:16:40 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> Hi khaqq,
> 
> Sorry for the delay.
> 
> > I'm happy to report that my TUSL2-C is supported by
> > lm-sensors (2.8.7). It uses the same formula as its older brother,
> > the CUSL2. So maybe you would like to add it to sensors.conf on the
> > same line :
> > # Asus CUSL2,  TUSL2-C, Asus CUV266-DLS
> > The TUSL2 should work too, but I don't own one.
> 
> Thanks a lot for the success report! We like them.
> 
> Thanks for the configuration hint as well, I'll update the default
> configuration file.

After updating from linux 2.6.9 to 2.6.11 (new i2c ?) I have had
to change the temp2 formulae again. The CUSL2 one was reporting
temps near 60C (PIII/1200 with large cooler) while the BIOS
said 40C. I think the correct formulae is *now* the same as the
A7M266 but it's weird. Can you confirm something changed in the I2C
code ?

BTW, my father's P3B-F gets the CPU temp by reading the PII thermal
diode, so I think this sentence :
# "I guess, that the formula "temp2 (@*30/43)+25, (@-25)*43/30" is correct
# for those Asus motherboards, which get CPU temperature from internal    
# thermal diode (Pentium Coppermine, and above), and "temp2 @*2.0, @/2.0" 
# is correct for Athlon/Duron boards, which use a thermistor in the 
# socket."
should be changed to :
# "I guess, that the formula "temp2 (@*30/43)+25, (@-25)*43/30" is correct
# for those Asus motherboards, which get CPU temperature from internal    
# thermal diode (P3B-F, and above), and "temp2 @*2.0, @/2.0" 
# is correct for Athlon/Duron boards, which use a thermistor in the 
# socket."
I'll try to use lm_sensors on the P3B-F as soon as I can (which may not be
soon).

I'll do more tests on the TUSL2-C then report to you again.

Thanks

Fran?ois
