From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Fri, 01 Jul 2005 23:20:23 +0000
Subject: [lm-sensors] Asus A8000 (SMBus 2Eh) Inquiry/Request
Message-Id: <42C5B34D.8050907@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050618063459.94021.qmail@web60417.mail.yahoo.com>
In-Reply-To: <20050618063459.94021.qmail@web60417.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hi,

linux_user98765@yahoo.com wrote:
> Sorry it took me a few days to get back to you, but the following seems
> to have worked:

Good. I had a holiday too :)

> lm85b-i2c-0-2e
> Adapter: SMBus I801 adapter at 0400
> V1.5:       +2.54 V  (min =  +0.00 V, max =  +3.32 V)
> VCore:      +2.20 V  (min =  +0.00 V, max =  +2.99 V)
> V3.3:       +3.33 V  (min =  +0.00 V, max =  +4.38 V)
> V5:        +5.03 V  (min =  +0.00 V, max =  +6.64 V)
> V12:      +11.75 V  (min =  +0.00 V, max = +15.94 V)

Hmm Voltage limits seems not to work

> CPU_Fan:   1080 RPM  (min =    0 RPM)
> fan2:      1144 RPM  (min =    0 RPM)
> fan3:         0 RPM  (min =    0 RPM)
> fan4:         0 RPM  (min =    0 RPM)

Also no fan limits

> CPU:         +46?C  (low  =  -127?C, high =   +60?C)
> Board:       +44?C  (low  =  -127?C, high =  +127?C)

High limits seems OK

> Remote:       +0?C  (low  =  -127?C, high =  +127?C)

> CPU_PWM:    96
> Fan2_PWM:   89
> Fan3_PWM:  255
> vid:      +1.850 V  (VRM Version 9.0)
> 
> I do have a few last questions however:
> 
> While I presume I can merely add this to my /etc/modules -- would you
> need anything else to be able to auto-detect the A8000?

This chip is completly new to us and  I guessed from binary dump it could be lm85 compatible somehow. Maybe it is
more compatible with some other LMxx family chip. I must check. The values you are observing may be simply misinterpretation
of some register value that happens to have one meaning for lm85 compatible chip, but for a8000 might have another meaning.


> There seems to be a few discrepancies between the sensors detected by
> lm-sensors and Everest (http://www.lavalys.com/):
> > 
> EVEREST
> 
> Temperature
> * /dev/hda
> * /dev/sda

This is from S.M.A.R.T. use smartctl or hddtemp

 > Which may overlap my last question:
> 
> So now that I have all these sensors -- what's the significance of
> their readings?  Or for that matter what is PWM, vid, etc?
>

PWM could be used to regulate fan speeds but I doubt it will work with his chip. VID is voltage of CPU but the value seems also bogus.
I cant tell you much info to rest of voltages - they might reflect real voltages or it can be misinterpretation too.

I will ask you to run some commands when I will think out some :)

Regards

Rudolf
