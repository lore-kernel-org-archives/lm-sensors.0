From: Wolfgang Grandegger <wg@grandegger.com>
Date: Sat, 13 Sep 2008 08:46:00 +0000
Subject: [lm-sensors] [PATCH 0/2] hwmon: w83781d: converting to new-style
Message-Id: <48CB7DC8.3060503@grandegger.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I made another effort to convert the w83781d to new-style binding. The
series consists of the following two patches:

  [PATCH 1/2] hwmon: w83781d: make ISA interface depend on CONFIG_ISA
  [PATCH 2/2] hwmon: w83781d: use new style driver binding

I have tested it one a PowerPC MPC8544 board. I did not have any
occasion to verify the ISA related part.

Wolfgang.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
