From: Bruno DUYE <brunetton@gmail.com>
Date: Sun, 10 Nov 2013 21:49:55 +0000
Subject: [lm-sensors] Submitting a patch
Message-Id: <CAFCHPoNujkPUHfi1Ep4EnWm=aDUbMY=6PqRRS6_A7Es4+TzeXw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all;

Today, I found a little bug in lm-sensor, and wanted to submit you a
patch using csv. Si I came to the doc, section "How to get CVS acces",
clicked on the link of daily builds; but nothing appears here.
The link http://www2.lm-sensors.nu/~lm78/download.html#cvs send a blank file.

So, here is the patch, by email (not my prefered way so far).

it's nearly nothing : in sensor-detect perl script; > 3.0 kernels
numbers are not matched by the regex. Here's a quick patch :

2666c2666
< $kernel_version =~ /(\d+)\.(\d+)\.(\d+)(.*)/;
---
> $kernel_version =~ /(\d+)\.(\d+)[-\.](\d+)(.*)/;

Thanks

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
