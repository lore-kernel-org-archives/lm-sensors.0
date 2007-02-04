From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 04 Feb 2007 17:43:08 +0000
Subject: [lm-sensors] DS75
Message-Id: <20070204184308.96b53030.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <45BDE148.7020108@pipstechnology.co.uk>
In-Reply-To: <45BDE148.7020108@pipstechnology.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alan,

On Mon, 29 Jan 2007 11:58:00 +0000, Alan Clucas wrote:
> We have a DS75 on a custom board, which is attached to a Compulab iGLX 
> AMD Geode based board - using the CS5536 and an unmodified scx200_acb 
> driver to access the smbus/i2c.
> 
> On this board is a DS75. It doesn't identify as the chip correctly with 
> the lm75 driver in 2.6.19.2 due to the fact that it seems to return the 
> last value read for all of its out of spec commands, rather than doing 
> the address cycling which the driver expects for command >8 - e.g. 
> address 8 behaves like addresses 4 through 7. (I can provide a debug log 
> showing this if needed).

Yes, I'd appreciate a debug log and/or output of i2cdump for a Dallas
DS75 chip.

> With the following patch it identifies correctly and works as expected.
> 
> --- linux-2.6.19.2/drivers/hwmon/lm75.c 2007-01-24 16:03:42.000000000 +0000
> +++ linux/drivers/hwmon/lm75.c  2007-01-29 11:41:45.000000000 +0000
> @@ -181,13 +181,6 @@
>                  /* Unused bits */
>                  if (conf & 0xe0)
>                          goto exit_free;
> -
> -               /* Addresses cycling */
> -               for (i = 8; i < 0xff; i += 8)
> -                       if (i2c_smbus_read_byte_data(new_client, i + 1) 
> != conf
> -                        || i2c_smbus_read_word_data(new_client, i + 2) 
> != hyst
> -                        || i2c_smbus_read_word_data(new_client, i + 3) 
> != os)
> -                               goto exit_free;
>          }
> 
>          /* Determine the chip type - only one kind supported! */

Your email client is wrapping the long lines so I couldn't apply the
patch above even if I wanted.

I'm not fine with this approach anyway. I fear that plain dropping the
check above will again cause non-compatible chips to be attached to the
lm75 driver. I'd rather leave the LM75 detection code as is and add
code to explicitely detect the DS75, even though we can have both
kinds advertised as "lm75" for compatibility reasons. What do you think?

Can you use perl on your system? I'd like to add detection for the DS75
to sensors-detect first, and when it's ready, port the code to the lm75
driver.

Thanks,
-- 
Jean Delvare

