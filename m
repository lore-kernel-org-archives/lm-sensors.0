From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 04 Jun 2005 13:36:41 +0000
Subject: [lm-sensors] RE: Fix one bug of w83792d under linux-2.4
Message-Id: <20050604133715.5accdff3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE54FCB2@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE54FCB2@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Chunhao,

> I use the "comparator mode" to temperature sensors instead of the
> original method, would you please commit my modification for me?
> The attachment is the patch to lm_sensors-2.9.1.

I finally took the time to review the changes that were made to the
Linux 2.4 w83792d driver. I can see you added alarm support for the
temperatures. This is a good thing to have, but I don't like your
implementation.

You use the Interrupt Status 1 register (41h) to find out the alarm
condition for the temperatures. For this to work, you have to set the
temperature interrupts to comparator mode. This changes the output of
the SMI#/IRQ pin, which may cause problem depending on the way the
W83792D chip was wired. Also, this method only works for the
temperatures.

OTOH, there are true alarm registers at registers 49h, 4Ah and 4Bh.
These show the realtime comparison result for all channels, not only the
temperatures. And these do not require to reconfigure the interrupt
mode for the temperatures.

So I would like you to modify your w83792d driver to use the 49h, 4Ah
and 4Bh registers for the alarms, and remove the interrupt mode change
as it won't be needed anymore. You will then have to modify the library
and the sensors program to use the new alarm bits.

Once this works for Linux 2.4, we'll of course want to do the same for
the Linux 2.6 driver.

Thanks,
-- 
Jean Delvare
