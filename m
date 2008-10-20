From: "bo wang" <wangbo351@gmail.com>
Date: Mon, 20 Oct 2008 11:16:01 +0000
Subject: [lm-sensors] not suppot 945GSE ?
Message-Id: <2a2f4db00810200416j5d539665p3219ae3325e2ed4d@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0247312696229873247=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============0247312696229873247==
Content-Type: multipart/alternative; 
	boundary="----=_Part_118032_9370517.1224501361051"

------=_Part_118032_9370517.1224501361051
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Deal All,



Sensors not spuort 945GSE ?

OS ubuntu 8.04.1

Lm-Sensors version 3.0



root@eeepc-laptop:~# sensors-detect

# sensors-detect revision 5016 (2007-11-11 22:20:16 +0100)



This program will help you determine which kernel modules you need

to load to use lm_sensors most effectively. It is generally safe

and recommended to accept the default answers to all questions,

unless you know what you're doing.



We can start with probing for (PCI) I2C or SMBus adapters.

Do you want to probe now? (YES/no): YES

Probing for PCI bus adapters...

Sorry, no known PCI bus adapters found.



We will now try to load each adapter module in turn.

If you have undetectable or unsupported adapters, you can have them

scanned by manually loading the modules before running this script.



We are now going to do the I2C/SMBus adapter probings. Some chips may

be double detected; we choose the one with the highest confidence

value in that case.

If you found that the adapter hung after probing a certain address,

you can specify that address to remain unprobed.



Some chips are also accessible through the ISA I/O ports. We have to

write to arbitrary I/O ports to probe them. This is usually safe though.

Yes, you do have ISA I/O ports even if you do not have any ISA slots!

Do you want to scan the ISA I/O ports? (YES/no): YES

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

Do you want to scan for Super I/O sensors? (YES/no): YES

Probing for Super-I/O at 0x2e/0x2f

Trying family `National Semiconductor'...                   No

Trying family `SMSC'...                                     No

Trying family `VIA/Winbond/Fintek'...                       No

Trying family `ITE'...                                      No

Probing for Super-I/O at 0x4e/0x4f

Trying family `National Semiconductor'...                   No

Trying family `SMSC'...                                     No

Trying family `VIA/Winbond/Fintek'...                       No

Trying family `ITE'...                                      No



Some CPUs or memory controllers may also contain embedded sensors.

Do you want to scan for them? (YES/no): YES

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









root@eeepc-laptop:~# lsmod |grep i2c

i2c_i810                5636  0

i2c_algo_bit            7300  1 i2c_i810

i2c_dev                 8836  0

i2c_viapro              9876  0

i2c_core               24832  5
eeprom,i2c_i810,i2c_algo_bit,i2c_dev,i2c_viapro





root@eeepc-laptop:~# lsmod |grep eeprom

eeprom                  8208  0

i2c_core               24832  5
eeprom,i2c_i810,i2c_algo_bit,i2c_dev,i2c_viapro





root@eeepc-laptop:~# sensors

No sensors found!

Make sure you loaded all the kernel drivers you need.

Try sensors-detect to find out which these are.





root@eeepc-laptop:/proc/acpi/thermal_zone/TZ00# ls

cooling_mode  polling_frequency  state  temperature  trip_points

root@eeepc-laptop:/proc/acpi/thermal_zone/TZ00# cat temperature

temperature:             51 C





can you  tell me  why  ? sensors could not run .

B. R

Sam

------=_Part_118032_9370517.1224501361051
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr"><p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US"><font size="3"><font face="Times New Roman">Deal All, </font></font></span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">&nbsp;</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">Sensors not spuort 945GSE ?</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">OS ubuntu 8.04.1</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">Lm-Sensors version 3.0 </span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">&nbsp;</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">root@eeepc-laptop:~# sensors-detect </span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial"># sensors-detect revision 5016 (2007-11-11 22:20:16 +0100)</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">&nbsp;</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">This program will help you determine which kernel modules you need</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">to load to use lm_sensors most effectively. It is generally safe</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">and recommended to accept the default answers to all questions,</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">unless you know what you&#39;re doing.</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">&nbsp;</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">We can start with probing for (PCI) I2C or SMBus adapters.</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">Do you want to probe now? (YES/no): YES</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">Probing for PCI bus adapters...</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">Sorry, no known PCI bus adapters found.</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">&nbsp;</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">We will now try to load each adapter module in turn.</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">If you have undetectable or unsupported adapters, you can have them</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">scanned by manually loading the modules before running this script.</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">&nbsp;</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">We are now going to do the I2C/SMBus adapter probings. Some chips may</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">be double detected; we choose the one with the highest confidence</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">value in that case.</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">If you found that the adapter hung after probing a certain address,</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">you can specify that address to remain unprobed.</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">&nbsp;</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">Some chips are also accessible through the ISA I/O ports. We have to</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">write to arbitrary I/O ports to probe them. This is usually safe though.</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">Yes, you do have ISA I/O ports even if you do not have any ISA slots!</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">Do you want to scan the ISA I/O ports? (YES/no): YES</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">Probing for `National Semiconductor LM78&#39; at 0x290...<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>No</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">Probing for `National Semiconductor LM78-J&#39; at 0x290...<span>&nbsp;&nbsp;&nbsp;&nbsp; </span>No</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">Probing for `National Semiconductor LM79&#39; at 0x290...<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>No</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">Probing for `Winbond W83781D&#39; at 0x290...<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span>&nbsp;&nbsp;</span>No</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">Probing for `Winbond W83782D&#39; at 0x290...<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>No</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">Probing for `Silicon Integrated Systems SIS5595&#39;...<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>No</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">Probing for `VIA VT82C686 Integrated Sensors&#39;...<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>No</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">Probing for `VIA VT8231 Integrated Sensors&#39;...<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>No</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">Probing for `IPMI BMC KCS&#39; at 0xca0...<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>No</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">Probing for `IPMI BMC SMIC&#39; at 0xca8...<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>No</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">&nbsp;</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">Some Super I/O chips may also contain sensors. We have to write to</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">standard I/O ports to probe them. This is usually safe.</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">Do you want to scan for Super I/O sensors? (YES/no): YES</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">Probing for Super-I/O at 0x2e/0x2f</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">Trying family `National Semiconductor&#39;...<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>No</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">Trying family `SMSC&#39;...<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>No</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">Trying family `VIA/Winbond/Fintek&#39;...<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>No</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">Trying family `ITE&#39;...<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>No</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">Probing for Super-I/O at 0x4e/0x4f</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">Trying family `National Semiconductor&#39;...<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>No</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">Trying family `SMSC&#39;...<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>No</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">Trying family `VIA/Winbond/Fintek&#39;...<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>No</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">Trying family `ITE&#39;...<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>No</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">&nbsp;</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">Some CPUs or memory controllers may also contain embedded sensors.</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">Do you want to scan for them? (YES/no): YES</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">AMD K8 thermal sensors...<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>No</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">AMD K10 thermal sensors...<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>No</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">Intel Core family thermal sensor...<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>No</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">Intel AMB FB-DIMM thermal sensor...<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>No</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">&nbsp;</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">Sorry, no sensors were detected.</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">Either your sensors are not supported, or they are connected to an</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">I2C or SMBus adapter that is not supported. See doc/FAQ,</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">doc/lm_sensors-FAQ.html or <a href="http://www.lm-sensors.org/wiki/FAQ" target="_blank">http://www.lm-sensors.org/wiki/FAQ</a></span></p>

<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">(FAQ #4.24.3) for further information.</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">If you find out what chips are on your board, check</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial"><a href="http://www.lm-sensors.org/wiki/Devices" target="_blank">http://www.lm-sensors.org/wiki/Devices</a> for driver status.</span></p>

<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">&nbsp;</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">&nbsp;</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">&nbsp;</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">&nbsp;</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">root@eeepc-laptop:~# lsmod |grep i2c </span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">i2c_i810<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>5636<span>&nbsp; </span>0 </span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">i2c_algo_bit<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>7300<span>&nbsp; </span>1 i2c_i810</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">i2c_dev<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>8836<span>&nbsp; </span>0 </span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">i2c_viapro<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>9876<span>&nbsp; </span>0 </span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">i2c_core<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>24832<span>&nbsp; </span>5 eeprom,i2c_i810,i2c_algo_bit,i2c_dev,i2c_viapro</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">&nbsp;</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">&nbsp;</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">root@eeepc-laptop:~# lsmod |grep eeprom</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">eeprom<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>8208<span>&nbsp; </span>0 </span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">i2c_core<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>24832<span>&nbsp; </span>5 eeprom,i2c_i810,i2c_algo_bit,i2c_dev,i2c_viapro</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">&nbsp;</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">&nbsp;</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">root@eeepc-laptop:~# sensors</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">No sensors found!</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">Make sure you loaded all the kernel drivers you need.</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">Try sensors-detect to find out which these are.</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">&nbsp;</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">&nbsp;</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">root@eeepc-laptop:/proc/acpi/thermal_zone/TZ00# ls</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">cooling_mode<span>&nbsp; </span>polling_frequency<span>&nbsp; </span>state<span>&nbsp; </span>temperature<span>&nbsp; </span>trip_points</span></p>

<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">root@eeepc-laptop:/proc/acpi/thermal_zone/TZ00# cat temperature </span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">temperature:<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>51 C</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">&nbsp;</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">&nbsp;</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">can you<span>&nbsp; </span>tell me<span>&nbsp; </span>why<span>&nbsp; </span>? sensors could not run .</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">B. R</span></p>
<p style="MARGIN: 0cm 0cm 0pt"><span lang="EN-US" style="FONT-SIZE: 9pt; FONT-FAMILY: Arial">Sam </span></p></div>

------=_Part_118032_9370517.1224501361051--


--===============0247312696229873247==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0247312696229873247==--
