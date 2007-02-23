From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 23 Feb 2007 07:47:12 +0000
Subject: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Message-Id: <20070223084712.717a0ee4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <45D5EA88.7090300@redhat.com>
	<45D6DDCE.5050803@assembler.cz>
	<45D7461A.2040808@redhat.com>
	<45D8D6AE.3000204@assembler.cz>
	<45DB0EEA.2010205@redhat.com>
	<20070220191142.GE16614@redhat.com>
	<20070221171737.b6592104.khali@linux-fr.org>
	<20070221173740.GD19851@redhat.com>
	<20070221201944.GD13794@redhat.com>
	<20070222173711.9364695b.khali@linux-fr.org>
	<45DE941A.1070306@hhs.nl>
In-Reply-To: <45DE941A.1070306@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <j.w.r.degoede@hhs.nl>
Cc: Dave Jones <davej@redhat.com>, linux-acpi@vger.kernel.org, notting@redhat.com, linux-kernel <linux-kernel@vger.kernel.org>, Chuck Ebbert <cebbert@redhat.com>, lm-sensors@lm-sensors.org

On Fri, 23 Feb 2007 08:13:30 +0100, Hans de Goede wrote:
> I'm thinking that it might be an idea to also use this idea of udev autoloading 
> through DMI info for the abituguru and abituguru3 driver (review please). The 
> both only support about 12 motherboards. For the abituguru driver, dmi info 
> could also be used to automatically set the module options needed on the 2 
> oldest uguru featuring abit motherboards. What do you think about this?

Given that the uguru chips are hard (impossible) to detect and only a
small number of boards need it, yes, I think it's a good idea.

-- 
Jean Delvare

