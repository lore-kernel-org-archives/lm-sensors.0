From: "Markus Rechberger" <mrechberger@gmail.com>
Date: Sat, 01 Nov 2008 17:11:26 +0000
Subject: Re: [lm-sensors] ACPI reads wrong temperature after loading
Message-Id: <d9def9db0811011011v5b7715f9n778c9b887a95154d@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081101103904.7ea43d94@hyperion.delvare>
In-Reply-To: <20081101103904.7ea43d94@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Nov 1, 2008 at 5:14 PM, Jean Delvare <khali@linux-fr.org> wrote:
> On Sat, 1 Nov 2008 16:28:40 +0100, Markus Rechberger wrote:
>> On Sat, Nov 1, 2008 at 10:39 AM, Jean Delvare <khali@linux-fr.org> wrote:
>> > It would help if I could see the source code of module em28xx_cx25843,
>> > but unfortunately I have no idea where that driver lives. Markus?
>>
>> http://mcentral.de/hg/~mrec/em28xx-new/file/ca209b1d4076/cx25843/em28xx-cx25843.c
>
> This driver only attaches to (7-bit) address 0x44, while the lm90
> driver probes for devices at 0x4c and 0x4d. So I have to admit I am
> surprised that loading both drivers leads to the same result.
>

is there some debug that can be enabled in the i2c framework which
might help you forward?


> One note about the em28xx-cx25843 driver: it doesn't check for the
> right i2c adapter functionality flags. The driver makes use of raw I2C
> transactions to read from and write to the device, so it should check
> for I2C_FUNC_I2C, but instead of that I see the following code:
>
>   566  /* Check if the adapter supports the needed features */
>   567  if (!i2c_check_functionality
>   568                  (adapter,
>   569                   I2C_FUNC_SMBUS_READ_BYTE |
>   570                   I2C_FUNC_SMBUS_WRITE_BYTE_DATA))
>   571          return 0;
>
> This is incorrect and should be fixed.
>
> Another thing that should be fixed in this driver is the use of a
> "template" i2c_client. This is inefficient in terms of performance,
> disk space and memory so it should be avoided. Just setting fields
> individually is much better.
>

thanks for the hints, I'll adapt it within the next days.

Markus

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
