From: mark.syms@eu.citrix.com (Mark Syms)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: Addition to IBM whitelist
Message-Id: <1082031250.6117.17.camel@viper.cam.eu.citrix.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1082027302.6117.9.camel@viper.cam.eu.citrix.com>
In-Reply-To: <1082027302.6117.9.camel@viper.cam.eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hmmm,

Well looking at the log I find this :-

-----------------------------------

Client found at address 0x54
Probing for `SPD EEPROM'... Success!
    (confidence 1, driver `eeprom')
Client found at address 0x55
Probing for `SPD EEPROM'... Success!
    (confidence 1, driver `eeprom')
Client found at address 0x56
Probing for `SPD EEPROM'... Success!
    (confidence 1, driver `eeprom')
Client found at address 0x57
Probing for `SPD EEPROM'... Success!
    (confidence 1, driver `eeprom')
Probing for `Sony Vaio EEPROM'... Failed!
Client found at address 0x5c
Client found at address 0x67

------------------------

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at fe00' (Algorithm unavailable)
    Busdriver `i2c-i801', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 1)
  * Bus `SMBus I801 adapter at fe00' (Algorithm unavailable)
    Busdriver `i2c-i801', I2C address 0x51
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus I801 adapter at fe00' (Algorithm unavailable)
    Busdriver `i2c-i801', I2C address 0x52
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus I801 adapter at fe00' (Algorithm unavailable)
    Busdriver `i2c-i801', I2C address 0x53
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus I801 adapter at fe00' (Algorithm unavailable)
    Busdriver `i2c-i801', I2C address 0x54
    Chip `SPD EEPROM' (confidence: 1)
  * Bus `SMBus I801 adapter at fe00' (Algorithm unavailable)
    Busdriver `i2c-i801', I2C address 0x55
    Chip `SPD EEPROM' (confidence: 1)
  * Bus `SMBus I801 adapter at fe00' (Algorithm unavailable)
    Busdriver `i2c-i801', I2C address 0x56
    Chip `SPD EEPROM' (confidence: 1)
  * Bus `SMBus I801 adapter at fe00' (Algorithm unavailable)
    Busdriver `i2c-i801', I2C address 0x57
    Chip `SPD EEPROM' (confidence: 1)

-----------------------------

I'm happy to test the adm1025 driver, I think this is actually the only
one I was using under 2.4. I probably still have a 2.4 kernel around
that I could boot into if that would help?

Thanks

	Mark.

On Thu, 2004-04-15 at 12:16, Jean Delvare wrote:
> [Please reply to the list, not to me]
> 
> > I would like to get my IBM machine added to the whitelist. It is an
> > Intellistation M-Pro tower (model 6868-6BG), the BIOS is PLKT44AUK.
> > Sensors were working on this machine before the IBM blacklist came
> > in and I have verified it using kernel 2.6.5.
> > 
> > Sensors-detect came back with the following :-
> >  
> > ---------------------------------------------------------------
> > To make the sensors modules behave correctly, add these lines to
> > /etc/modules:
> >  
> > #----cut here----
> > # I2C adapter drivers
> > i2c-i801
> > i2c-isa
> > # I2C chip drivers
> > adm1025
> > eeprom
> > smsc47m1
> > #----cut here----
> 
> OK, will do. Can you confirm that sensors-detect did not find anything
> at addresses 0x54-0x57 not 0x5C?
> 
> BTW, neither adm1025 nor smsc47m1 have been ported to Linux 2.6 yet. I
> may port the adm1025 driver soon (it has been on my TODO list for some
> times now) if you agree to test it on your system. I will not port the
> smsc47m1 however, but you may want to give it a try yourself (see the
> w83627hf driver for an already ported, similar driver, and
> Documentation/i2c/porting-clients for guidelines).
> 
> Thanks.
