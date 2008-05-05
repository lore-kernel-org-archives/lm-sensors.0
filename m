From: achim <achim@ag-web.biz>
Date: Mon, 05 May 2008 12:15:34 +0000
Subject: Re: [lm-sensors] sensors-detect killed my CPU
Message-Id: <1209989734.3488.4.camel@debian-9850.ag-home.muc>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-qV9B58CoThukqwBHDOIR"
List-Id: <lm-sensors.vger.kernel.org>
References: <481B851A.10800@ag-web.biz>
In-Reply-To: <481B851A.10800@ag-web.biz>
To: lm-sensors@vger.kernel.org


--=-qV9B58CoThukqwBHDOIR
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Am Sonntag, den 04.05.2008, 20:16 +0200 schrieb Jean Delvare: 
> On Sun, 04 May 2008 19:47:22 +0200, Achim Gottinger wrote:
> > I searched the "Bios and Kernel Developer Guide" for smbus and found 
> > those results
> > 
> > http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/31116.PDF
> > 

> There's probably a lot to read and do there, too bad I don't have the
> time :(

He He, the BKDG is tough to read. I tried to figure out the SMbus
adresses.

http://www.abload.de/image.php?img=baredit-sidebandeis.jpg

This is the register where the adress should be in bits 4:6 whom are all
zero. However bit 3 is set and that should mean that the sideband
interface is used.

http://www.abload.de/image.php?img=sidebandumy.jpg

I plan to ask amd for clarification and for that SBI document they
rerefer to. I also plan to RMA my cpu btw.

> 
> > Information about the SBI SMBus register address can be read from the 
> > pci register F3x1E8. lspci does not output values beyond 0xFF.
> 
> It does :) You only have to swap the bytes yourself due to x86 being
> little-endian. Better use setpci with no value, you can tell it the
> width of the register (.w for 16-bit, .l for 32-bit.)
> 
Thank you for the tip. But under linux only the address space from
0x00-0xFF is accesible thru /proc/bus/pci...
I tried to access 0x1E4 that way 

setpci -s 0:18.3 0x1E4.l 

and only got 0xFFFFFFFF back. Same happens if i try to read
from /proc/bus/pci/00/18.3 direct (with a small python script).

I tried to read out 0x6e with the -r option. It is possible to read the
following areas without making the smbus controler nonfunctional.
0x00-0x7F,
0x80-0x9d,0xa0-0xbd,0xc0-0xdd,0xe0-0xfd

ALso i tried to run sensors-detect with excluding 0x2e,0x6e and 0x47. It
passed but afterwards I had to restart to get rid of the XX'es in the
i2cdump.



--=-qV9B58CoThukqwBHDOIR
Content-Disposition: attachment; filename=sensors-detect.txt
Content-Type: text/plain; name=sensors-detect.txt; charset=utf-8
Content-Transfer-Encoding: 7bit

debian-9850:/home/achim# sensors-detect 
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

To continue, we need module `i2c-dev' to be loaded.
Do you want to load `i2c-dev' now? (YES/no): 
Module loaded successfully.

We are now going to do the I2C/SMBus adapter probings. Some chips may
be double detected; we choose the one with the highest confidence
value in that case.
If you found that the adapter hung after probing a certain address,
you can specify that address to remain unprobed.

Next adapter: SMBus PIIX4 adapter at 0b00 (i2c-0)
Do you want to scan it? (YES/no/selectively): selectively
Please enter one or more addresses not to scan. Separate them with comma's.
You can specify a range by using dashes. Addresses may be decimal (like 54)
or hexadecimal (like 0x33).
Addresses: 0x2e,0x6e,0x47
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

Some chips are also accessible through the ISA I/O ports. We have to
write to arbitrary I/O ports to probe them. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!
Do you want to scan the ISA I/O ports? (YES/no): 
Probing for `National Semiconductor LM78' at 0x290...       No
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


--=-qV9B58CoThukqwBHDOIR
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--=-qV9B58CoThukqwBHDOIR--

