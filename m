From: Marco Chiappero <marco@absence.it>
Date: Sun, 07 Dec 2008 11:50:04 +0000
Subject: Re: [lm-sensors] New Asus board and multiple sensors chips
Message-Id: <493BB86C.9060109@absence.it>
List-Id: <lm-sensors.vger.kernel.org>
References: <48CA5C05.8040307@absence.it>
In-Reply-To: <48CA5C05.8040307@absence.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Luca Tettamanti ha scritto:
>> About the atk, it seems to work fine, but I haven't got the time to verify
>> the presence of strange issues, regarding for example suspend and/or
>> hibernate, stuff like that (does it matter?).
> The driver is stateless, so it shouldn't matter (testing won't harm though :P)

Good :)

>> I know that no fan control is possible with this driver, 
 >> [...]
> It's doable using the Q-FAN interface. You use the interface calling
> GITM/SITM with class 0x4 (see the documentation embedded in my
> driver). There are at least 3 different types of control in this
> class, you'll have to reverse engineer the exact calling interface
> (start with the getters).

Ok, I'll have a look as soon as I have some spare time.

>> One, last thing: I use to collect and plot system data with collectd and
>> rrdtool, but collectd seems to ignore the atk driver. I know, I should read
>> the code, however any idea for addressing this issue?
> I suppose that collectd is using the unpatched libsensor which ignores
> the ATK device (it's attached to the unknown ACPI bus).

Ok, many thanks for the driver and your help!

Waiting for it to be merged in the upstream kernel.

Regards,
Marco

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
