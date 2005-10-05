From: xanni@glasswings.com.au (Andrew Pam)
Date: Wed, 05 Oct 2005 18:48:59 +0000
Subject: [lm-sensors] Myson MTP008 driver ported to 2.6 kernel
Message-Id: <20051005164810.GV7167@kira.glasswings.com.au>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051004125511.GI7154@kira.glasswings.com.au>
In-Reply-To: <20051004125511.GI7154@kira.glasswings.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Oct 05, 2005 at 05:12:12PM +0200, Jean Delvare wrote:
> > #define SENS_FROM_REG(val)	((val) = 0 ? 0	: ((val) ^ 0x03))
> > #define SENS_TO_REG(val)	SENS_FROM_REG(val)
> 
> This looks like a trick. Don't use tricks. You're really not saving
> anything, but are increasing the chances that a bug sneaks in.

OK, these are two alternatives:

#define SENS_FROM_REG(val)	((val) = 0 ? 0	: (1 - (val - 1)) + 1)

#define SENS_FROM_REG(val)	((val) = 0 ? 0	: (val) = 1 ? 2 : 1)

Do you really find either of these more readable?  I don't.
This code is also clearly commented:

/* sysfs temperature sensor types       mtp008 sensor types
 * 0: Not defined                       0: Analog input (voltage)
 * 1: PII/Celeron Diode                 2: PII Diode
 * 2: 3904 transistor                   1: Thermistor

Regards,
	Andrew
-- 
mailto:xanni@xanadu.net                         Andrew Pam
http://www.xanadu.com.au/                       Chief Scientist, Xanadu
http://www.glasswings.com.au/                   Partner, Glass Wings
http://www.sericyb.com.au/                      Manager, Serious Cybernetics
