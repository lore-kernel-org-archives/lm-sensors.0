From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 05 Jul 2007 16:54:23 +0000
Subject: Re: [lm-sensors] THMC50 and ADM1022 support for 2.6 kernel(improved)
Message-Id: <20070705185423.7f235175@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070701205003.71ae723b@hyperion.delvare>
In-Reply-To: <20070701205003.71ae723b@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Krzysztof,

On Wed, 04 Jul 2007 09:25:05 +0200, Krzysztof Helt wrote:
> According to docs, the THMC50 produces range between 0 and 2.5V.
> The residual voltage (0 value != 0 V) comes from the external
> power amplifier. There are 6 example designs of external power
> amplifier given in the THMC50's datasheet. Most of the are
> powered by 0 - 12V so they are usually unable to produce the full
> 0-12V swing (as amplifiers and transistors cannot give output up
> to power voltage limits). One design (the cheapest) is said to
> not give full voltage swing by design.  That's why they have the
> fan off bit - to be able to stop the fan.
> 
> One of designs is powered from +/-12V and this one certainly can
> produce true 0V output - in such case the 0 value would stop fan
> and the fan off pin may be left unconnected. As you can see, my
> driver writes 0 value into the fan speed register along with
> setting of the fan off bit  - to cover both cases.
> 
> The residual voltage is simple imperfection of analog parts
> outside the chip and the value of this voltage is as random as
> the choice of analog elements mounted on  motherboards (will vary
> with production batch change and type of elements e.g. change of
> supplier).
> 
> Summary: one knows that 0 value produces 0V at the chip pin and
> at the same time one knows it is not 0V at the fan pins in most
> of reference designs (hence the separate fan off bit). 

I see, thanks for the detailed explanation. Then I'm fine with your
implementation.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
