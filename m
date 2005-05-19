From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:11 +0000
Subject: Support question:  segault in sensors
Message-Id: <20040812222710.3a5d494e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <013901c480a8$af2fc120$4400000a@phil>
In-Reply-To: <013901c480a8$af2fc120$4400000a@phil>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I am running Linux 2.4.17 with lm_sensors 2.8.7
> (...)
> Everything works properly until I exec sensors -s, when I get a
> segfault.

I2c modules versions mismatch. Same as tickets 1741 and 1750.
Check versions with dmesg after you loaded the modules.

Please explain how you installed your kernel, i2c and lm_sensors, and
I'll tell you were you failed.

At any rate, mixing such an old kernel with such a recent lm_sensors is
not recommended.

Oh, and would you please avoid ASCII art (or actually non-ASCII art,
which is even worse) in your "From:" field. This is a mailing-list, not
#warlordz.

Thanks.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
