From: ymu@winbond.com (Yuan Mu)
Date: Fri, 30 Jun 2006 10:49:09 +0000
Subject: [lm-sensors] nvidia nforce410 chipset / ASUS K8N-VM
Message-Id: <44A501A5.7090701@winbond.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <44A326F3.3070300@winbond.com>
In-Reply-To: <44A326F3.3070300@winbond.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Daan Willems wrote:
> I've tried the patch on a plain 2.6.17.1 vanilla kernel, but using the 
> newbuilt module still doesn't show me the voltages. However on building 
> the module with the patch applied I get the following message:
> 
> WARNING: drivers/acpi/processor.o - Section mismatch: reference to 
> .init.data: from .text between 'acpi_processor_power_init' (at offset 
> 0xf2f) and 'acpi_processor_cst_has_changed'

One possible reason is you need to install new lm_sensors2 user space tools.
If it is not this reason, i can not help you more :(
I still have no chance to try 2.6.17.1 kernel...

-- 
Best Regards
Yuan Mu


=============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.

