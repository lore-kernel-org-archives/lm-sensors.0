From: Mikael Jansson <mail@mikael.jansson.be>
Date: Thu, 08 May 2008 10:59:34 +0000
Subject: [lm-sensors] HP2133 support?
Message-Id: <loom.20080508T105547-918@post.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

What are the plans for the HP2133/Mini-Note?  It's a P4M900 SB, and here's the 
[trimmed] output of sensors-detect.  I'd be happy to help out by either 
extending an existing driver or writing a new, if I'm just given a few pointers 
where to begin!

===========
# sensors-detect revision 5016 (2007-11-11 22:20:16 +0100)
 
Do you want to probe now? (YES/no): 
Probing for PCI bus adapters...
Sorry, no known PCI bus adapters found.

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
 
Do you want to scan for Super I/O sensors? (YES/no): 
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   Yes
Found unknown chip with ID 0x8512
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Trying family `ITE'...                                      No
 
Do you want to scan for them? (YES/no): 
AMD K8 thermal sensors...                                   No
AMD K10 thermal sensors...                                  No
Intel Core family thermal sensor...                         No
Intel AMB FB-DIMM thermal sensor...                         No
===========

Thanks!
-- Mikael


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
