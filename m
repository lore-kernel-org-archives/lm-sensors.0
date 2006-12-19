From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 19 Dec 2006 07:21:24 +0000
Subject: [lm-sensors] problem with i801
Message-Id: <20061219082124.5b3f7ef5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4586BC72.5080308@ctm.ulpgc.es>
In-Reply-To: <4586BC72.5080308@ctm.ulpgc.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 18 Dec 2006 16:06:10 +0000, Eduardo Suarez wrote:
> Everything compiled fine. Computer hangs when i try sensors -s.
> (...)
> Dec 18 13:33:40 dogbert eeprom 3-0050: Starting eeprom update, slice 0
> Dec 18 13:33:40 dogbert BUG: unable to handle kernel NULL pointer dereference at virtual address 00000000
> (...)
>     i2c-3       i2c             NVIDIA i2c adapter 2 at 1:00.0
>     i2c-2       i2c             NVIDIA i2c adapter 1 at 1:00.0
>     i2c-1       i2c             NVIDIA i2c adapter 0 at 1:00.0
>     i2c-0       smbus           SMBus I801 adapter at 10c0

I replied to you in ticket #2158 already. The crash is obviously
happening in the nvidia binary driver, so we can't help you. Go report
your problem to Nvidia.

-- 
Jean Delvare

