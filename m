From: cebbert@redhat.com (Chuck Ebbert)
Date: Fri, 16 Feb 2007 19:31:44 +0000
Subject: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Message-Id: <45D606A0.5020606@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <45D5EA88.7090300@redhat.com> <p73odntg9ga.fsf@bingen.suse.de>
In-Reply-To: <p73odntg9ga.fsf@bingen.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org

Andi Kleen wrote:
> Chuck Ebbert <cebbert at redhat.com> writes:
>> So, could ACPI and the k8temp driver be at odds?
> 
> Yes, there is no locking between ACPI and Linux drivers for register access.
> e.g. if there is a indexed register both try to access (and temperature
> sensors tend to use these things) they can race and get corrupted data.

I blacklisted the k8temp driver and everything looks OK now.


