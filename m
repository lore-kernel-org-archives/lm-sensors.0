From: "Mark E. Hansen" <meh@Winfirst.Com>
Date: Sun, 29 Mar 2009 14:48:56 +0000
Subject: [lm-sensors] lm-sensors 2.10.6: Unable to set temp2_max in
Message-Id: <49CF8A58.9040000@Winfirst.Com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

  I'm running sensors 2.10.6 on an ASUS M2NPV-VM motherboard on
CentOS Linux 5.2 - Kernel version 2.6.18-92.1.22.el5. This board uses
the ITE IT8716F sensors chip.

  I had problems running the 3.0.3 version, but had problems (which
I reported to this list some time ago) so I'm staying on 2.10.6
for now.

  I installed the it87 from (I think) the 2.6.25 version kernel sources,
built by a fellow on the CentOS forums. This was necessary because the
2.10.6 version of lm-sensors didn't support the IT8716F chip natively.

  Although this made it possible to use the 2.10.6 lm-sensors on my
CentOS 2.6.18 OS, I'm unable to set the motherboard max temperature.
Here are excerpts from my config file:

chip "iy8716-*"
  ...
  label   temp1  "CPU Temp"
  label   temp2  "M/B Temp"
  ignore  temp3


  # set temp1_min  24
  # set temp1_max  45
  # set temp2_min  30
  # set temp2_max  40

  When I uncomment the line which sets temp2_max, I get the following
error when running sensors -s:

Error: Line 380: Unknown feature name
it8716-isa-0290: No such feature known

  Line 380 is the line setting temp2_max to 40.

  As temperatures are going up in the house these days, I would sure like
to increase the max temp.

Thanks,

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
