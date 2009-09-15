From: Luca Tettamanti <kronos.it@gmail.com>
Date: Tue, 15 Sep 2009 19:10:48 +0000
Subject: Re: [lm-sensors] Asus ATK0110 ACPI driver and Asus P6T Deluxe
Message-Id: <68676e00909151210x8979364k77eeacba5d054a3e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200903101417.01449.clive@vacuumtube.org.uk>
In-Reply-To: <200903101417.01449.clive@vacuumtube.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Tue, Sep 15, 2009 at 8:58 PM, Tim Ryan <tryan@linux.com> wrote:
> Thanks for the reply, but it looks like I posted too soon. I upgraded
> to 3.1.1 and now I see the output:
>
> atk0110-acpi-0
> Adapter: ACPI interface
> Vcore Voltage:      +0.94 V  (min =  +0.80 V, max =  +1.60 V)
>  +3.3 Voltage:      +3.30 V  (min =  +2.97 V, max =  +3.63 V)
>  +5 Voltage:        +5.12 V  (min =  +4.50 V, max =  +5.50 V)
>  +12 Voltage:      +12.14 V  (min = +10.20 V, max = +13.80 V)
> CPU FAN Speed:     1721 RPM  (min =  600 RPM)
> CHASSIS1 FAN Speed:   0 RPM  (min =  600 RPM)
> CHASSIS2 FAN Speed:   0 RPM  (min =  600 RPM)
> POWER FAN Speed:      0 RPM  (min =    0 RPM)
> CPU Temperature:    +47.5 C  (high = +60.0 C, crit = +75.0 C)
> MB Temperature:     +45.0 C  (high = +45.0 C, crit = +75.0 C)
>
> So it works perfectly on an Asus P6T SE with the atk0110 driver.

Ok good.

>>> I load the module with no problem,
>>
>> Look at the output of dmesg; the driver is verbose when loading.
>
> By the way, dmesg doesn't show anything when I load the driver,

Ah, right. All the output is at debug level. Will fix this.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
