From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 16 Mar 2013 20:00:36 +0000
Subject: Re: [lm-sensors] Dell Inspiron 530 Chassis Fan Control?
Message-Id: <20130316210036.702f6b80@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130316175820.GA979@whitehail.bostoncoop.net>
In-Reply-To: <20130316175820.GA979@whitehail.bostoncoop.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Adam,

On Sat, 16 Mar 2013 14:26:50 -0400, Adam Rosi-Kessel wrote:
> On 3/16/2013 1:58 PM, Adam Rosi-Kessel wrote:
> > fancontrol/pwmconfig work for CPU fans with acpi_enforce_resources=lax
> > boot option, but I can't find any documentation as to how (if at all) to
> > control CPu fan. There is also nothing applicable in BIOS (using latest
> > release -- 2/24/09 1.0.18).
>
> Sorry -- typo above. It should say I can control *CPU* fans, but can't 
> find any documentation as to how to control the *chassis* fan.

This is a rather common issue, many boards out there allow to control
the CPU fan speed but not the other fan speeds.

That being said, in some cases the problem is a 3-wire fan plugged into
a 4-pin fan header. 4-pin headers have the fan speed control on the 4th
pin, so a 3-wire fan will always run at full speed. Check if this is
your case.

On my motherboard, all fan headers have 4 pins, but there is a jumper
to tell the board to treat the case fan headers as 3-pin. This is
rather rare though, most motherboards have it hard-wired.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
