From: Fenghua Yu <fenghua.yu@intel.com>
Date: Thu, 22 Jul 2010 16:21:39 +0000
Subject: [lm-sensors] [PATCH 0/5] Package Level Thermal Control and Power
Message-Id: <20100722162139.GA21435@linux-os.sc.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <493994B35A117E4F832F97C4719C4C048CAE2760@orsmsx505.amr.corp.intel.com> <E87738D94A6AD54789B5B8D1BAEB06CC6FFEE9ABF3@azsmsx503.amr.corp.intel.com>
In-Reply-To: <E87738D94A6AD54789B5B8D1BAEB06CC6FFEE9ABF3@azsmsx503.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@linux.intel.com>, "Brown, Len" <len.brown@intel.com>, Chen Gong <gong.chen@linux.intel.com>, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, Huaxu Wan <huaxu.wan@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

The new MSRs PACKAGE_THERM_STATUS and PACKAGE_THERM_INTERRUPT and power limit
notification are published in Intel 64 and IA32 SDM and first implemented on
Intel Sandy Bridge platform. The following patch set supports the new features
in Linux kernel. 

PATCH 1/5: Enable package level thermal management and power limit notification
PATCH 2/5: Package level thermal hwmon driver
PATCH 3/5: Package level thermal throttling support
PATCH 4/5: Power limit notification support
PATCH 5/5: Package level thermal hwmon driver doc



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
