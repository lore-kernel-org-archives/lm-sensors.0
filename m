From: han.nguyen@amd.com (han.nguyen@amd.com)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: insmod of the i2c-amd756 failed.
Message-Id: <99F2150714F93F448942F9A9F112634CC35ACA@txexmtae.amd.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi there,

I installed lm_sensors 2.8.0 and i2c 2.8.0 on the SuSe machine with kernel 2.4.19. The installation went well. I ran sensors-detect and the program detected
AMD-8111 SMBus 2.0 and AMD-8111 ACPI. The program sucessfully installed the i2c-amd8111 for the SMB 2.0 but failed to install i2c-amd756 for the AMD-8111 ACPI. 
The details are in the included file that I captured when I ran the sensors-detect program. The dmesg just gives the module name and its version number.
Do you have any idea on what is going on and any sugestion on anything that I need to do.

Thanks a lot,

Han

 <<i2cdetect-0>>  <<lsmod>>  <<lspci>>  <<sensors-detect>> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2cdetect-0
Type: application/octet-stream
Size: 683 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031006/40c6dd4a/i2cdetect-0.obj
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lsmod
Type: application/octet-stream
Size: 1694 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031006/40c6dd4a/lsmod.obj
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lspci
Type: application/octet-stream
Size: 4138 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031006/40c6dd4a/lspci.obj
-------------- next part --------------
A non-text attachment was scrubbed...
Name: sensors-detect
Type: application/octet-stream
Size: 12042 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031006/40c6dd4a/sensors-detect.obj
