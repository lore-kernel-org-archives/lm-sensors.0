From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: ASUS P4C800 Deluxe - W83627THF
Message-Id: <3F51311C.8040507@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1062239759.1074.30.camel@hansi>
In-Reply-To: <1062239759.1074.30.camel@hansi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

thanks for the info.
As you saw, we've already added support for the ICH5 in 2.8.0.
The w83627hf driver supports the thf as well, and we would
rather enhance the support there than in w83781d.c, which is hopelessly cluttered.
If you can give us a patch against CVS for that driver that would be most helpful.

Johann Glaser wrote:
> Hi!
> 
> A few weeks ago I bought an ASUS P4C800 Deluxe mainboard. It has a
> W83627THF chip.
> 
> Therefore I added the necessary details in the i2c-i801.c and w83781d.c.
> 
> Today I wanted to send you a diff but found out, that in the meantime a
> new lm-sensors version is available. So my diff is not accurate now.
> 
> Additionally you seperated the W83627 chips in another file. Since there
> are some incomplete parts regarding the W83627THF I'll send you my diff
> anyway. Hopefully some of the lines can help you. They have been taken
> agains a 2.7.0 version.
> 
> BTW: The W83627THF only has 6 voltage-sensors. The layout is as follows:
>   in0 ... Vcore
>   in1 ... +12V
>   in2 ... -3,3V
>   in3 ... +5V
>   in7 ... V5SB
>   in8 ... VBat
> 
> in2 and in8 can be displayed directly (3,3V). in7 and in3 have to be
> multiplied by 1,68. in1 needs a factor of 3,8. For in0 I don't know the
> factor. in4..in6 are not available.
> 
> Some info on fans:
>   fan2 = CPU
>   fan3 = Power Supply
> It seems that CPU fan has a default divisor of 2. This is too less, when
> the CPU is in idle mode. One has to set this value to 4.
> 
> Temperature Sensors:
>   temp1 ... Mainboard
>   temp2 ... CPU
> 
> Bye
>   Hansi
> 
> 
> 
