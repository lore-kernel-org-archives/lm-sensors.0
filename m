From: Huang Rui <ray.huang@amd.com>
Date: Thu, 10 Dec 2015 03:56:09 +0000
Subject: [lm-sensors] [PATCH 0/2] hwmon: (fam15h_power) Add new AMD family 15h processors
Message-Id: <1449719771-12837-1-git-send-email-ray.huang@amd.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.de>, Andreas Herrmann <herrmann.der.user@gmail.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Andreas Herrmann <herrmann.der.user@googlemail.com>, Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>, Borislav Petkov <bp@alien8.de>, Huang Rui <ray.huang@amd.com>

Hi Guenter,

This serial adds support for new AMD family 15h processor
(Models 70-7f) and maintainer info updates.

For accumulated power feature:
http://marc.info/?l=linux-kernel&m4633156632674&w=2
http://marc.info/?l=linux-kernel&m4619918504720&w=2

For the patch "x86, amd: add accessor for number of cores per compute
unit", I will send it with accumulated power perf support with
forthcoming. Then resend v4 of accumulated power hwmon support.
Refer: http://marc.info/?l=linux-kernel&m4103718130563&w=2

So can you apply these two patches to hwmon-next firstly?

Thanks,
Rui

Huang Rui (2):
  hwmon: (fam15h_power) Add support for AMD new 15h processors
  MAINTAINERS: change the maintainer of fam15h_power driver

 CREDITS                      | 8 ++++++++
 MAINTAINERS                  | 4 ++--
 drivers/hwmon/fam15h_power.c | 7 +++++--
 3 files changed, 15 insertions(+), 4 deletions(-)

-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
