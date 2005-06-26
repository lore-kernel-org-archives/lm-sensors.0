From: linux_user98765@yahoo.com (linux_user98765@yahoo.com)
Date: Sun, 26 Jun 2005 12:39:29 +0000
Subject: [lm-sensors] Asus A8000 (SMBus 2Eh) Inquiry/Request
Message-Id: <20050626103852.82262.qmail@web60416.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050618063459.94021.qmail@web60417.mail.yahoo.com>
In-Reply-To: <20050618063459.94021.qmail@web60417.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Sorry it took me a few days to get back to you, but the following seems
to have worked:


--- Rudolf Marek <r.marek@sh.cvut.cz> wrote:
> you can also try:
> > 0) reboot
> > 1) modprobe i2c-i801
> > 2) modprobe lm85 force_lm85b=0,0x2e
> > 3) sensors


lm85b-i2c-0-2e
Adapter: SMBus I801 adapter at 0400
V1.5:       +2.54 V  (min =  +0.00 V, max =  +3.32 V)
VCore:      +2.20 V  (min =  +0.00 V, max =  +2.99 V)
V3.3:       +3.33 V  (min =  +0.00 V, max =  +4.38 V)
V5:        +5.03 V  (min =  +0.00 V, max =  +6.64 V)
V12:      +11.75 V  (min =  +0.00 V, max = +15.94 V)
CPU_Fan:   1080 RPM  (min =    0 RPM)
fan2:      1144 RPM  (min =    0 RPM)
fan3:         0 RPM  (min =    0 RPM)
fan4:         0 RPM  (min =    0 RPM)
CPU:         +46?C  (low  =  -127?C, high =   +60?C)
Board:       +44?C  (low  =  -127?C, high =  +127?C)
Remote:       +0?C  (low  =  -127?C, high =  +127?C)
CPU_PWM:    96
Fan2_PWM:   89
Fan3_PWM:  255
vid:      +1.850 V  (VRM Version 9.0)

eeprom-i2c-0-52
Adapter: SMBus I801 adapter at 0400
Memory type:            DDR2 SDRAM DIMM
Memory size (MB):       256

eeprom-i2c-0-50
Adapter: SMBus I801 adapter at 0400
Memory type:            DDR2 SDRAM DIMM
Memory size (MB):       256


I do have a few last questions however:

While I presume I can merely add this to my /etc/modules -- would you
need anything else to be able to auto-detect the A8000?

There seems to be a few discrepancies between the sensors detected by
lm-sensors and Everest (http://www.lavalys.com/):


EVEREST

Temperature
* /dev/hda
* /dev/sda

Voltages
* CPU Core
* +2.5 V
* VTR


LM-SENSORS

V1.5:       +2.54 V  (min =  +0.00 V, max =  +3.32 V)
VCore:      +2.20 V  (min =  +0.00 V, max =  +2.99 V)
fan3:         0 RPM  (min =    0 RPM)
fan4:         0 RPM  (min =    0 RPM)
Remote:       +0?C  (low  =  -127?C, high =  +127?C)
CPU_PWM:    96
Fan2_PWM:   89
Fan3_PWM:  255
vid:      +1.850 V  (VRM Version 9.0)


Which may overlap my last question:

So now that I have all these sensors -- what's the significance of
their readings?  Or for that matter what is PWM, vid, etc?

I've googled and came across
http://www.techspot.com/vb/all/windows/t-7658-voltages.html, which
covers most of the voltages... but that still leaves a number which I
haven't been able to find any information on.  Any sources or
explanations greatly welcomed!

Thanks!


		
__________________________________ 
Yahoo! Mail 
Stay connected, organized, and protected. Take the tour: 
http://tour.mail.yahoo.com/mailtour.html 

