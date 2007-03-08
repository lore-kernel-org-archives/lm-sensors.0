From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Thu, 08 Mar 2007 11:13:51 +0000
Subject: [lm-sensors] Conversion of ACPI fan+thermal to hwmon sysfs
Message-Id: <45EFEFEF.50802@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070224182024.GA23865@khazad-dum.debian.net>	<20070226172716.b2e956b7.khali@linux-fr.org>	<1172655111.11100.50.camel@localhost.localdomain>	<20070228143433.GB30168@khazad-dum.debian.net>	<1172797936.14827.33.camel@localhost.localdomain>	<20070302121304.9db20131.khali@linux-fr.org> <1173346084.10227.136.camel@localhost.localdomain>
In-Reply-To: <1173346084.10227.136.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Zhang Rui <rui.zhang@intel.com>
Cc: Jean Delvare <khali@linux-fr.org>, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, lenb@kernel.org, trenn@suse.de, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, lm-sensors@lm-sensors.org

Zhang Rui wrote:
> On Fri, 2007-03-02 at 12:13 +0100, Jean Delvare wrote:
>> My original idea was to simply add a read-only hwmon-like interface to
>> the acpi fan and thermal modules. I didn't plan to replace the current
>> interfaces offered by these modules, at least not directly. There must
>> be many user-space tools and scripts relying on these at the moment, so
>> we need a transition period anyway.
>>
> Agree.
> I've already finished the patch to duplicate ACPI procfs function in
> sysfs, i.e. export the similar information while in sysfs style. And I
> think this can make it not so painful for use-space tools and scripts to
> convert to sysfs interface.
> Oh, a _read-only_ interface? Then, it will be much easier.
> But what is it used for?
> 

For libsensors using applications like sensors, gkrellm and ksensors to display 
temp and fan info?

Regards,

Hans


