From: Michel Filipe <michel@milk-it.net>
Date: Fri, 22 Aug 2008 04:47:13 +0000
Subject: Re: [lm-sensors] acpitz-virtual
Message-Id: <200808220147.13216.michel@milk-it.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200808201620.23166.michel@milk-it.net>
In-Reply-To: <200808201620.23166.michel@milk-it.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Felipe,
>
> Please keep the mailing list Cc'd.
Sorry.
>
> On Wed, 20 Aug 2008 17:18:55 -0300, Michel Filipe wrote:
> > Jean Delvare wrote:
> > > We could probably update the code so that the labels default to the
> > > ACPI thermal zone names. Sometimes these names are useful... but
> > > sometimes not.
>
> After discussion with the ACPI people, it's not worth the effort, as
> ACPI thermal zone names are usually meaningless.
>
> > Hum... How do I do to get the ACPI thermal zone names?
>
> Look in /sys/class/thermal/thermal_zone*/device/path. The last item of
> the path is the device name. But as said above, these are 4-digit names
> for ACPI internal use, usually not meaningful enough for humans.

Ok, thank you so much! :)
-- 
Michel Filipe
Milk-it Software House
http://www.milk-it.net
+55 31 32271009
+55 31 84843953

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
