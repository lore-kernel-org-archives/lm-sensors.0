From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 27 Jun 2015 21:46:02 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (nct7802) add temperature sensor type attribute
Message-Id: <558F199A.3010509@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1435440850-18246-1-git-send-email-const@MakeLinux.com>
In-Reply-To: <1435440850-18246-1-git-send-email-const@MakeLinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Constantine Shulyupin <const@MakeLinux.com>, jdelvare@suse.de, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On 06/27/2015 02:34 PM, Constantine Shulyupin wrote:
> From: const <const@MakeLinux.com>
>
> 0, 3 - Temperature attributes are hidden
> 1 - Current mode
> 2 - Thermistor mode
>
> Reference:
> Nuvoton Hardware Monitoring IC NCT7802Y
> 7.2.32 Mode Selection Register
> Location : Index 22h
>
> Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>

Hi Constantine,

when resending a patch, please mark its version and provide a change log.
Remember that the patches are visible online forever, and without an
indication what changed no one will know the difference a year from now
with out version and change log.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
