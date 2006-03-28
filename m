From: bezaur@gmail.com (Charles Spirakis)
Date: Tue, 28 Mar 2006 04:02:57 +0000
Subject: [lm-sensors] [patch] hwmon: Add support for w83791d sensor chip
Message-Id: <5bfe43f80603272002l37c1e35ewa0214a7aae11f938@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5bfe43f80602141317i5e7e08d7q989e5d717598bd7d@mail.gmail.com>
In-Reply-To: <5bfe43f80602141317i5e7e08d7q989e5d717598bd7d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks! I'll start working on an updated patch.

I think I understand most of your issues, but I do have two questions:

1) Do you have an example of the SENSOR_ARRAY style? I grep'ed for
SENSOR_ARRAY in the 2.6.16 kernel and didn't see anything. Is this a
concept (i.e. use arrays) or specific macro/code? Is there sample code
you can point me to?

2) What did you mean by:

> +       /* Determine the chip type. */
> +       if (kind <= 0) {
> +               /* get vendor ID */
> +               val2 = w83791d_read(new_client, W83791D_REG_CHIPMAN);
> +               if (val2 != 0x5c) {     /* the vendor is NOT Winbond */
> +                       goto ERROR1;
> +               }
> +               val1 = w83791d_read(new_client, W83791D_REG_WCHIPID);
> +               if (val1 = 0x71 && address >= 0x2c) {
>
> Maybe you check the device adr and adr reg too


Do you mean the serial bus address register (index 0x48)? Don't I
already know the address of the device based on the reads that I'm
doing? Or are you saying I should confirm that the address register
has an address that matches the address of the reads that I'm doing?

-- charles

