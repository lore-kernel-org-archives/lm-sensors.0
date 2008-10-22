From: Matthew Garrett <mjg59@srcf.ucam.org>
Date: Wed, 22 Oct 2008 19:01:18 +0000
Subject: Re: [lm-sensors] Using hwmon in-kernel
Message-Id: <20081022190118.GA25363@srcf.ucam.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081008003041.GA20169@srcf.ucam.org>
In-Reply-To: <20081008003041.GA20169@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Oct 22, 2008 at 11:48:32AM -0700, Trent Piepho wrote:

> Then you could just call sysfs_show_attribute(hwmondev, "temp2_input", buf) or
> whatever and get the value in the kernel.  It would would with all drivers
> without adding a code to them.

Mnf. I'm not convinced general kernel upstream would be enthusiastic.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
