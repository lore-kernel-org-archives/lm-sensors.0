From: achim <achim@ag-web.biz>
Date: Sun, 11 May 2008 11:42:59 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Check for
Message-Id: <1210506179.3509.18.camel@debian-9850.ag-home.muc>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-ZIAuQF+qfyUr77cblEXu"
List-Id: <lm-sensors.vger.kernel.org>
References: <1210344199.3543.12.camel@debian-9850.ag-home.muc>
In-Reply-To: <1210344199.3543.12.camel@debian-9850.ag-home.muc>
To: lm-sensors@vger.kernel.org


--=-ZIAuQF+qfyUr77cblEXu
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Am Samstag, den 10.05.2008, 18:40 +0200 schrieb Jean Delvare:
> Hi Achim,
> 
> On Fri, 09 May 2008 19:31:44 +0200, achim wrote:
> > Am Freitag, den 09.05.2008, 19:05 +0200 schrieb Jean Delvare:
> > > 
> > > > Afterward i tried it with only 0x4c excluded and the smbus chip still
> > > > works. With no exclusions lm75 detection hangs at 0x4c and afterwards i
> > > > only get XX's from dumps.
> > > 
> > > By "hangs" you mean it takes several seconds, or does it really stop?
> > > Are you certain that it's the LM75 detection causing problem? We check
> > > for no less than 33 different devices at address 0x4c...
> > > 
> > -------------------------------------------------
> > Client found at address 0x4c
> > Probing for `National Semiconductor LM75'...         
> > -------------------------------------------------
> > This is where it stops for a few seconds.
> > i2cdump 0 0x4c w hangs in a way that i must cancle it with Ctrl-C and
> > afterwards i need a reboot to get correct dumps.
> > 
> > > Anyway, most certainly the problem is with word transactions on this
> > > device you have at 0x4c. That won't be easy to work around, but I'll
> > > take a look anyway, maybe I'll have an idea. If I do, I'll ask you -
> > > again - to help with testing. 
> 
> OK, I have come up with something. There are not that many detection
> routines using SMBus read word transactions, we only use them for the
> following devices in the 0x48-0x4f address range: LM75, DS75, LM77,
> LM92, LM76, MAX663x and DS1621. So I have changed the detection of all
> these devices to do as much as possible with read byte transactions,
> and only use read word transactions at the end when we are already
> almost certain that we have identified the device.

Hi Jean,

I just tried your patch, and sensors-detect works fine without breaking
the smbus now.

I attached the log. Now without breaking at 0x4c the chip at 0x4e is
detected as an overclock controller. 

I'm currently working on a module for the clockgenerator chip. I started
with the lm75 module and modified it in a way that it reads out the ref
HT speed. I want to extend it to read out the onboard gpu and pcie
frequency also.

The registers at 0x90 and 0x91 are responsible for the ref HT frequency.

m=0x91[0:7]*4+0x90[6:7]
n=0x90[0:5]

ref HT = 50MHz * m/n

It is also possible to change the ref HT on the fly by writing to those
registers but that needs further inspection because the datasheet lacks
the info what divider n is suitable. Also I only tested this with spread
spectrum disabled, otherwise i'd need a few tables for the spectrum
registers whom are also not covered by the datasheet.

Would such a module fit into the lm-sensors project? On the one hand it
monitors motherboard frequencies on the other it's not a sensor chip i'm
utilising.


> 
> I would appreciate as much testing of this patch as possible, in
> particular from people having any of the devices those detection
> routines changed (LM75, DS75, LM77, LM92, LM76, MAX663x and DS1621) but
> more generally from anyone having an I2C/SMBus device in address range
> 0x48-0x4f. I want to make sure that I didn't add false positives with
> the changes.
> 
> Thanks,

--=-ZIAuQF+qfyUr77cblEXu
Content-Disposition: attachment; filename=detect.log
Content-Type: text/x-log; name=detect.log; charset=utf-8
Content-Transfer-Encoding: 7bit

./sensors-detect
# sensors-detect revision 5108 (2008-01-22 13:22:47 +0100)

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no): 
Probing for PCI bus adapters...
Use driver `i2c-piix4' for device 0000:00:14.0: ATI Technologies Inc SB600 SMBus

We will now try to load each adapter module in turn.
Module `i2c-piix4' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

We are now going to do the I2C/SMBus adapter probings. Some chips may
be double detected; we choose the one with the highest confidence
value in that case.
If you found that the adapter hung after probing a certain address,
you can specify that address to remain unprobed.

Next adapter: SMBus PIIX4 adapter at 0b00 (i2c-0)
Do you want to scan it? (YES/no/selectively): 
Client found at address 0x2e
Seems to be a 1-register-only device, skipping.
Client found at address 0x4c

Probing for `National Semiconductor LM75'...                No
Probing for `Dallas Semiconductor DS75'...                  No
Probing for `Analog Devices ADT7466'...                     No
Probing for `Andigilog aSC7511'...                          No
Probing for `Dallas Semiconductor DS1621'...                No
Probing for `Analog Devices ADM1021'...                     No
Probing for `Analog Devices ADM1021A/ADM1023'...            No
Probing for `Maxim MAX1617'...                              No
Probing for `Maxim MAX1617A'...                             No
Probing for `Maxim MAX1668'...                              No
Probing for `Maxim MAX1805'...                              No
Probing for `Maxim MAX1989'...                              No
Probing for `Maxim MAX6655/MAX6656'...                      No
Probing for `TI THMC10'...                                  No
Probing for `National Semiconductor LM84'...                No
Probing for `Genesys Logic GL523SM'...                      No
Probing for `Onsemi MC1066'...                              No
Probing for `Maxim MAX1619'...                              No
Probing for `National Semiconductor LM82/LM83'...           No
Probing for `National Semiconductor LM90'...                No
Probing for `National Semiconductor LM89/LM99'...           No
Probing for `National Semiconductor LM86'...                No
Probing for `Analog Devices ADM1032'...                     No
Probing for `Maxim MAX6657/MAX6658/MAX6659'...              No
Probing for `Maxim MAX6648/MAX6692'...                      No
Probing for `Maxim MAX6680/MAX6681'...                      No
Probing for `Winbond W83L771W/G'...                         No
Probing for `Texas Instruments TMP401'...                   No
Probing for `National Semiconductor LM63'...                No
Probing for `Fintek F75363SG'...                            No
Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
Probing for `Analog Devices ADT7461'...                     No
Probing for `Fintek F75383S/M'...                           No
Client found at address 0x4e
Probing for `National Semiconductor LM75'...                No
Probing for `Dallas Semiconductor DS75'...                  No
Probing for `Dallas Semiconductor DS1621'...                No
Probing for `Analog Devices ADM1021'...                     No
Probing for `Analog Devices ADM1021A/ADM1023'...            No
Probing for `Maxim MAX1617'...                              No
Probing for `Maxim MAX1617A'...                             No
Probing for `Maxim MAX1668'...                              No
Probing for `Maxim MAX1805'...                              No
Probing for `Maxim MAX1989'...                              No
Probing for `Maxim MAX6655/MAX6656'...                      No
Probing for `TI THMC10'...                                  No
Probing for `National Semiconductor LM84'...                No
Probing for `Genesys Logic GL523SM'...                      No
Probing for `Onsemi MC1066'...                              No
Probing for `Maxim MAX1619'...                              No
Probing for `National Semiconductor LM82/LM83'...           No
Probing for `Maxim MAX6659'...                              No
Probing for `Maxim MAX6680/MAX6681'...                      No
Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
Probing for `ITE IT8201R/IT8203R/IT8206R/IT8266R'...        Yes
    (confidence 6, not a hardware monitoring chip)
Probing for `Fintek F75111R/RG/N (GPIO)'...                 No
Probing for `Fintek F75121R/F75122R/RG (VID+GPIO)'...       No
Client found at address 0x52
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'...                                No
Client found at address 0x53
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'...                                No

Some chips are also accessible through the ISA I/O ports. We have to
write to arbitrary I/O ports to probe them. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!
Do you want to scan the ISA I/O ports? (YES/no): Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM78-J' at 0x290...     No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No
Probing for `Silicon Integrated Systems SIS5595'...         No
Probing for `VIA VT82C686 Integrated Sensors'...            No
Probing for `VIA VT8231 Integrated Sensors'...              No
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no): 
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Trying family `ITE'...                                      Yes
Found `ITE IT8716F Super IO Sensors'                        Success!
    (address 0x228, driver `it87')
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Trying family `ITE'...                                      No

Some CPUs or memory controllers may also contain embedded sensors.
Do you want to scan for them? (YES/no): 
AMD K8 thermal sensors...                                   No
AMD K10 thermal sensors...                                  Success!
    (driver `to-be-written')
Intel Core family thermal sensor...                         No
Intel AMB FB-DIMM thermal sensor...                         No

Now follows a summary of the probes I have just done.
Just press ENTER to continue: 

Driver `it87' (should be inserted):
  Detects correctly:
  * ISA bus, address 0x228
    Chip `ITE IT8716F Super IO Sensors' (confidence: 9)

Driver `to-be-written' (should be inserted):
  Detects correctly:
  * Chip `AMD K10 thermal sensors' (confidence: 9)

I will now generate the commands needed to load the required modules.
Just press ENTER to continue: 

To load everything that is needed, add this to /etc/modules:

#----cut here----
# Chip drivers
it87
# no driver for AMD K10 thermal sensors yet
#----cut here----

Do you want to add these lines automatically? (yes/NO)

--=-ZIAuQF+qfyUr77cblEXu
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--=-ZIAuQF+qfyUr77cblEXu--

