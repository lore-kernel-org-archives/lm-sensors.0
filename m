From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Sat, 10 Mar 2007 21:57:46 +0000
Subject: [lm-sensors] PC8374L SuperIO chip
Message-Id: <45F329DA.5030608@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070310181650.33ed8ef7@beast>
In-Reply-To: <20070310181650.33ed8ef7@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Marcin DrStorm Sliwinski wrote:
> Hey
> Are there any chances for support for Winbond PC8374L chip ?
> I have it on my Intel D965G mainboard (name on chip: 8347lf2-c/l1). 
> It's SuperIO without internal sensors but with fan RPM measure and PWM
> It has also Sensorpath interface (single-wire sensors interface).
> Basic info can be found here:
> http://www.winbond-usa.com/mambo/content/view/305/528/
> http://www.national.com/nationaledge/jan04/article.html
> In attachment i've put sensors-detect log (lm-sensors-2.10.2)
> I was looking for some docs over the net but found only electric characteristics and pinout
> without any data about internal registers.
> I hope anyone will be able to code driver for this ;)

I've done some looking on the web for this too, and I have found a full 
datasheet:
http://www.winbond-usa.com/products/winbond_products/pdfs/APC/PC8374L.pdf

Writing a driver should be quite doable. My only concern is that this 
chip breathes acpi / tastes like acpi. It very much seems designed to 
make implementing acpi easy (thermal zones instead of sensors, etc).

So I'm afraid we might have some collisions with acpi here. Either way I 
would like to write a little userspace test program (for starters) to 
see if we can get some info out of the chip.

Regards,

Hans


