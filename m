From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 12 Aug 2014 21:47:29 +0000
Subject: Re: [lm-sensors] Nuvoton NCT5573D - Unsupported.  Any plans?
Message-Id: <53EA8B71.3010906@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1407868490.26207.YahooMailNeo@web181302.mail.ne1.yahoo.com>
In-Reply-To: <1407868490.26207.YahooMailNeo@web181302.mail.ne1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 08/12/2014 02:05 PM, Chris Kelly wrote:
> Here's the full detection listing:  (There is a Nuvoton chip detected (NCT6776F) but apparently this board has more than 1 Nuvoton on it?)
>

Please don't drop the list (they are interested in the answer as well),
and don't top-post.

> Do you want to scan for Super I/O sensors? (YES/no):
> Probing for Super-I/O at 0x2e/0x2f
> Trying family `National Semiconductor/ITE'...               No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Nuvoton/Fintek'...               Yes
> Found `Nuvoton NCT6776F Super IO Sensors'                   Success!
>      (address 0x290, driver `w83627ehf')

there is only one chip. The NCT5573D is supposedly compatible with NCT6776F,
and you hereby confirmed that. I updated the lm-sensors web page accordingly.

If your distribution includes the nct6775 driver, you might want to use it instead
of the w83627ehf driver.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
