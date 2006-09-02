From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 02 Sep 2006 05:54:52 +0000
Subject: [lm-sensors] Asus P5B Deluxe WiFi AP Sensors
Message-Id: <20060902075452.0a32ac22.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060822145643.GA5632@seahunt.dyndns.org>
In-Reply-To: <20060822145643.GA5632@seahunt.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Michael,

> I'm sorry Jean, I never saw your 8/23 response to this or I would have
> responded to you.  Anyway, better late than never?

Yep, I seem to remember I received a bounce for my mail, like your mail
server didn't like my SMTP or something like that. Sorry about that. To
prevent this from happening again, I am replying to the list only this
time.

> >I guess you have an Intel ICH8 chip on the board. Our detection script
> >didn't recognize it, I just added it in SVN. No big deal anyway as the
> >required driver is automatically loaded.
> 
> Yes, it's an ICH8.
> 
> >Can you please provide a dump of the chip?
> >isadump 0x295 0x296
> 
>  # isadump 0x295 0x296
> WARNING! Running this program can cause system crashes, data loss and worse!
> I will probe address register 0x295 and data register 0x296.
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 04 ff 04 4b 31 00 42 10 01 4b 01 01 3c 3c 0a 05
> 10: 04 ff 50 00 00 01 01 3c 43 17 00 00 ff ff ff c1
> 20: 8f e3 cc cc 97 c6 97 1d ff 61 ff c5 b2 c5 b2 d9
> 30: c4 c3 b1 cf bb e3 cd da c5 1a 50 57 01 21 19 ff
> 40: 03 10 00 de ff ff 00 15 2d 00 20 44 18 95 06 a3
> 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 60: 01 9b 31 52 9b 01 3c ff 12 ff 0a ff ff ff ff ff
> 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 80: 04 ff 04 4b 31 00 42 10 01 4b 01 01 3c 3c 0a 05
> 90: 04 ff 50 00 00 01 01 3c 43 17 00 00 ff ff ff c1
> a0: 8f e3 cc cc 97 c6 97 1d ff 61 ff c5 b2 c5 b2 d9
> b0: c4 c3 b1 cf bb e3 cd da c5 1a 50 57 01 21 19 ff
> c0: 03 00 00 de ff ff 00 15 2d 00 20 44 18 95 06 a3
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> e0: 01 9b 31 52 9b 01 3c ff 12 ff 0a ff ff ff ff ff
> f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

OK, thanks. I've added it to my collection.

> >Can you please try the latest version of sensors-detect:
> >http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/detect/sensors-detect?format=txt
> >And tell us whether you still have these warnings?
> 
> Script started on Fri Sep  1 05:55:43 2006
> seahunt:/usr/local/src # ./sensors-detect 
> # sensors-detect revision $Revision$ ($Date$)
> 
> This program will help you determine which kernel modules you need
> to load to use lm_sensors most effectively. It is generally safe
> and recommended to accept the default answers to all questions,
> unless you know what you're doing.
> 
> We can start with probing for (PCI) I2C or SMBus adapters.
> Do you want to probe now? (YES/no): 
> Probing for PCI bus adapters...
> Use driver `i2c-i801' for device 00:1f.3: Intel ICH8
> Probe successfully concluded.

Good.

> 
> We will now try to load each adapter module in turn.
> Load `i2c-i801' (say NO if built into your kernel)? (YES/no): 
> Module loaded successfully.
> If you have undetectable or unsupported adapters, you can have them
> scanned by manually loading the modules before running this script.
> 
> To continue, we need module `i2c-dev' to be loaded.
> Do you want to load `i2c-dev' now? (YES/no): 
> Module loaded successfully.
> 
> We are now going to do the I2C/SMBus adapter probings. Some chips may
> be double detected; we choose the one with the highest confidence value
> in that case.
> If you found that the adapter hung after probing a certain address, you
> can specify that address to remain unprobed.
> 
> Next adapter: SMBus I801 adapter at 0400
> Do you want to scan it? (YES/no/selectively): 
> Client found at address 0x08
> Client found at address 0x22
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Client found at address 0x30
> Client found at address 0x32
> Client found at address 0x50
> Probing for `Analog Devices ADM1033'... Failed!
> Probing for `Analog Devices ADM1034'... Failed!
> Probing for `SPD EEPROM'... Success!
>     (confidence 8, driver `eeprom')
> Probing for `EDID EEPROM'... Failed!
> Probing for `Maxim MAX6900'... Failed!
> Client found at address 0x52
> Probing for `Analog Devices ADM1033'... Failed!
> Probing for `Analog Devices ADM1034'... Failed!
> Probing for `SPD EEPROM'... Success!
>     (confidence 8, driver `eeprom')
> Client found at address 0x69
> 
> Some chips are also accessible through the ISA I/O ports. We have to
> write to arbitrary I/O ports to do this. This is usually safe though.
> Yes, you do have ISA I/O ports even if you do not have any ISA slots!
> Do you want to scan the ISA I/O ports? (YES/no): 
> Probing for `National Semiconductor LM78'
>   Trying address 0x0290... Failed!

My misdetection prevention measures worked :)

> Probing for `National Semiconductor LM78-J'
>   Trying address 0x0290... Failed!
> Probing for `National Semiconductor LM79'
>   Trying address 0x0290... Failed!
> Probing for `Winbond W83781D'
>   Trying address 0x0290... Failed!
> Probing for `Winbond W83782D'
>   Trying address 0x0290... Failed!
> Probing for `Winbond W83627HF'
>   Trying address 0x0290... Failed!
> Probing for `Winbond W83627EHF'
>   Trying address 0x0290... Failed!
> Probing for `Winbond W83627DHG'
>   Trying address 0x0290... Failed!

This legacy detection method failed, I guess the heuristics are not
working for your chip.

Given that these 3 last chips (W83627HF, W83627EHF and W83627DHG) are
Super-I/O chips and are detected again later using a  more reliable
method, I suggest we drop the legacy detection method for them. I've
already done so for the ITE family some weeks ago. Objection anyone?

> Probing for `Silicon Integrated Systems SIS5595'
>   Trying general detect... Failed!
> Probing for `VIA Technologies VT82C686 Integrated Sensors'
>   Trying general detect... Failed!
> Probing for `VIA Technologies VT8231 Integrated Sensors'
>   Trying general detect... Failed!
> Probing for `AMD K8 thermal sensors'
>   Trying general detect... Failed!
> Probing for `IPMI BMC KCS'
>   Trying address 0x0ca0... Failed!
> Probing for `IPMI BMC SMIC'
>   Trying address 0x0ca8... Failed!
> 
> Some Super I/O chips may also contain sensors. We have to write to
> standard I/O ports to do this. This is usually safe.
> Do you want to scan for Super I/O sensors? (YES/no): 
> Probing for `ITE 8702F Super IO Sensors'
>   Failed! (skipping family)
> Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
>   Failed! (skipping family)
> Probing for `SMSC 47B27x Super IO Fan Sensors'
>   Failed! (skipping family)
> Probing for `VT1211 Super IO Sensors'
>   Failed! (0xa0)
> Probing for `Winbond W83627HF Super IO Sensors'
>   Failed! (0xa0)
> Probing for `Winbond W83627THF Super IO Sensors'
>   Failed! (0xa0)
> Probing for `Winbond W83637HF Super IO Sensors'
>   Failed! (0xa0)
> Probing for `Winbond W83687THF Super IO Sensors'
>   Failed! (0xa0)
> Probing for `Winbond W83697HF Super IO Sensors'
>   Failed! (0xa0)
> Probing for `Winbond W83697SF/UF Super IO PWM'
>   Failed! (0xa0)
> Probing for `Winbond W83L517D Super IO'
>   Failed! (0xa0)
> Probing for `Fintek F71805F/FG Super IO Sensors'
>   Failed! (0xa021)
> Probing for `Fintek F71872F/FG Super IO Sensors'
>   Failed! (0xa021)
> Probing for `Fintek F81218D Super IO'
>   Failed! (0xa021)
> Probing for `Winbond W83627EHF/EHG Super IO Sensors'
>   Failed! (0xa021)
> Probing for `Winbond W83627DHG Super IO Sensors'
>   Success... found at address 0x0290

This confirms my earlier guess. Good. As I said before, we don't have
support right now, but support could be added to the w83627ehf driver
with relatively little effort. You'll have to wait until this happens.

-- 
Jean Delvare

