From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 12 Jun 2012 15:18:13 +0000
Subject: Re: [lm-sensors] asus_atk0110 and Asus P8H61-M
Message-Id: <1339514293.2299.9.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <A9C6C2CE-B936-4600-8649-6F79007D2BE1@me.com>
In-Reply-To: <A9C6C2CE-B936-4600-8649-6F79007D2BE1@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2012-06-12 at 11:11 -0400, Luca Tettamanti wrote:
> On Mon, Jun 11, 2012 at 3:23 PM, John Keates <j.keates@me.com> wrote:
> > In that case, would it be worth it to try out the HECI interface to read sensors via Intel QST?
> 
> Maybe... I've seen the IME driver in staging, so I guess Intel is
> planning to do something with it.
> I don't know if it's already usable though.

Hi Luca,

last time I checked, it did not have an in-kernel API, and could thus
not be used for writing a hwmon driver without significant work. Would
be great if someone would pick that up, of course ...

Guenter

> > Or maybe find out how the Asus PC Probe2 reads the data?
> 
> No idea; older versions did use ACPI (my not-so-old M5A still has the
> ATK interface and the windows tool uses it).
> You could entertain yourself with a disassembler ;-)
> 
> > Because I've seen that app run on other systems @ windows,
> > and it does have realtime sensor output. Or is dat WMI based? Because if ASUS is moving away from atk0110, but still supplies
> > working probe apps, there must be another realtime interface.
> 
> I don't think it's WMI based, maybe they just access the sensor
> directly; if e.g. they know that the notification method (_L16) is
> never called after the boot then it's safe to do it.
> 
> Luca
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
