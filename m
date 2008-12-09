From: "David Hubbard" <david.c.hubbard@gmail.com>
Date: Tue, 09 Dec 2008 20:01:03 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Fix various typos
Message-Id: <4dfa50520812091201i14ea636eq7135a6a666d28364@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081209163734.683475cf@hyperion.delvare>
In-Reply-To: <20081209163734.683475cf@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

ack both patches (ACPI resources and typo fixes)

Signed-off-by: David Hubbard <david.c.hubbard@gmail.com>

P.S. I have found a bug in the way the init code in w83627ehf puts the
base address into the data structure, so it ends up accessing the
device at 0x290 when it should be 0x295. I'll send out a patch in a
few days.

On Tue, Dec 9, 2008 at 12:00 PM, Hans de Goede <j.w.r.degoede@hhs.nl> wrote:
> Jean Delvare wrote:
>> Signed-off-by: Jean Delvare <khali@linux-fr.org>
>> ---
>>  Documentation/hwmon/lm85  |    2 +-
>>  drivers/hwmon/it87.c      |    2 +-
>>  drivers/hwmon/w83627ehf.c |    2 +-
>>  3 files changed, 3 insertions(+), 3 deletions(-)
>>
>
> Looks good to me :)
>
> Regards,
>
> Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
