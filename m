From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 11 Nov 2013 14:28:40 +0000
Subject: Re: [lm-sensors] Nuvoton NCT6791D support
Message-Id: <5280E998.4060002@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CADkjvt_edGO-+NKbsUbNwN=DXod10WTUYmfjRTrQfYq_2no2uw@mail.gmail.com>
In-Reply-To: <CADkjvt_edGO-+NKbsUbNwN=DXod10WTUYmfjRTrQfYq_2no2uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 11/10/2013 09:25 PM, p. stephen w wrote:
> Hey guys,
> I'd be happy to contribute $50 to get this chip supported via
> sensors-detect.  The weekends over, and I have not been able to get it
> installed as a stand alone driver from the GitHub repo.  I have some Apache
> experience, but am clueless about Linux; I'm running the latest Mint
> distro.   I'm sure there's a way, but I don't know it.
>

Hi Stephen,

Can you provide details ? Both sensors-detect and the upstream kernel (3.12)
support the chip, and the nct6775 driver on github should work as well.
If it doesn't, it might be useful to tell us what exactly doesn't work for you.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
