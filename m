From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 12 Nov 2013 14:20:50 +0000
Subject: Re: [lm-sensors] Nuvoton NCT6791D support
Message-Id: <52823942.2050305@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CADkjvt_edGO-+NKbsUbNwN=DXod10WTUYmfjRTrQfYq_2no2uw@mail.gmail.com>
In-Reply-To: <CADkjvt_edGO-+NKbsUbNwN=DXod10WTUYmfjRTrQfYq_2no2uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 11/11/2013 10:25 PM, p. stephen w wrote:
> Running sensors gives:
> nct6791-isa-0290
>
> Based on that the command becomes:
> Mint stephen # isadump -k 0x55,0x55 0x905 0x906
>
No, that should have been
	isadump -k 0x55,0x55 0x295 0x296

0x290 -> 0x295, 0x296

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
