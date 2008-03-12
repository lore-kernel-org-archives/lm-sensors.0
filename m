From: tomas fiasc <navygator18@yahoo.it>
Date: Wed, 12 Mar 2008 22:38:36 +0000
Subject: [lm-sensors] vt1211 not activate
Message-Id: <644174.91004.qm@web27409.mail.ukl.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6644355256219145442=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============6644355256219145442==
Content-Type: multipart/alternative; boundary="0-200654772-1205361516=:91004"
Content-Transfer-Encoding: 8bit

--0-200654772-1205361516=:91004
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

First of all sorry my English, I'm  Italian and writing are here to solve a problem with the chip vt1211

I use kubuntu with kernel 2.6.24-12

This is result:
 
tommaso@amilo:~$ sudo sensors-detect
# sensors-detect revision 5132 (2008-02-26 14:52:35 +0100)

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-viapro' for device 0000:00:11.0: VIA Technologies VT8233A/8235 South Bridge

We will now try to load each adapter module in turn.
Module `i2c-viapro' already loaded.
If you have undetectable or unsupported I2C/SMBus adapters, you can have
them scanned by manually loading the modules before running this script.

We are now going to do the I2C/SMBus adapter probings. Some chips may
be double detected; we choose the one with the highest confidence
value in that case.
If you found that the adapter hung after probing a certain address,
you can specify that address to remain unprobed.

Next adapter: SMBus Via Pro adapter at 0400 (i2c-0)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...
Yes
    (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'...                                No
Client found at address 0x51
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
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       Yes
Found `VIA VT1211 Super IO Sensors'
    (but not activated)
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   Yes
Found `Nat. Semi. PC87591 Super IO'
    (but not activated)

Some south bridges, CPUs or memory controllers may also contain
embedded sensors. Do you want to scan for them? (YES/no):
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD K10 thermal sensors...                                  No
Intel Core family thermal sensor...                         No
Intel AMB FB-DIMM thermal sensor...                         No

Sorry, no sensors were detected.
Either your sensors are not supported, or they are connected to an
I2C or SMBus adapter that is not supported. See doc/FAQ,
doc/lm_sensors-FAQ.html or http://www.lm-sensors.org/wiki/FAQ
(FAQ #4.24.3) for further information.
If you find out what chips are on your board, check
http://www.lm-sensors.org/wiki/Devices for driver status.

please help me

Thanks


       
---------------------------------
Inviato da Yahoo! Mail.
Il servizio di posta con lo spazio illimitato.
--0-200654772-1205361516=:91004
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div id="result_box" dir="ltr">First of all sorry my English, I'm&nbsp; Italian and writing are here to solve a problem with the chip vt1211</div><br>I use kubuntu with kernel 2.6.24-12<br><br>This is result:<br>&nbsp;<br>tommaso@amilo:~$ sudo sensors-detect<br># sensors-detect revision 5132 (2008-02-26 14:52:35 +0100)<br><br>This program will help you determine which kernel modules you need<br>to load to use lm_sensors most effectively. It is generally safe<br>and recommended to accept the default answers to all questions,<br>unless you know what you're doing.<br><br>We can start with probing for (PCI) I2C or SMBus adapters.<br>Do you want to probe now? (YES/no):<br>Probing for PCI bus adapters...<br>Use driver `i2c-viapro' for device 0000:00:11.0: VIA Technologies VT8233A/8235 South Bridge<br><br>We will now try to load each adapter module in turn.<br>Module `i2c-viapro' already loaded.<br>If you have undetectable or unsupported I2C/SMBus adapters, you can have<br>them
 scanned by manually loading the modules before running this script.<br><br>We are now going to do the I2C/SMBus adapter probings. Some chips may<br>be double detected; we choose the one with the highest confidence<br>value in that case.<br>If you found that the adapter hung after probing a certain address,<br>you can specify that address to remain unprobed.<br><br>Next adapter: SMBus Via Pro adapter at 0400 (i2c-0)<br>Do you want to scan it? (YES/no/selectively):<br>Client found at address 0x50<br>Probing for `Analog Devices ADM1033'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Probing for `Analog Devices ADM1034'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Probing for `SPD EEPROM'...<br>Yes<br>&nbsp;&nbsp;&nbsp; (confidence 8, not a hardware monitoring chip)<br>Probing for `EDID
 EEPROM'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Client found at address 0x51<br>Probing for `Analog Devices ADM1033'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Probing for `Analog Devices ADM1034'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Probing for `SPD EEPROM'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Yes<br>&nbsp;&nbsp;&nbsp; (confidence 8, not a hardware monitoring chip)<br>Probing for `EDID
 EEPROM'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br><br>Some chips are also accessible through the ISA I/O ports. We have to<br>write to arbitrary I/O ports to probe them. This is usually safe though.<br>Yes, you do have ISA I/O ports even if you do not have any ISA slots!<br>Do you want to scan the ISA I/O ports? (YES/no): Probing for `National Semiconductor LM78' at 0x290...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Probing for `National Semiconductor LM78-J' at 0x290...&nbsp;&nbsp;&nbsp;&nbsp; No<br>Probing for `National Semiconductor LM79' at 0x290...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Probing for `Winbond W83781D' at 0x290...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Probing for `Winbond W83782D' at
 0x290...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Probing for `IPMI BMC KCS' at 0xca0...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Probing for `IPMI BMC SMIC' at 0xca8...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br><br>Some Super I/O chips may also contain sensors. We have to write to<br>standard I/O ports to probe them. This is usually safe.<br>Do you want to scan for Super I/O sensors? (YES/no):<br>Probing for Super-I/O at 0x2e/0x2f<br>Trying family `National Semiconductor'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Trying family
 `SMSC'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Trying family `VIA/Winbond/Fintek'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Yes<br>Found `VIA VT1211 Super IO Sensors'<br>&nbsp;&nbsp;&nbsp; (but not activated)<br>Probing for Super-I/O at 0x4e/0x4f<br>Trying family `National Semiconductor'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Yes<br>Found `Nat. Semi. PC87591 Super IO'<br>&nbsp;&nbsp;&nbsp; (but not activated)<br><br>Some south bridges, CPUs or memory controllers may also contain<br>embedded sensors. Do you want to scan for them? (YES/no):<br>Silicon Integrated Systems
 SIS5595...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>VIA VT82C686 Integrated Sensors...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>VIA VT8231 Integrated Sensors...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>AMD K8 thermal sensors...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>AMD K10 thermal
 sensors...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Intel Core family thermal sensor...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Intel AMB FB-DIMM thermal sensor...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br><br>Sorry, no sensors were detected.<br>Either your sensors are not supported, or they are connected to an<br>I2C or SMBus adapter that is not supported. See doc/FAQ,<br>doc/lm_sensors-FAQ.html or http://www.lm-sensors.org/wiki/FAQ<br>(FAQ #4.24.3) for further information.<br>If you find out what chips are on your board, check<br>http://www.lm-sensors.org/wiki/Devices for driver
 status.<br><br>please help me<br><br>Thanks<br><br><p>&#32;




      <hr size=1>
Inviato da <a  
href="http://us.rd.yahoo.com/mailuk/taglines/isp/control/*http://us.rd.yahoo.com/evt=52437/*http://it.docs.yahoo.com/mail/overview/index.html" target=_blank>Yahoo! Mail</a>.
<br>
Il servizio di posta con lo spazio illimitato.
--0-200654772-1205361516=:91004--


--===============6644355256219145442==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6644355256219145442==--
