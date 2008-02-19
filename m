From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 19 Feb 2008 10:19:08 +0000
Subject: Re: [lm-sensors] Preparing patches for pca9552, ad5259, and bq27350
Message-Id: <20080219111908.4085dfdd@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <FD2217BC-9A9C-4CFE-843F-15F1600B4CCE@codetastic.com>
In-Reply-To: <FD2217BC-9A9C-4CFE-843F-15F1600B4CCE@codetastic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 18 Feb 2008 23:51:59 -0800, Philip Pokorny wrote:
> There are several monitoring chips that monitor the CMOS battery
> voltage.  That's similar...

While I agree that battery monitoring drivers and hardware monitoring
drivers have some features in common (in particular measuring an input
voltage) I still believe that having separate subsystems for these,
with different sysfs interfaces, makes sense. The user needs are
different. The CMOS battery monitoring is only there to tell you when
you should change the battery. A "real" battery monitor OTOH will tell
you a lot more information on the battery, how much energy there is
left inside, how much time you have before the power runs out, how old
the battery is, how hot it is, etc. Using the hwmon standard sysfs
interface for this would probably put restrictions on what can be done.
This doesn't mean though that battery drivers can't additionally export
their sensor values as standard, read-only hwmon sysfs values (maybe
even using common code for all battery drivers) but I don't think that
this should be their primary interface.

Anyway, I didn't look deep enough into the power subsystem to make
myself a definitive opinion, so the above is really only a first
thought. I might be wrong.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
