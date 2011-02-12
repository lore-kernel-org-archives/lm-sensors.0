From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 12 Feb 2011 15:48:48 +0000
Subject: Re: [lm-sensors] [PATCH v3 7/7] hwmon: (w83627ehf) Use 16 bit fan
Message-Id: <20110212154848.GA8994@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1297444832-10874-8-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1297444832-10874-8-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Feb 12, 2011 at 08:53:51AM -0500, Andrew Lutomirski wrote:
[ ...]
> 
> With fan2_div = 32 (b/c fan2_min = 502), I get:
> 
> [48429.734521] w83627ehf: Found NCT6775F chip at 0x290
> [48429.734818] Reg 0028 = 47
> [48429.734832] Reg 0029 = 00
> [48429.734843] Reg 002a = 00
> [48429.734855] Reg 003f = 00
> [48429.734884] Reg 0630 = 0047
> [48429.734905] Reg 0631 = 4700
> [48429.734925] Reg 0632 = 0000
> [48429.734945] Reg 0633 = 0000
> [48429.734965] Reg 0634 = 0000
> [48429.734986] Reg 0635 = 0000
> [48429.735006] Reg 0636 = 0000
> [48429.735026] Reg 0637 = 0000
> [48437.765900] nr=1, fan=0, fan_div=4, fan_from_reg=0  <<< reading fan2_input
> 
> With fan2_min = 100 (i.e. fan2_div = 128) I get:
> 
> [48525.613069] w83627ehf: Found NCT6775F chip at 0x290
> [48525.613686] Reg 0028 = 47
> [48525.613698] Reg 0029 = 4c
> [48525.613708] Reg 002a = 00
> [48525.613719] Reg 003f = 00
> [48525.613754] Reg 0630 = 0047
> [48525.613772] Reg 0631 = 4700
> [48525.613796] Reg 0632 = 004c
> [48525.613813] Reg 0633 = 4c00
> [48525.613829] Reg 0634 = 0000
> [48525.613846] Reg 0635 = 0000
> [48525.613863] Reg 0636 = 0000
> [48525.613880] Reg 0637 = 0000
> [48533.156472] nr=1, fanw, fan_div=7, fan_from_reg6
> 
> Maybe those 8 high bits just don't work?  Is there some flag to set to
> put the chip in 16-bit mode?
> 
16 bit mode is always active.

Register 0x29 and 0x632/0x0633 are in sync, though. What is odd is that 
the value is 0x0 in both registers when it should be 0xff or above.
This is a problem, because if it returns 0x0 in register 0x29 if the divisor
value is too low, we can not detect that it is too low, and the code
to automatically increase the divisor does not work.

Can you check what you get for other fan_min values, specifically for 200 ?
Also, can you check the return values of registers 0x656..0x65d ?
That should be the direct RPM values. Maybe we have to use the RPM registers
for the new chips instead of using the fan count.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
