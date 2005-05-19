From: donj@asaca.com (Don Jessup)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: System hanging using CSB5 chip with 2.8.1 - No longer
Message-Id: <20031201153923.93843.qmail@web14523.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031125211801.35736.qmail@web14522.mail.yahoo.com>
In-Reply-To: <20031125211801.35736.qmail@web14522.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Why did you use that force parameter? Was it suggested by
> sensors-detect?

    The adm1021 text file in lm_sensors2/doc/chips suggest to get Xeon
   support that I should use the force_adm1021 module parameter.  Is this
   correct ?  Should I just use the module without any parameters?
  

> I'd be interested in a full sensors-detect log (after you unloaded all
> chip drivers, of course). Also, if you provide dumps for your four
> chips, I will take a look into that and maybe tell you more about
> what's on your motherboard exactly.
> 
> i2cdump 0 0x18
> i2cdump 0 0x29
> i2cdump 0 0x2d
> i2cdump 0 0x2e


   I have included 9 log files in this e-mail.
    This first file being the sensors-detect.log. The next 4 are i2cdump with 
   out force_adm1021 as a module paramter.  The next 4 are i2cdump with  the
   force_adm1021 as a module parameter.  


   Thank You again for your help.
     
    

==Don Jessup
Asaca/Shibasoku Corp. of America
400 Corporate Circle, Unit G
Golden, CO  80401
303-278-1111 X232
donj@asaca.com
http://www.asaca.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: sensors-detect.log
Type: application/octet-stream
Size: 11515 bytes
Desc: sensors-detect.log
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031201/747d4c44/sensors-detect.obj
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2cdump-withParam-0-0x18.log
Type: application/octet-stream
Size: 1224 bytes
Desc: i2cdump-withParam-0-0x18.log
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031201/747d4c44/i2cdump-withParam-0-0x18.obj
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2cdump-withParam-0-0x29.log
Type: application/octet-stream
Size: 1224 bytes
Desc: i2cdump-withParam-0-0x29.log
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031201/747d4c44/i2cdump-withParam-0-0x29.obj
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2cdump-withParam-0-0x2d.log
Type: application/octet-stream
Size: 1224 bytes
Desc: i2cdump-withParam-0-0x2d.log
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031201/747d4c44/i2cdump-withParam-0-0x2d.obj
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2cdump-withParam-0-0x2e.log
Type: application/octet-stream
Size: 1224 bytes
Desc: i2cdump-withParam-0-0x2e.log
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031201/747d4c44/i2cdump-withParam-0-0x2e.obj
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2cdump-wOutParam-0-0x18.log
Type: application/octet-stream
Size: 1224 bytes
Desc: i2cdump-wOutParam-0-0x18.log
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031201/747d4c44/i2cdump-wOutParam-0-0x18.obj
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2cdump-wOutParam-0-0x29.log
Type: application/octet-stream
Size: 1224 bytes
Desc: i2cdump-wOutParam-0-0x29.log
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031201/747d4c44/i2cdump-wOutParam-0-0x29.obj
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2cdump-wOutParam-0-0x2d.log
Type: application/octet-stream
Size: 1224 bytes
Desc: i2cdump-wOutParam-0-0x2d.log
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031201/747d4c44/i2cdump-wOutParam-0-0x2d.obj
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2cdump-wOutParam-0-0x2e.log
Type: application/octet-stream
Size: 1224 bytes
Desc: i2cdump-wOutParam-0-0x2e.log
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031201/747d4c44/i2cdump-wOutParam-0-0x2e.obj
