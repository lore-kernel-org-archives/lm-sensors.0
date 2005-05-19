From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:08 +0000
Subject: Ticket #1351
Message-Id: <20030730191000.5234d8a9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030730164316.M47742@bandos.homelinux.com>
In-Reply-To: <20030730164316.M47742@bandos.homelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Since you ask in ticket 1350 if the user had enabled acpi in the
> kernel, and referenced 1351 to 1350, I just wanted to inform I am
> using acpi (latest patch), and have it enabled on the kernel. But that
> didn't change when I switched from i2c/lm_sensors 2.7.0 to 2.8.0.

Did the kernel version change?

> Btw,
> expanding ticket 1351, in 2.7.0, adm1021 worked using the isa bus, now
> it doesn't seem to work even with i2c-isa loaded.

I think you missed something, since adm1021 is an I2C-only chip, so it
is in no way related to i2c-isa.

Thanks for the information.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
