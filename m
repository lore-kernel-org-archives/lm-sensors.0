From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 01 May 2012 15:20:14 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: coretemp: fix oops on cpu unplug
Message-Id: <20120501152014.GA2629@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1335791881-1560-1-git-send-email-kirill.shutemov@linux.intel.com>
In-Reply-To: <1335791881-1560-1-git-send-email-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Andi Kleen <ak@linux.intel.com>, Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Apr 30, 2012 at 09:18:01AM -0400, Kirill A. Shutemov wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> coretemp tries to access core_data array beyond bounds on cpu unplug if
> core id of the cpu if more than NUM_REAL_CORES-1.
> 
[ ... ]
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Looking at it again, you were right. Adding the check to get_core_online()
doesn't really help as the platform device is per CPU, not per core.

Applied. I'll submit a separate patch to increase NUM_REAL_CORES.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
