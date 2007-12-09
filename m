From: Peter Ganzhorn <peter.ganzhorn@googlemail.com>
Date: Sun, 09 Dec 2007 12:06:29 +0000
Subject: [lm-sensors] Intel Core voltage monitoring
Message-Id: <475BDA45.70400@googlemail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I'm wondering if there is an easy way to monitor the voltage of an Intel 
Core CPU with Linux.
Windows tools like cpu-z report CPU information such as speed and 
multiplicator, but voltage and even temperature as well.
I don't think those Windows tools have a complete set of hardware 
monitoring drivers built-in, and there is already the coretemp driver to 
monitor the temperature of an Intel Core CPU.
Do you know any way to monitor the voltage of my CPU?

BTW: I have a Toshiba Tecra A9 notebook on which lm_sensors can't 
identify the hardware monitoring chips:

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
Trying family `SMSC'...                                     Yes
Found unknown non-standard chip with ID 0x7a
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     Yes
Found unknown chip with ID 0x0b00

Some CPUs or memory controllers may also contain embedded sensors.
Do you want to scan for them? (YES/no):
AMD K8 thermal sensors...                                   No
Intel Core family thermal sensor...                         Success!
    (driver `coretemp')
Intel AMB FB-DIMM thermal sensor...                         No


coretemp works just fine, but I have no way of monitoring anything else 
which is quite unsatisfying to me...
Maybe you guys can help me monitoring at least vcore!

best regards,
Peter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
