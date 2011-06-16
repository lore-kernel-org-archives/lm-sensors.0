From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 16 Jun 2011 18:54:13 +0000
Subject: Re: [lm-sensors] asus_atk0110 causes mouse and keyboard freeze in
Message-Id: <20110616205413.21294f6b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4CF7B282.10007@verizon.net>
In-Reply-To: <4CF7B282.10007@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 15 Jun 2011 17:25:08 +0200, Luca Tettamanti wrote:
> On Wed, Jun 15, 2011 at 2:13 PM, Luca Tettamanti <kronos.it@gmail.com> wrote:
> > On Wed, Jun 8, 2011 at 1:20 PM, Javier <javier@javispedro.com> wrote:
> >> 2011/6/8 Luca Tettamanti <kronos.it@gmail.com>:
> >>> I'll take a look ASAP (but this weekend I'll be AFK). Does your kernel
> >>> have ACPI_CUSTOM_METHOD enabled?
> >>
> >> No, but I can easily rebuild it (do not worry).
> >
> > Yes please, ACPI_CUSTOM_METHOD will be needed; I'm preparing a patched
> > version of the DSDT and the driver.
> 
> I'm attaching a patched version of the monitoring method.
> Boot the kernel with ACPI_CUSTOM_METHOD enabled and do *not* load
> asus_atk0110; load the override with:
> cat DSDT.aml > /sys/kernel/debug/acpi/custom_method
> If everything looks good then try asus_atk0110 and see if it's stable.
> If it still locks up the machine I'll have to try a different
> approach...

Note that the asus_atk0110 driver will autoload on most systems which
need it thanks to the module alias, so if you don't want this to
happen, you'll have to blacklist the driver
in /etc/modprobe.d/something.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
