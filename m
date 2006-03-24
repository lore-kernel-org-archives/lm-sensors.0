From: andrew.r.cress@intel.com (Cress, Andrew R)
Date: Fri, 24 Mar 2006 21:59:20 +0000
Subject: [lm-sensors] linux-2.4.27-i2c-2.10.0-drivers patch broken for =y
Message-Id: <74A9A71929931E40967CA9F27B1D739603222FF7@hdsmsx401.amr.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

 
With kernel.org Linux 2.4.27, we added the patch
http://khali.linux-fr.org/devel/i2c/linux-2.4.27/linux-2.4.27-i2c-2.10.0
-drivers-i2c.diff
<http://khali.linux-fr.org/devel/i2c/linux-2.4.27/linux-2.4.27-i2c-2.10.
0-drivers-i2c.diff>  , because it was pointed to by lm_sensors
http://secure.netroedge.com/~lm78/download.html
<http://secure.netroedge.com/~lm78/download.html> 

But it empties out init_i2c_all() in drivers/char/i2c-core.c.  
Which of course is what drivers/char/mem.c:chr_dev_init() requires
/calls  for the i2c initialization.  
The patch worked via the module dependencies if CONFIG*=m, but fails if
CONFIG*=y because char devices then try to load before i2c.  

This is very bad for char devices that depend upon i2c.  In my case,
this was seen while testing with OpenIPMI's ipmi_smb driver .  
We were also able to make this work ok with =y with lm_sensors 2.7.0 and
prior.  Corey Minyard from OpenIPMI mentioned that if the memset() of
the drivers[] array were removed, it might work.

 Andy Cress

Andy Cress                      803-216-2356 fax:803-216-2178
Senior Software Engineer         andrew.r.cress at intel.com
Intel Corporation, Columbia Design Center
100 Center Point Cir, Suite 200, Columbia, SC 29210
http://ipmiutil.sf.net <http://ipmiutil.sf.net/>
http://scsirastools.sf.net <http://scsirastools.sf.net/> 
"Do not merely look out for your own personal interests,
but also for the interests of others."  Phil 2:4
 
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060324/bcee4df7/attachment.html
