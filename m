From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Sat, 04 Jun 2005 09:31:43 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc5-mm2] pca9539: new i2c drvier
Message-Id: <253818670506040031c7d7dc4@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <F06EB2894F3F0D45AD9BEA7246DE9C9076C7D9@WCSEXCMBS1.ad.wabtec.com>
In-Reply-To: <F06EB2894F3F0D45AD9BEA7246DE9C9076C7D9@WCSEXCMBS1.ad.wabtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ben,

With respect to the sysfs attributes/callbacks much better :-), it
really cleans up the code using the new callbacks and initializing the
sensor device attributes as an attribute group. It also saves me or
others having to go through and try to clean things up later.

Thanks,
Yani
