From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 10 Nov 2006 13:52:44 +0000
Subject: [lm-sensors] Display DMI data in sensors-detect output
Message-Id: <20061110145244.837a3cae.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

When users report about systems where lm-sensors doesn't work, we often
ask them for the complete output of sensors-detect. And we often ask
them what motherboard or system they have. I thought that we may save
some time if the output of sensors-detect included this information
already. I hacked a patch doing just that, using dmidecode. Thanks to
the new command line interface introduced in dmidecode 2.7, the need
for parsing is very limited.

Here is an example of output with the patch applied:

# sensors-detect revision 4229 (2006-11-10 10:19:48 +0100)
# System Manufacturer: Sony Corporation
# System Product Name: PCG-GR214EP(FR) (01)
# Chassis Type: Notebook

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.
(...)

Note that it doesn't make sensors-detect require dmidecode. dmidecode
will be used when found, else the output is the same as before. Patch
is attached if you want to give it a try.

Thoughts anyone?
-- 
Jean Delvare
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: sensors-detect-with-dmi-data.patch
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061110/faeb832a/attachment.pl 
