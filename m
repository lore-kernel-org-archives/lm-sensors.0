From: lists@localguru.de (Marcus Sobchak)
Date: Fri, 14 Jul 2006 21:37:41 +0000
Subject: [lm-sensors] Tyan S2720 Revsion 2.01 again
Message-Id: <1152913061.14370.8.camel@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <1152171804.5078.26.camel@localhost.localdomain>
In-Reply-To: <1152171804.5078.26.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Am Sonntag, den 09.07.2006, 22:32 +0200 schrieb Rudolf Marek:
> Hi Marcus,
> 
> > tested sensors.conf (see attachment) for Tyan S2720 from Tyan's ftp
> > server, but just get the follwing strange output. Any ideas, what's
> > going wrong here? 
> > 
> > System: Linux 2.6.15-25-server #1 SMP  (Ubuntu dapper)
> > 
> > Thanks,
> > Marcus
> > 
> > ---------
> > adm1021-i2c-0-19
> > Adapter: SMBus I801 adapter at ec80
> > CPU 2 temp:
> >               -1?C  (low  =    -1?C, high =    -1?C)  ALARM
> > (N/A,LOW,HIGH)
> > ERROR: Can't get die-code data!
> 
> 
> Hmm strange, please can you provide output of i2cdump 0 0x19
> and i2cdump 0 0x18 ?
> 
> And BTW try first change the BIOS, quoting the sensors.conf
> 
> #      therefore does not require the i2c-isa module.  Currently, the    #
> 
> #      BIOS also has a problem with the CPU temps.  If they read -1,     #
> 
> #      or 255, check the Tyan website for an updated BIOS.               #
> 
> I think it should solve it.
> 
> > 
> > w83627hf-isa-0290
> > Adapter: ISA adapter
> > Fan4:        0 RPM  (min = 168750 RPM, div = 2)
> > Fan5:        0 RPM  (min = 225000 RPM, div = 2)
> > Fan6:        0 RPM  (min = 337500 RPM, div = 2)
> 
> Maybe you need to change the fan divisor to see the fan  set fan1_div 4
> (as the tynan config file suggests)
> 
> > alarms:
> > beep_enable:
> >           Sound alarm disabled
> > 
> > w83627hf-i2c-0-2a
> > Adapter: SMBus I801 adapter at ec80
> > Fan4:        0 RPM  (min =    0 RPM, div = 128)
> > Fan5:        0 RPM  (min =    0 RPM, div = 128)
> > Fan6:        0 RPM  (min =    0 RPM, div = 128)
> > (beep)
> 
> Heh same chip can be accessed both from ISA or from SMBUS. Please do not load
> i2c-isa and you will get rid of this duplicity.
> 
> > alarms:
> > beep_enable:
> >           Sound alarm enabled
> > 
> > w83782d-i2c-0-29
> > Adapter: SMBus I801 adapter at ec80
> > +3.3V:     +3.34 V  (min =  +3.14 V, max =  +3.46 V)
> > +5V:       +4.97 V  (min =  +4.73 V, max =  +5.24 V)
> > +12V:     +12.04 V  (min = +10.82 V, max = +13.19 V)
> > VBat:      +2.10 V  (min =  +2.40 V, max =  +3.60 V)
> > CPU1 Fan: 9642 RPM  (min = 84375 RPM, div = 2)
> > CPU2 Fan: 9642 RPM  (min = 84375 RPM, div = 2)
> > Fan3:        0 RPM  (min = 84375 RPM, div = 2)
> > VRM Temp:    +45?C  (high =  +100?C, hyst =   +90?C)   sensor > > transistor
> > alarms:   Chassis intrusion detection                      ALARM
> > beep_enable:
> >           Sound alarm disabled
> > ---------

Set up the machine completely new today (debian sarge, 2.6.8-3 kernel)
and upgraded to newest bios version v1.03. Loades modules like written
in tyans sensors.conf. CPU temperature is still -1. Andy ideas?

Ciao,
Marcus

Here is the output:

w83627hf-i2c-0-2a
Adapter: SMBus I801 adapter at 0540
Fan4:        0 RPM  (min =    0 RPM, div = 128)
Fan5:        0 RPM  (min =    0 RPM, div = 128)
Fan6:        0 RPM  (min =    0 RPM, div = 128)              ALARM
(beep)
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
          Sound alarm enabled

w83782d-i2c-0-29
Adapter: SMBus I801 adapter at 0540
+3.3V:     +3.36 V  (min =  +3.14 V, max =  +3.46 V)
+5V:       +4.95 V  (min =  +4.73 V, max =  +5.24 V)
+12V:     +11.98 V  (min = +10.82 V, max = +13.19 V)
VBat:      +2.10 V  (min =  +2.40 V, max =  +3.60 V)
CPU1 Fan: 9507 RPM  (min = 5314 RPM, div = 2)
CPU2 Fan: 9507 RPM  (min = 5314 RPM, div = 2)
Fan3:        0 RPM  (min = 5314 RPM, div = 2)
VRM Temp:    +38?C  (high =  +100?C, hyst =   +90?C)   sensor transistor
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
          Sound alarm disabled

adm1021-i2c-0-19
Adapter: SMBus I801 adapter at 0540
CPU 2 temp:
              -1?C  (low  =    -1?C, high =    -1?C)  ALARM (N/A,LOW)

adm1021-i2c-0-18
Adapter: SMBus I801 adapter at 0540
CPU 1 temp:
              -1?C  (low  =    -1?C, high =    -1?C)  ALARM (N/A,LOW)








