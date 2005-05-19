From: sascha@akv-soft.de (Sascha Volkenandt)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: Patchset: SAA1064
Message-Id: <200307191355.19441.sascha@akv-soft.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello list, hello Jean,

I've put ogether a patchset against the CVS from about five minutes ago, 
including Documentation and all changes proposed in new_drivers (except for 
libsensors support, which I don't think is really necessary on such a 
chip). Following changes have been made to the code:

- Updated chip-notes
- i2c_check_functionality is only used once
- saa1064_write_value has been replaced by the appropriate 
i2c_smbus_write_... functions in-place
- use of memset in saa1064_init_client()
- use of i2c_smbus_write_i2c_block_data to write the digits
- replaced pwrloss sysctl with refresh sysctl (see doc)
- added detection (four bytes read, first byte must be 0x80 or 0x00, others 
0x00)
- removed dynamic and blank{13,24}, instead always using dynamic mode, all 
digits

Hope everything went ok, I have tried the detection procedure on the pcf8574  
(the only chip besides the SAA1064 I can play with) by force, and it has 
not been mis-detected (except by forcing it, of course).

Jean, I will now install perl and see how your detect-script reacts to those 
two chips, report will follow ;-)

Greetings,
Sascha

-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm_sensors2-cvs-saa1064.diff
Type: text/x-diff
Size: 19587 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030719/a2d923fb/lm_sensors2-cvs-saa1064.bin
