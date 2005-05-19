From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: DS1621 support for kernel 2.6 (+question about PCF8591)
Message-Id: <20040304224220.GB8606@pc.aurel32.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Mar 03, 2004 at 11:16:19PM +0100, Jean Delvare wrote:
> Hi Aurelien :)
> 
> > I have ported the ds1621 driver from lm-sensors 2.8.4 to kernel 2.6.3.
> 
> Good news :)
> 
> Have you been following the porting-chips and sysfs-interface documents?
Yes, I have read these documents and tried to follow them. For this
driver, there is two more file type than described in sysfs-interface,
continous and enable. However, as they doesn't need to be accessed
through lm-sensors I think it should not be a problem. They are mostly
there if you screwed up the device.
 
> > I also plan to port the pcf8574 and pcf8591 drivers over the
> > week-end.
> 
> Probably not the most wanted chips ;) but it you have a particular
> interest for these, do not hesitate.
Yes I know they are not very common however I sometimes use them. Since
I switched to a 2.6 kernel, I can't use them anymore, that's why I am 
interested by ported them.

BTW, I don't know really how to follow the sysfs-interface document with
the PCF8591. The current driver in lm-sensors creates the following
files under /proc:
ain_conf:    used to configure the 4 inputs (single ended, differential,
             etc.)
ch[0-3]:     the 4 input channels, representing a voltage
aout:        the output channel, representing a voltage
aout_enable: enable/disable the output channel

I think I can map ch[0-3] to in[0-3] but for the others I don't know
what to do. If you have an idea, let me know.

> I'll review your code over the week-end if nodoby has done so before.
Thanks !

Aurelien

-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineering Student 
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
