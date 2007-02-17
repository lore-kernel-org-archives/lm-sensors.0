From: cebbert@redhat.com (Chuck Ebbert)
Date: Sat, 17 Feb 2007 18:14:50 +0000
Subject: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Message-Id: <45D7461A.2040808@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <45D5EA88.7090300@redhat.com> <45D6DDCE.5050803@assembler.cz>
In-Reply-To: <45D6DDCE.5050803@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rudolf Marek <r.marek@assembler.cz>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org

Rudolf Marek wrote:
> Hello Chuck,
> 
> I'm the author of K8temp. Please can you share with us your DSDT table?
> (cat /proc/acpi/dsdt > /tmp/dsdt.bin)
> 

The system is Compaq Presario V2300 series notebook.  I won't be able
to get the DSDT until tomorrow or Monday.

>> So, could ACPI and the k8temp driver be at odds?
> 
> Yes because ACPI AML code has no synchronization with Linux drivers. Second
> reason is that ACPI AML code assign resource regions to itself but with cleared
> busy flag - so other drivers could bind and might possibly interfere  with ACPI.

Well I had an idea after looking at k8temp -- why not make it default to
doing only reads from the sensor?  You'd only get information from whatever
core/sensor combination that ACPI had last used, but it would be safe.



