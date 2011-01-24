From: Audio Phile <da_audiophile@yahoo.com>
Date: Mon, 24 Jan 2011 21:10:29 +0000
Subject: Re: [lm-sensors] insane readings on Asus A7M266 motherboard
Message-Id: <634539.91101.qm@web36603.mail.mud.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <761574.42437.qm@web36601.mail.mud.yahoo.com>
In-Reply-To: <761574.42437.qm@web36601.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

--- On Mon, 1/24/11, Jean Delvare <khali@linux-fr.org> wrote:

> This alone is usually a good hint that the VIA686A/B
> integrated sensors
> aren't used on the board.

I thought so too but it worked for years until I had to reinstall.

> The A7M266, as most Asus board at the time, is using an
> Asus-specific
> ASIC for hardware monitoring, rather than the sensors
> integrated in the
> south bridge. In your case, that would be an AS99127F, so
> you should
> load the w83781d driver rather than the via686a driver.
> sensors-detect
> should have told you exactly this,

I tried this:

# rmmod via686a
# modprobe w83781d
# sensors
No sensors found!
Make sure you loaded all the kernel drivers you need.
Try sensors-detect to find out which these are.

> BTW. If it did not,
> please send the
> full output of sensors-detect for analysis.

Attached. 
If it helps, here is the output of dmidecode: http://pastebin.com/neMfZ72L
Here is the output of lsmod: http://pastebin.com/0UNi2j5Z

Thanks again for any help you can provide.

# sensors-detect
# sensors-detect revision 5861 (2010-09-21 17:21:05 +0200)
# Board: ASUSTeK Computer INC. <A7M266>

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no): YES
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          Success!
    (driver `via686a')
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD Family 10h thermal sensors...                           No
AMD Family 11h thermal sensors...                           No
Intel Core family thermal sensor...                         No
Intel Atom thermal sensor...                                No
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal sensor...                                    No
VIA Nano thermal sensor...                                  No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no): YES
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      No
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      No

Some systems (mainly servers) implement IPMI, a set of common interfaces
through which system health data may be retrieved, amongst other things.
We first try to get the information from SMBIOS. If we don't find it
there, we have to read from arbitrary I/O ports to probe for such
interfaces. This is normally safe. Do you want to scan for IPMI
interfaces? (YES/no): YES
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some hardware monitoring chips are accessible through the ISA I/O ports.
We have to write to arbitrary I/O ports to probe them. This is usually
safe though. Yes, you do have ISA I/O ports even if you do not have any
ISA slots! Do you want to scan the ISA I/O ports? (YES/no): YES
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no): YES
Using driver `i2c-viapro' for device 0000:00:04.4: VIA Technologies VT82C686 Apollo ACPI
Module i2c-dev loaded successfully.

Next adapter: NVIDIA i2c adapter  (i2c-0)
Do you want to scan it? (YES/no/selectively): YES

Next adapter: NVIDIA i2c adapter  (i2c-1)
Do you want to scan it? (YES/no/selectively): YES

Next adapter: NVIDIA i2c adapter  (i2c-2)
Do you want to scan it? (YES/no/selectively): YES

Now follows a summary of the probes I have just done.
Just press ENTER to continue:   

Driver `via686a':
  * Chip `VIA VT82C686 Integrated Sensors' (confidence: 9)

Do you want to overwrite /etc/conf.d/lm_sensors? (YES/no):
Copy prog/init/lm_sensors.init to /etc/rc.d/lm_sensors
for initialization at boot time.
You should now start the lm_sensors service to load the required
kernel modules.

Unloading i2c-dev... OK



      

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
