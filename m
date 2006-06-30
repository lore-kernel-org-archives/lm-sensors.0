From: anything@daanwillems.nl (Daan Willems)
Date: Fri, 30 Jun 2006 06:20:54 +0000
Subject: [lm-sensors] nvidia nforce410 chipset / ASUS K8N-VM
Message-Id: <44A4C2C6.7060106@daanwillems.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <44A326F3.3070300@winbond.com>
In-Reply-To: <44A326F3.3070300@winbond.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I've tried the patch on a plain 2.6.17.1 vanilla kernel, but using the 
newbuilt module still doesn't show me the voltages. However on building 
the module with the patch applied I get the following message:

WARNING: drivers/acpi/processor.o - Section mismatch: reference to 
.init.data: from .text between 'acpi_processor_power_init' (at offset 
0xf2f) and 'acpi_processor_cst_has_changed'

Yuan Mu wrote:
> Daan Willems wrote:
>> Ok great! Will this patch apply to a vanilla 2.6.17.1 kernel?
>> Is it planned for a future update of the vanilla kernel?
>>
> I think it can apply to your kernel.
> Or you can waiting for 2.6.18-rc1 ;)
> 

