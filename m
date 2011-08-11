From: Matthew Garrett <mjg59@srcf.ucam.org>
Date: Thu, 11 Aug 2011 19:42:23 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] hwmon: Fix applesmc temperature
Message-Id: <20110811194223.GA30934@srcf.ucam.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1312906483-3046-2-git-send-email-mjg@redhat.com>
In-Reply-To: <1312906483-3046-2-git-send-email-mjg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Aug 11, 2011 at 09:36:22PM +0200, Henrik Rydberg wrote:
> instance, on some models, remove the battery and some temperature
> sensors will start to oscillate between zero and max. Some time ago, I
> tried to come up with a patch which would detect this behavior, so far
> without positive reports. If anything, it would make sense to filter
> the list of available sensors, either dynamically (removing it from
> the sysfs tree) or by clamping the value to zero or
> something. Reporting an error does not seem very useful.

We *know* that the value is incorrect. How is giving it to userspace 
without that information in any way helpful? Once userspace has opened 
the file and performed read(), we need to give it something.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
