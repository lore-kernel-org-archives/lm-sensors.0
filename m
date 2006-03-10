From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Fri, 10 Mar 2006 10:58:13 +0000
Subject: [lm-sensors] New Abit uGuru (lm_sensors) driver please test!
Message-Id: <44115BC5.5090704@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Here is yet another release of the Abit uGuru driver, the big change 
which needs testing is:
-(attempt to) detect the number of pwm outputs and fan sensors, so that
  we do not give the user the ability to write pwm-settings for pwm's
  which aren't there, otherwise the user could cause us to overwrite
  random uGuru memory.

This is because support for the AA8XE Fatal1ty motherboard has been 
added which comes with 5 pwm outputs for fan control, always making 5 
pwms available will allow uGuru memory corruption to be caused by the 
user when writing settings to pwm 4 or 5 on an uguru which doesn't have 
these.

After loading the driver you should see something like this in dmesg:
abituguru: detecting number of fan sensors
abituguru:   bank2 sensor 5 does not seem to be a fan sensor: 
settings[0] = 40
abituguru:  found: 5 fan sensors
abituguru: detecting number of PWM outputs
abituguru:   pwm channel 3 does not seem to be a pwm channel: 9 is not a 
valid temp sensor address
abituguru:  found: 3 PWM outputs

Please check that the number of fan sensors and pwm outputs (FAN EQ 
control) match the numbers in you bios, and report your results (both 
success and failure) to me. Many thanks for testing.

As always Instructions for using / building the driver can be found in 
the file README.txt . You need to move Makefile.txt to Makefile and 
abituguru.c.txt to abituguru.c I had to add a .txt extension to make the 
mailinglist happy.

Regards,

Hans

p.s.

Sorry about the big post to the list, I just wanted to have everything 
(makefile, driver, userspace patches, docs) together in the archives for 
users looking / searching for uguru support.
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: COPYING.txt
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060310/34636342/COPYING-0001.txt
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: ChangeLog.txt
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060310/34636342/ChangeLog-0001.txt
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: Makefile.txt
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060310/34636342/Makefile-0001.txt
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: README.txt
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060310/34636342/README-0001.txt
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: abituguru.c.txt
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060310/34636342/abituguru.c-0001.txt
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: abituguru-datasheet.txt
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060310/34636342/abituguru-datasheet-0001.txt
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm_sensors-2.9.2-uguru.patch
Type: text/x-patch
Size: 15184 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060310/34636342/lm_sensors-2.9.2-uguru-0001.bin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm_sensors-2.10.0-uguru.patch
Type: text/x-patch
Size: 17805 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060310/34636342/lm_sensors-2.10.0-uguru-0001.bin
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: sysfs-interface-proposal.txt
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060310/34636342/sysfs-interface-proposal-0001.txt
