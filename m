From: lenb@kernel.org (Len Brown)
Date: Fri, 16 Feb 2007 17:57:23 +0000
Subject: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Message-Id: <200702161257.23684.lenb@kernel.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <45D5EA88.7090300@redhat.com>
In-Reply-To: <45D5EA88.7090300@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chuck Ebbert <cebbert@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org

On Friday 16 February 2007 12:31, Chuck Ebbert wrote:
> Recently my notebook has started shutting down with
> these messages in the logs:
> 
> 	ACPI: Critical trip point
> 	Critical temperature reached (128 C), shutting down.
> 
> But it didn't seem hot at all to me, so I wrote a script to
> cat /proc/acpi/thermal_zone/THRM/temperature once a second
> and eventually caught this (but no shutdown):
> 
> temperature:             47 C
> temperature:             47 C
> temperature:             128 C
> temperature:             48 C
> temperature:             47 C
> 
> Google found several people reporting problems like mine
> after installing lm-sensors, and when I looked at the list
> of loaded modules I found k8temp and hwmon there. Then I
> realized my problems had started after installing a 2.6.19
> kernel that had the new k8temp driver.
> 
> So, could ACPI and the k8temp driver be at odds?


Yes.
-Len

