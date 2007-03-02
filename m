From: mjg59@srcf.ucam.org (Matthew Garrett)
Date: Fri, 02 Mar 2007 11:43:26 +0000
Subject: [lm-sensors] Conversion of ACPI fan+thermal to hwmon sysfs
Message-Id: <20070302114326.GA1212@srcf.ucam.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070224182024.GA23865@khazad-dum.debian.net> <20070226172716.b2e956b7.khali@linux-fr.org> <1172655111.11100.50.camel@localhost.localdomain> <20070228143433.GB30168@khazad-dum.debian.net> <1172797936.14827.33.camel@localhost.localdomain> <20070302121304.9db20131.khali@linux-fr.org>
In-Reply-To: <20070302121304.9db20131.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org, lenb@kernel.org, konstantin.a.karasyov@intel.com

On Fri, Mar 02, 2007 at 12:13:04PM +0100, Jean Delvare wrote:

> As I don't know what these "cooling mode policies" are, I can't really
> tell. Trip points in hwmon let the user define the desired fan speed
> depending on a temperature measurement, and that's about it. You can't
> associate other actions at the moment, essentially because hardware
> monitoring chips themselves can't do anything else. If it would be
> convenient for the ACPI case to add something else, we can discuss
> additional interface files.

ACPI cooling mode policies may be related to fans, but can also be 
associated with passive cooling of the CPU by throttling or voltage 
scaling. Some machines keep the fan under BIOS control, so the only 
information exposed via the thermal module will be something like:

critical (S5):           95 C
passive:                 91 C: tc1=5 tc2=4 tsp`0 devices=0xc16dd310 

indicating that the CPU should be throttled at 91C, and the system 
forcibly shut down at 95C. 

> My original idea was to simply add a read-only hwmon-like interface to
> the acpi fan and thermal modules. I didn't plan to replace the current
> interfaces offered by these modules, at least not directly. There must
> be many user-space tools and scripts relying on these at the moment, so
> we need a transition period anyway.

That doesn't sound like a bad plan.

-- 
Matthew Garrett | mjg59 at srcf.ucam.org

