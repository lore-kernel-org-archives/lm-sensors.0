From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 05 Oct 2005 21:46:45 +0000
Subject: [lm-sensors] Myson MTP008 driver ported to 2.6 kernel
Message-Id: <20051005214556.3b50a1ea.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051004125511.GI7154@kira.glasswings.com.au>
In-Reply-To: <20051004125511.GI7154@kira.glasswings.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andrew,

> On Wed, Oct 05, 2005 at 05:12:12PM +0200, Jean Delvare wrote:
> > > #define SENS_FROM_REG(val)	((val) = 0 ? 0	: ((val) ^ 0x03))
> > > #define SENS_TO_REG(val)	SENS_FROM_REG(val)
> > 
> > This looks like a trick. Don't use tricks. You're really not saving
> > anything, but are increasing the chances that a bug sneaks in.
> 
> OK, these are two alternatives:
> 
> #define SENS_FROM_REG(val)	((val) = 0 ? 0	: (1 - (val - 1)) + 1)
> 
> #define SENS_FROM_REG(val)	((val) = 0 ? 0	: (val) = 1 ? 2 : 1)
> 
> Do you really find either of these more readable?  I don't.

I tend to prefer the second one, a matter of personnal taste I presume.
But actually, it would probably be much better to simply not use macros
for these conversions. This would certainly result in more readable and
more efficient code.

> This code is also clearly commented:
> 
> /* sysfs temperature sensor types       mtp008 sensor types
>  * 0: Not defined                       0: Analog input (voltage)
>  * 1: PII/Celeron Diode                 2: PII Diode
>  * 2: 3904 transistor                   1: Thermistor

Thanks for documenting it, this is helpful. Now that I pay more
attention to this though, it doesn't look correct to me. In the
standard sysfs convention, thermisor is 3, not 2. So you should convert
MTP008's type 1 to 3, not 2. Additionally, note that using type 0 for
analog input is not totally conform to the sysfs standard. Type 0 means
that the temperature input it disabled and unused, *not* that it is
used for something different. This is the reason why I would prefer
that we trust the BIOS settings and don't allow pin function change at
runtime at all.

Anyway, this is just a suggestion, I leave the final decision to Helge
or anyone actually working on the code. As long as the code is correct,
fine with me.

Thanks,
-- 
Jean Delvare
