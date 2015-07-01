From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 01 Jul 2015 14:34:19 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: (nct7802) add temperature sensor type attribute
Message-Id: <5593FA6B.6060703@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1435733543-21290-1-git-send-email-const@MakeLinux.com>
In-Reply-To: <1435733543-21290-1-git-send-email-const@MakeLinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Constantine Shulyupin <const@MakeLinux.com>, jdelvare@suse.de, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Hi Constantine,

On 06/30/2015 11:52 PM, Constantine Shulyupin wrote:
> From: const <const@MakeLinux.com>
>
You don't need the above, since the patch is from yourself.
It only screws up the commit log (showing the author as "const").
No problem, I dropped it, just keep it in mind for later.

> Sensor type:
> 3 diode (current mode), MD=1
> 4 thermistor, MD=2
>
> Reference:
> Nuvoton Hardware Monitoring IC NCT7802Y
> 7.2.32 Mode Selection Register
> Location : Index 22h
>
> Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>

Applied to -next.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
