From: ymu@winbond.com (Yuan Mu)
Date: Mon, 03 Jul 2006 01:35:34 +0000
Subject: [lm-sensors] nvidia nforce410 chipset / ASUS
Message-Id: <44A87466.9020002@winbond.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean, Daan,

>> Daan Willems wrote:
>>> I've tried the patch on a plain 2.6.17.1 vanilla kernel, but using the 
>>> newbuilt module still doesn't show me the voltages. However on building 
>>> the module with the patch applied I get the following message:
>>>
>>> WARNING: drivers/acpi/processor.o - Section mismatch: reference to 
>>> .init.data: from .text between 'acpi_processor_power_init' (at offset 
>>> 0xf2f) and 'acpi_processor_cst_has_changed'
>> One possible reason is you need to install new lm_sensors2 user space tools.
>> If it is not this reason, i can not help you more :(
>> I still have no chance to try 2.6.17.1 kernel...
> 
> No, this is a completely unrelated warning. There's something wrong in
> the acpi code, the compiler warns about it since 2.6.17 (it was already
> wrong before, but the compiler wasn't taught to detect the mistake
> until recently.
> 
> So, Daan, you can ignore that warning safely. You would have the same
> warning without the patch. I have the warning too for quite some times
> now and nothing bad happened ;) Let's just hope the acpi people
> eventually show up and fix it, so that people stop being frightened!
> 
Hmm, sorry, i think i made a mistake that i have not snipped the "WARNING ..." part.
I know nothing about it at all ;)

And my reply is for "doesn't show the voltage after patch w83627ehf",
Jean, why it still can not show the voltages :(

-- 
Best Regards
Yuan Mu


=============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.

