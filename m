From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 06 Mar 2009 09:59:46 +0000
Subject: Re: [lm-sensors] lm_sensorsdon't work with S5000PSL
Message-Id: <20090306105946.6a31ce9c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Viktor,

On Wed, 25 Feb 2009 16:19:32 +0200, ts wrote:
> Good day!
> I want to install lm_sensors on my server, but when I do command 
> "sensors-detect" I receive this:
> [root@localhost kernel]# sensors-detect
> # sensors-detect revision 5291 (2008-06-23 23:40:46 -0700)
> 
> This program will help you determine which kernel modules you need
> to load to use lm_sensors most effectively. It is generally safe
> and recommended to accept the default answers to all questions,
> unless you know what you're doing.
> 
> We can start with probing for (PCI) I2C or SMBus adapters.
> Do you want to probe now? (YES/no):
> Probing for PCI bus adapters...
> Use driver `i2c-i801' for device 0000:00:1f.3: Intel Enterprise 
> Southbridge - ESB2
> 
> We will now try to load each adapter module in turn.
> Module `i2c-i801' already loaded.
> If you have undetectable or unsupported I2C/SMBus adapters, you can have
> them scanned by manually loading the modules before running this script.
> 
> We are now going to do the I2C/SMBus adapter probings. Some chips may
> be double detected; we choose the one with the highest confidence
> value in that case.
> If you found that the adapter hung after probing a certain address,
> you can specify that address to remain unprobed.
> 
> Next adapter: SMBus I801 adapter at 4000 (i2c-0)
> Do you want to scan it? (YES/no/selectively):
> 
> Some chips are also accessible through the ISA I/O ports. We have to
> write to arbitrary I/O ports to probe them. This is usually safe though.
> Yes, you do have ISA I/O ports even if you do not have any ISA slots!
> Do you want to scan the ISA I/O ports? (YES/no):
> Probing for `National Semiconductor LM78' at 0x290...       No
> Probing for `National Semiconductor LM78-J' at 0x290...     No
> Probing for `National Semiconductor LM79' at 0x290...       No
> Probing for `Winbond W83781D' at 0x290...                   No
> Probing for `Winbond W83782D' at 0x290...                   No
> 
> Some Super I/O chips may also contain sensors. We have to write to
> standard I/O ports to probe them. This is usually safe.
> Do you want to scan for Super I/O sensors? (YES/no):
> Probing for Super-I/O at 0x2e/0x2f
> Trying family `National Semiconductor'...                   Yes
> Found `Nat. Semi. PC87427 Super IO Health Sensors'         
>     (but not activated)

In 99% of the cases this means that the hardware monitoring of the
Super-I/O chip are not used on this system.

> Probing for Super-I/O at 0x4e/0x4f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Fintek'...                       No
> Trying family `ITE'...                                      No
> 
> Some south bridges, CPUs or memory controllers may also contain
> embedded sensors. Do you want to scan for them? (YES/no):
> Silicon Integrated Systems SIS5595...                       No
> VIA VT82C686 Integrated Sensors...                          No
> VIA VT8231 Integrated Sensors...                            No
> AMD K8 thermal sensors...                                   No
> AMD K10 thermal sensors...                                  No
> Intel AMB FB-DIMM thermal sensor...                         Success!
>     (driver `to-be-written')
> 
> Now follows a summary of the probes I have just done.
> Just press ENTER to continue:
> 
> Driver `to-be-written' (should be inserted):
>   Detects correctly:
>   * Chip `Intel AMB FB-DIMM thermal sensor' (confidence: 9)

Support for these sensors was added in kernel 2.6.24 only. Your kernel
is too old, unless your OS vendor backported the driver in question
(i5k_amb).

> Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no):
> 
> As I understood lm_sensors want pc87427.ko module but when I make
>  "modprobe pc87427" I receive:
> [root@localhost kernel]# modprobe pc87427
> FATAL: Error inserting pc87427 
> (/lib/modules/2.6.18-128.1.1.el5.asp121/extra/pc87427.ko): No such device
> Help me please!

This is because the device is disabled on your mainboard. The pc87427
driver doesn't forcibly enable disabled devices, because it has never
helped so far.

> My motherboard - Server Board S5000PSL

Is this mainboard somehow advertised as supporting hardware monitoring,
thermal management or fan speed control? Please check the technical
specification and documentation. You can also check in the BIOS if
there is any relevant option. If there are references then we can
investigate.

You can also try running the latest version of sensors-detect just in case:
http://www.lm-sensors.org/svn/lm-sensors/trunk/prog/detect/sensors-detect

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
