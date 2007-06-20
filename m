From: "=?ISO-8859-1?Q?Bal=E1zs_H=E1morszky?=" <balihb.old@gmail.com>
Date: Wed, 20 Jun 2007 10:58:35 +0000
Subject: [lm-sensors] gigabyte GA-8IE
Message-Id: <c823af600706200358j5c64468cy2011ba72deecbf45@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4686991392855141271=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============4686991392855141271==
Content-Type: multipart/alternative; 
	boundary="----=_Part_9337_6714251.1182337115012"

------=_Part_9337_6714251.1182337115012
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I can't get lm-sensors working on GA-8IE
http://www.gigabyte.com.tw/Support/Motherboard/BIOS_Model.aspx?ProductID=1320
(i have the latest bios version)
it seems it have Both ITE8702 and ITE8712
but sensors-detect can't find ITE8712
Probing for Super-I/O at 0x2e/0x2f
Trying family `ITE'...                                      Yes
Found `ITE IT8702F Super IO Sensors'                        Success!
    (address 0x290, driver `to-be-written')
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Probing for Super-I/O at 0x4e/0x4f
Trying family `ITE'...                                      No
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No

# modprobe it87
FATAL: Error inserting it87
(/lib/modules/2.6.21-1-686/kernel/drivers/hwmon/it87.ko): No such device

and acpi say
No support for device type: thermal

so I can't get the cpu temp.

Regards,
 BaliHB

------=_Part_9337_6714251.1182337115012
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I can&#39;t get lm-sensors working on GA-8IE<br><a href="http://www.gigabyte.com.tw/Support/Motherboard/BIOS_Model.aspx?ProductID=1320">http://www.gigabyte.com.tw/Support/Motherboard/BIOS_Model.aspx?ProductID=1320</a><br>(i have the latest bios version)
<br>it seems it have  Both ITE8702 and ITE8712<br>but sensors-detect can&#39;t find ITE8712<br>Probing for Super-I/O at 0x2e/0x2f<br>Trying family `ITE&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Yes<br>Found `ITE IT8702F Super IO Sensors&#39;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success!
<br>&nbsp;&nbsp;&nbsp; (address 0x290, driver `to-be-written&#39;)<br>Trying family `National Semiconductor&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Trying family `SMSC&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Trying family `VIA/Winbond/Fintek&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No
<br>Probing for Super-I/O at 0x4e/0x4f<br>Trying family `ITE&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Trying family `National Semiconductor&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>Trying family `SMSC&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No
<br>Trying family `VIA/Winbond/Fintek&#39;...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br><br># modprobe it87<br>FATAL: Error inserting it87 (/lib/modules/2.6.21-1-686/kernel/drivers/hwmon/it87.ko): No such device<br><br>and acpi say<br>
No support for device type: thermal<br><br>so I can&#39;t get the cpu temp.<br><br>Regards,<br>&nbsp;BaliHB<br>

------=_Part_9337_6714251.1182337115012--


--===============4686991392855141271==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4686991392855141271==--
