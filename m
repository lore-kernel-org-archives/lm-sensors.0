From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 22 Feb 2007 16:37:11 +0000
Subject: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Message-Id: <20070222173711.9364695b.khali@linux-fr.org>
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
In-Reply-To: <20070221201944.GD13794@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Jones <davej@redhat.com>
Cc: Chuck Ebbert <cebbert@redhat.com>, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, notting@redhat.com

On Wed, 21 Feb 2007 15:19:44 -0500, Dave Jones wrote:
> Ah, Fedora has this horror in its initscripts (which explains why I missed
> it in my grep)..
> 
> # Initialize ACPI bits
> if [ -d /proc/acpi ]; then
>     for module in /lib/modules/$unamer/kernel/drivers/acpi/* ; do
>         module=${module##*/}
>         module=${module%.ko}
>         modprobe $module >/dev/null 2>&1
>     done
> fi

Ah, this also explains why the i2c_ec and sbs drivers were loaded on
Chuck's system, although they were not needed.

> This is there because there's no clean way for userspace to know whether
> to load the system specific stuff right now.   Bill Nottingham pointed
> out that we could add a /sys/class/dmi/modalias and appropriate MODULE_DMI
> tags to the various modules like asus_acpi to make udev autoload them.

Something similiar should be doable for i2c_ec, as it's only useful if a
given ACPI object is present. sbs, in turn, is only useful if i2c_ec is
loaded.

-- 
Jean Delvare

