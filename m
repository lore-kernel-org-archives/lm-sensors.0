From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 30 Jun 2006 11:16:56 +0000
Subject: [lm-sensors] nvidia nforce410 chipset / ASUS K8N-VM
Message-Id: <20060630131656.1cc538b9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44A326F3.3070300@winbond.com>
In-Reply-To: <44A326F3.3070300@winbond.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Yuan, Daan,

> Daan Willems wrote:
> > I've tried the patch on a plain 2.6.17.1 vanilla kernel, but using the 
> > newbuilt module still doesn't show me the voltages. However on building 
> > the module with the patch applied I get the following message:
> > 
> > WARNING: drivers/acpi/processor.o - Section mismatch: reference to 
> > .init.data: from .text between 'acpi_processor_power_init' (at offset 
> > 0xf2f) and 'acpi_processor_cst_has_changed'
> 
> One possible reason is you need to install new lm_sensors2 user space tools.
> If it is not this reason, i can not help you more :(
> I still have no chance to try 2.6.17.1 kernel...

No, this is a completely unrelated warning. There's something wrong in
the acpi code, the compiler warns about it since 2.6.17 (it was already
wrong before, but the compiler wasn't taught to detect the mistake
until recently.

So, Daan, you can ignore that warning safely. You would have the same
warning without the patch. I have the warning too for quite some times
now and nothing bad happened ;) Let's just hope the acpi people
eventually show up and fix it, so that people stop being frightened!

-- 
Jean Delvare

