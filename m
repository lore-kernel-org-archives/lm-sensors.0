From: pete4abw@comcast.net (Peter Hyman)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: lm_sensors shell and Mandrake
Message-Id: <1064150341.8374.5.camel@localhost>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

thanks again for your help and I enjoy lm_sensors. I use GKrellm and it
updates all the time.  Fun.

I noticed one thing however that may be particular to my system.  Even
though the installation script places an lm_sensors shell script in
/etc/rc.d/init.d and a lm_sensors file in /etc/sysconfig, it is never
used.  Looking at my dmesg output, the only thing starting is the lines
from the rc.local file I modified.

I could install the lm_sensors shell script using the SysV editor, but I
don't want to mess anything up having the rc.local script running fine.

As feedback, it seems to me that either the install script show
recommended lines for an rc.* file OR allow the user to install the
script as part of the start up sequence.

Right now, I have the files, but they are never used!

Let me know what you think.
-- 
Peter Hyman
Home:(609)395-1211 Office: (609)655-1184, Fax:(609)655-0285
Stop Telemarketers.  Sign up for Do Not Call at http://donotcall.gov
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 193 bytes
Desc: This is a digitally signed message part
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030921/747fc2da/attachment.bin
