From: andi@firstfloor.org (Andi Kleen)
Date: Fri, 16 Feb 2007 19:59:33 +0000
Subject: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Message-Id: <p73odntg9ga.fsf@bingen.suse.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <45D5EA88.7090300@redhat.com>
In-Reply-To: <45D5EA88.7090300@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chuck Ebbert <cebbert@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org

Chuck Ebbert <cebbert at redhat.com> writes:
> 
> So, could ACPI and the k8temp driver be at odds?

Yes, there is no locking between ACPI and Linux drivers for register access.
e.g. if there is a indexed register both try to access (and temperature
sensors tend to use these things) they can race and get corrupted data.

-Andi

