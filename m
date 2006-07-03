From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 03 Jul 2006 12:05:07 +0000
Subject: [lm-sensors] nvidia nforce410 chipset / ASUS
Message-Id: <20060703140507.ae573552.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44A87466.9020002@winbond.com>
In-Reply-To: <44A87466.9020002@winbond.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Yuan, Daan,

> > > > I've tried the patch on a plain 2.6.17.1 vanilla kernel, but using the 
> > > > newbuilt module still doesn't show me the voltages. However on building 
> > > > the module with the patch applied I get the following message:
> > > >
> > > > WARNING: drivers/acpi/processor.o - Section mismatch: reference to 
> > > > .init.data: from .text between 'acpi_processor_power_init' (at offset 
> > > > 0xf2f) and 'acpi_processor_cst_has_changed'
> > > One possible reason is you need to install new lm_sensors2 user space tools.
> > > If it is not this reason, i can not help you more :(
> > > I still have no chance to try 2.6.17.1 kernel...
> > 
> > No, this is a completely unrelated warning. There's something wrong in
> > the acpi code, the compiler warns about it since 2.6.17 (it was already
> > wrong before, but the compiler wasn't taught to detect the mistake
> > until recently.
> > 
> > So, Daan, you can ignore that warning safely. You would have the same
> > warning without the patch. I have the warning too for quite some times
> > now and nothing bad happened ;) Let's just hope the acpi people
> > eventually show up and fix it, so that people stop being frightened!
>
> Hmm, sorry, i think i made a mistake that i have not snipped the "WARNING ..." part.
> I know nothing about it at all ;)
> 
> And my reply is for "doesn't show the voltage after patch w83627ehf",

Ah, my mistake, I missed _that_ part of Daan's anwser ;)

> Jean, why it still can not show the voltages :(

For "sensors" to display the voltages, Daan will need the SVN version
of lm_sensors. 2.10.0 didn't have support for them.

The easiest way to verify if the patch itself worked, is to check
manually in /sys/class/hwmon/hwmon0/device/. If you have the in* files,
it's OK, and you simply need a newer version of user-space. You can get
snapshots here:
  http://dl.lm-sensors.org/lm-sensors/snapshots/

-- 
Jean Delvare

