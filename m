From: Chuck Williams <chuck@manawiz.com>
Date: Sun, 15 Jun 2008 22:17:25 +0000
Subject: [lm-sensors] ipmisensors for 2.6.25?
Message-Id: <485594F5.8010209@manawiz.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi All,

I am trying to get lm-sensors working on a debian lenny amd64 system 
running a 2.6.25 kernel. This is a quad-core xeon with an Intel 
chipset.  I'm getting EDAC i5000 thermal errors in syslog and want to 
see the complete set of available temperatures.

sensor-detect reports that I need ipmi-si, ipmisensors and coretemp 
kernel modules.  ipmi-si and coretemp load just fine (although coretemp 
does not load on kernel 2.6.24, as others have also reported based on 
googling).  However, there does not appear to be any available 
ipmisensors module for this kernel, nor a debian kernel patch module for it.

I downloaded the ipmisensors kernel patch form sourceforge and tried to 
apply it against my 2.6.25 kernel sources (debian version), but it fails 
to apply.  It appears the patch is over 2 years old and was last tested 
on 2.6.16.

Does anybody know how to get a working ipmisensors for 2.6.25?

Thanks for any help,

Chuck


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
