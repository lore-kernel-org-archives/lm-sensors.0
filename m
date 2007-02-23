From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Fri, 23 Feb 2007 08:08:30 +0000
Subject: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Message-Id: <45DEA0FE.7020601@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <45D5EA88.7090300@redhat.com>
In-Reply-To: <45D5EA88.7090300@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Fri, 23 Feb 2007 08:13:30 +0100, Hans de Goede wrote:
>> I'm thinking that it might be an idea to also use this idea of udev autoloading 
>> through DMI info for the abituguru and abituguru3 driver (review please). The 
>> both only support about 12 motherboards. For the abituguru driver, dmi info 
>> could also be used to automatically set the module options needed on the 2 
>> oldest uguru featuring abit motherboards. What do you think about this?
> 
> Given that the uguru chips are hard (impossible) to detect and only a
> small number of boards need it, yes, I think it's a good idea.
> 

<snipping CC-list down a bit>

I'm glad you like it, but how does this relate to using dmi info in 
sensors-detect, if we add that capability to sensors-detect and add a database 
with known motherboards and there configs, then that would be a doublure with 
having the info in the drivers, this is the main reason why I hesitate.

Regards,

Hans



