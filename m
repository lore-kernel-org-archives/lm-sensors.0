From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 28 Nov 2005 13:32:13 +0000
Subject: [lm-sensors] Kernel hangs with i2c-i801 driver?
Message-Id: <3lzMAnHa.1133181093.9467580.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051123100021.GA29473@oden.homeip.net>
In-Reply-To: <20051123100021.GA29473@oden.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Rudolf, Daniel,

On 2005-11-28, Rudolf Marek wrote:
> (...)Please can you provide the dump after cold boot and BEFORE loading
> the w83792d driver?
>
> i2cdump 0 0x2c

That's a very good idea, I guess we should have asked for that earlier.
This will let us check how the W83792D chip is configured on your board.
Let's just hope that the BIOS did initialize it properly.

> You may extend this from:
> 
> +	if ( val1 & 0x04 )
> +		device_create_file_fan(new_client, 7);
>
> add:
>
> - 	device_create_file_fan(new_client, 6);
> +	if ( val1 & 0x40 )
> +		device_create_file_fan(new_client, 6);
>
> Because fan6 and fan7 - mean their pins are programmable so correct would
> be to create their files when they actual outputs are really used for
> fans...

Same is true for fan4 and fan5 according to the datasheet, they can be
used as GPIO pins. Register to check is 0x1A, mask 0x40 for fan4 and
0x20 for fan5.

It would be great to have a patch for the w83792d driver in Linux 2.6
which fixes all these issues, so that Daniel can at least test a driver
with no known issuee. Yuan, sorry we are lagging behind about the
w83792d driver. I was taking care about the w83627hf because I'm more
familiar with it, and thought Rudolf would take care of the w83792d but
he's busy with his master thesis these days. If you can resubmit a
patch including all your previous fixes plus the fan4, fan5 and fan6
checks, I'll make sure to review it quickly. Not sure I'll be able to
get it into Linux 2.6.15 but we can try.

The "sensors" program will need to be modified not to complain about
missing fan4, fan5, fan6 and fan7 entries, as the Linux 2.6 driver will
no more always create them. This change should be trivial. Can anyone
send a patch?

Daniel, we are progressing but I still have no clear idea about what
exactly is causing the hang. One interesting test would be to try direct
SMBus writes without using the w83792d driver. If you can reproduce the
hang, then the w83792d driver is not faulty. If you cannot, they we
probably have a bug in the w83792d driver. This wouldn't be all that
surprising, the driver is relatively new and the chip is quite complex.

You can use the i2cset program to write to the W83792D chip directly. You
can try using the following commands in your script, without loading the
w83792d driver. Let us know if it hangs of not.

i2cset -y 0 0x2c 0x2b 0xff # in0_max
i2cset -y 0 0x2c 0x2c 0x00 # in0_min
i2cset -y 0 0x2c 0x2d 0xff # in1_max
i2cset -y 0 0x2c 0x2e 0x00 # in1_min
i2cset -y 0 0x2c 0x2f 0xff # in2_max
i2cset -y 0 0x2c 0x30 0x00 # in2_min
i2cset -y 0 0x2c 0x31 0xff # in3_max
i2cset -y 0 0x2c 0x32 0x00 # in3_min
i2cset -y 0 0x2c 0x33 0xff # in4_max
i2cset -y 0 0x2c 0x34 0x00 # in4_min
i2cset -y 0 0x2c 0x35 0xff # in5_max
i2cset -y 0 0x2c 0x36 0x00 # in5_min
i2cset -y 0 0x2c 0x37 0xff # in6_max
i2cset -y 0 0x2c 0x38 0x00 # in6_min
i2cset -y 0 0x2c 0xb4 0xff # in7_max
i2cset -y 0 0x2c 0xb5 0x00 # in7_min
i2cset -y 0 0x2c 0xb6 0xff # in8_max
i2cset -y 0 0x2c 0xb7 0x00 # in8_min
i2cset -y 0 0x2c 0x39 0x7f # temp1_max
i2cset -y 0 0x2c 0x3a 0x00 # temp1_min
i2cset -y 0 0x2c 0xc3 0x7c # temp2_max_hyst
i2cset -y 0 0x2c 0xc5 0x7f # temp2_max
i2cset -y 0 0x2c 0xcb 0x7c # temp3_max_hyst
i2cset -y 0 0x2c 0xcd 0x7f # temp3_max
i2cset -y 0 0x2c 0x3b 0xff # fan1_min
i2cset -y 0 0x2c 0x3c 0xff # fan2_min
i2cset -y 0 0x2c 0x3d 0xff # fan3_min
i2cset -y 0 0x2c 0xbb 0xff # fan4_min
i2cset -y 0 0x2c 0xbc 0xff # fan5_min
i2cset -y 0 0x2c 0xbd 0xff # fan6_min
i2cset -y 0 0x2c 0xbf 0xff # fan7_min

Thanks,
--
Jean Delvare
