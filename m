From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 26 May 2009 09:16:02 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/1] hwmon: Updated documentation on
Message-Id: <20090526111602.251b9b99@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <9EE81EBECB70824985BE0EDA8DC9B515021B3458@VIECLEX01.frequentis.frq>
In-Reply-To: <9EE81EBECB70824985BE0EDA8DC9B515021B3458@VIECLEX01.frequentis.frq>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 26 May 2009 11:01:26 +0200, Hans de Goede wrote:
> On 05/25/2009 10:15 PM, Engelmayer Christian wrote:
> > From: Christian Engelmayer<christian.engelmayer@frequentis.com>
> >
> > Added fan limit alarm 'max_alarm' to the alarm section.
> >
> 
> Looks good to me now,
> 
> Acked-by: Hans de Goede <hdegoede@redhat.com>

I've applied the patch now. Please note that I did have to edit it
manually so that it would apply. Christian, please fix/setup your
e-mail client so that it doesn't wrap long lines.

One thing I am curious about is how we can have fan[1-*]_max_alarm
while we do not have fan[1-*]_max according to our documentation. Some
drivers still seem to implement this feature (dme1737, adt7470,
applesmc) so we should document it, whoulsn't we?

But the max6650 driver, which is what Christian is working on, does not
have this feature, it doesn't even have fan1_min as far as I can see.
This makes me curious about what the fan1_max_alarm and fan1_min_alarm
flags are supposed to mean for the MAX6650/1 device? Apparently not what
Documentation/hwmon/sysfs-interface says... which would be kind of
problematic.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
