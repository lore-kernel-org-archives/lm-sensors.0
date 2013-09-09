From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 09 Sep 2013 07:42:45 +0000
Subject: Re: [lm-sensors] [PATCH v4 0/3] Lm90 Enhancements
Message-Id: <20130909094245.4661d9cb@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1375856306-14415-1-git-send-email-wni@nvidia.com>
	<522D67B2.4030406@nvidia.com>
In-Reply-To: <522D67B2.4030406-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Wei,

I am sorry, I see there have been many discussions about the lm90
driver while I was on vacation and these are threads I did not have the
time to catch up with yet. I'll read it all as soon as possible by my
current schedule is tight so please be patient!

Jean

On Mon, 9 Sep 2013 14:16:18 +0800, Wei Ni wrote:
> Hi, Jean
> Do you have any more suggestions on this series?
> 
> Thanks.
> Wei.
> 
> On 08/07/2013 02:18 PM, Wei Ni wrote:
> > This patch set enhance the lm90 driver,
> > it make the driver more readable and easier to use thermal framework.
> > 
> > This series is v4, previous version patches:
> > [RFC]: http://thread.gmane.org/gmane.linux.power-management.general/31056
> > [v1]: http://thread.gmane.org/gmane.linux.ports.tegra/11710/
> > [v2]: http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg465555.html
> > [v3]: http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg466772.html
> > 
> > Changes from v3:
> > 1. remove the patch "hwmon: (lm90) split set&show temp as common codes",
> > and sent it as a separated one.
> > 2. fix the bug of second read on STATUS register.
> > 3. fix some code style issue according to Jean's comments.
> > 
> > Changes from v2:
> > 1. update the defines for status bit, and go into a separate patch.
> > 2. introduce the new lm90_is_tripped() for lm90_irq_thread and lm90_alert.
> > 
> > Changes from v1:
> > 1. change the string "irq" to "IRQ"
> > 2. add macro defines for the alarm status
> > 3. consider the shared IRQ.
> > 
> > Changes from RFC:
> > 1. change _show_temp() to read_temp(), _set_temp() to write_temp().
> > 2. simply return value for the read_temp(), not use pointer.
> > 3. use devm_request_threaded_irq() to request irq and set flag IRQF_ONESHOT.
> > 
> > Wei Ni (3):
> >   hwmon: (lm90) Define status bits
> >   hwmon: (lm90) add support to handle IRQ
> >   hwmon: (lm90) use enums for the indexes of temp8 and temp11
> > 
> >  drivers/hwmon/lm90.c |  252 ++++++++++++++++++++++++++++++++------------------
> >  1 file changed, 163 insertions(+), 89 deletions(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
