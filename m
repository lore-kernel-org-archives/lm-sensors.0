From: ladis@linux-mips.org (Ladislav Michl)
Date: Thu, 19 May 2005 06:25:51 +0000
Subject: [PATCH] ds1337 4/4
Message-Id: <20050413194842.GA13177@orphique>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050407231904.GE27226@orphique> <FxPJVIPZ.1112958526.4787880.khali@localhost> <20050408123545.GA4961@orphique> <4256C315.3000902@katalix.com> <20050410195120.GA5422@linux-mips.org> <20050410231006.0469a472.khali@linux-fr.org> <425C0F2F.2000807@katalix.com> <20050413110413.GA30618@orphique> <425D6CDD.3000004@katalix.com>
In-Reply-To: <425D6CDD.3000004@katalix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Chapman <jchapman@katalix.com>
Cc: Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <sensors@Stimpy.netroedge.com>, Greg KH <greg@kroah.com>

On Wed, Apr 13, 2005 at 08:02:53PM +0100, James Chapman wrote:
> Ladislav Michl wrote:
[snip]
> >Patch bellow remove ds1337_do_command function and things needed by it.
> >I think device should be identified by bus and address as Jean said.
> >Please let me know if that fits your needs.
> 
> I think you misunderstood what I meant by "remove the 'id' thing" 
> (probably my fault). ds1337_do_command() is needed by ppc7d so don't 
> remove it. I meant remove the id parameter from the call and change the 
> ds1337 driver to support only one instance of the device.

No it is not your fault. I understood it perfectly but removed this
function because you should find your RTC on i2c bus then then do
something like:

if (rtc_client)
	rtc_client->driver->command(rtc_client, cmd, data);
else
	return -ENODEV;

and that should be done outside driver.

I do not think it is good idea to limit your driver to support only one
instance, because it is unecessary and there could exist some NUMA system
which could have one such RTC per node.

> >I'm assuming that you want to use drivers/char/genrtc.c to access ds1337
> >from userspace, but in arch/ppc/platforms/radstone_ppc7d.c 
> >ppc_md.get_rtc_time used by genrtc via get_rtc_time in asm-ppc/rtc.h
> >is set to NULL (same for set_rtc_time) and I didn't find where (if)
> >ds1337 registers to ppc_md.get_rtc_time.
> 
> For ppc at least, it's the platform code that hooks up get_rtc_time().
> Last time I looked in -mm, get_rtc_time() and set_rtc_time() were being 
> set up in ppc7d to use this driver. I won't be able to check until the 
> end of the week so please bear with me.

No problem, no patches will probably go in until SCM saga gets resolved :)

> >Functions in asm-ppc/rtc.h also do magic with tm_mon and tm_year
> >so this driver doesn't need to handle epoch separately and doesn't need
> >to be aware that tm_mon starts from zero...
> 
> I don't understand. What code in ds1337 is unneeded?

It's not about unneeded code. Other RTC drivers returns tm_year in range
0..199 and tm_mon in range 0..11. Your driver does it different way,
because it hooks directly to [gs]et_rtc_time functions.

I'm not sure what is right solution here. Personaly I'd make time format
compatible with other RTC drivers and do such tweaks in arch code when
calling command function.

[snip]
> >Remove nowhere referenced ds1337_do_command function. Apply after ds1337
> >patches 1-3.
> 
> Please don't apply this patch. I will modify the ds1337_do_command() API 
> to remove the "id" parameter and fixup ppc7d platform accordingly.

See above...

Best regards,
	ladis
