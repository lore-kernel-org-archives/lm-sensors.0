From: "J, KEERTHY" <j-keerthy@ti.com>
Date: Tue, 23 Aug 2011 06:54:49 +0000
Subject: Re: [lm-sensors] [RFC PATCH 6/6] hwmon: OMAP4: On die temperature
Message-Id: <CAJ6a13ZbstOQ6n76i7+tUEmAvVDpeOOweQUN5irr_AUbcn9S0A@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1312979122-5896-1-git-send-email-j-keerthy@ti.com>
	<1312979122-5896-7-git-send-email-j-keerthy@ti.com>
	<20110810124629.GJ12882@legolas.emea.dhcp.ti.com>
	<CAJ6a13Z=u=exWUHLotw8jpHMv-hKpE+fvg_1hq7=gtMiuJKxOA@mail.gmail.com>
	<20110811103658.GG27742@legolas.emea.dhcp.ti.com>
	<CAJ6a13bxg8po-Csc10LsFH-oES4YOKkqFoTm3kG4XzS=b2boMw@mail.gmail.com>
	<20110811141248.GK28500@legolas.emea.dhcp.ti.com>
	<CAJ6a13b7qu3K4YJPTYych_NQxLuuUxZOQg6PPC_=XA+qiwn2RA@mail.gmail.com>
	<20110811185408.GB15970@legolas.emea.dhcp.ti.com>
	<20110811185558.GC15970@legolas.emea.dhcp.ti.com>
	<4E444B8F.9060908@ti.com>
	<4E449D65.9000004@ti.com>
	<874o19gfrr.fsf@ti.com>
	<4E532A28.60103@ti.com>
In-Reply-To: <4E532A28.60103@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Rajendra Nayak <rnayak@ti.com>, Kevin Hilman <khilman@ti.com>
Cc: Roger Quadros <rogerq@ti.com>, balbi@ti.com, Tony Lindgren <tony@atomide.com>, lm-sensors@lm-sensors.org, vishwanath.bs@ti.com, linux-omap@vger.kernel.org, b-cousson@ti.com, Russell King <linux@arm.linux.org.uk>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, khali@linux-fr.org, guenter.roeck@ericsson.com

On Tue, Aug 23, 2011 at 9:48 AM, Rajendra Nayak <rnayak@ti.com> wrote:
> On 8/23/2011 5:28 AM, Kevin Hilman wrote:
>>
>> Rajendra Nayak<rnayak@ti.com> =A0writes:
>>
>> [...]
>>
>>> FWIK, its a one time requirement to set the clock rate to the
>>> right rate the device can operate in based on what a platform
>>> supports.
>>
>> Except $SUBJECT patch hard-codes the clock rate for all platforms in the
>> driver.
>
> The device has a requirement to operate in a 1Mhz to 2Mhz range. So the
> driver is using a clk_round_rate() to get the closest rate supported and
> sets it using a clk_set_rate().
>
>>
>> If the clock rate is to be platform-specific, it should be done in
>> platform-specific code.
>
> I am fine if this needs to be moved to platform-specific code, but I
> wasn't quite sure this needs to be done in clock framework as was
> suggested.

The range can be (ex: 1MHz to 2Mhz) can be sent via pdata
as max and min frequencies and the driver can round the rate
to get the appropriate rate inside the specified range? Is this approach
Fine?

>
>>
>> Kevin
>
>



--=20
Regards and Thanks,
Keerthy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
