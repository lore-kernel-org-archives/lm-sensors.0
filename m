From: r.marek@assembler.cz (Rudolf Marek)
Date: Sat, 17 Feb 2007 10:49:50 +0000
Subject: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Message-Id: <45D6DDCE.5050803@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <45D5EA88.7090300@redhat.com>
In-Reply-To: <45D5EA88.7090300@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chuck Ebbert <cebbert@redhat.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

Hello Chuck,

I'm the author of K8temp. Please can you share with us your DSDT table?
(cat /proc/acpi/dsdt > /tmp/dsdt.bin)

> So, could ACPI and the k8temp driver be at odds?

Yes because ACPI AML code has no synchronization with Linux drivers. Second
reason is that ACPI AML code assign resource regions to itself but with cleared
busy flag - so other drivers could bind and might possibly interfere  with ACPI.

This is very long term problem, I already proposed some possible solutions to
this problem
(http://lists.lm-sensors.org/pipermail/lm-sensors/2007-February/018788.html)

There are some ideas, but none is implemented yet. As you already wrote, best
solution is to stop using k8temp driver.

I will check the DSDT table to confirm this fact.

Thanks,
Rudolf

