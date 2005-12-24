From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Sat, 24 Dec 2005 14:20:48 +0000
Subject: [lm-sensors] Patch: abituguru driver version 1.1.1
Message-Id: <43AD5940.1090900@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

After a lot of work by both me and 2 testers which were reporting 
problems I'm very happy to present this version for review, which has no 
know problems left after being tested by 8 different people on I believe 
6 different mainboards .

The bigest problem is / was the strange version of the uGuru on an Abit 
AX8, this had both detection and reading issues, both of which are fixed 
now see the ChangeLog in the abituguru.c.txt for all the details.

Sorry about the version inflation. 0.9 was the first working version, 
which was honestly as complete as I thought it would ever become hence 
0.9, 1.0 added a lot of extra features (sensors part fully supported) 
and now 1.1 which has seen some reading-method changes (mainly adding 
retries) and a big shuffle to make this possible in a clean manner.

Notice that I'm developing this driver as an out of tree driver, which 
is very easy thanks to the new 2.6 makefile structure and thus I don't 
have any patches for the 2.6 in tree makefiles, attached is a makefile 
which can be used to compile it out of tree.

Also included is a libsensors patch against CVS to add the nescesarry 
userspace support.

I've also attached an sysfs interface extension proposal, which has 
already been send the list once, all the xx_mask_xx files follow this 
proposal.

Thanks, Regards and Merry Christmas,

Hans
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: Makefile.txt
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20051224/84f5656c/Makefile-0001.txt
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: abituguru.c.txt
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20051224/84f5656c/abituguru.c-0001.txt
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: lm_sensors-cvs-uguru.patch.txt
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20051224/84f5656c/lm_sensors-cvs-uguru.patch-0001.txt
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: sysfs-interface-proposal.txt
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20051224/84f5656c/sysfs-interface-proposal-0001.txt
