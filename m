From: Henrik Rydberg <rydberg@euromail.se>
Date: Tue, 23 Sep 2008 21:34:54 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: applesmc: Add support for Macbook
Message-Id: <48D960FE.7000409@euromail.se>
List-Id: <lm-sensors.vger.kernel.org>
References: <48D927B3.5000207@euromail.se> <20080923133539.0146d940.akpm@linux-foundation.org>
In-Reply-To: <20080923133539.0146d940.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: nicolas@boichat.ch, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Tue, 23 Sep 2008 19:30:27 +0200
> Henrik Rydberg <rydberg@euromail.se> wrote:
> 
>> This patch adds temperature sensor support for Macbook Pro 3.
> 
> For some reason I keep on having to fix rejects in
> applesmc_whitelist[].
> 

I have also experienced that problem. Odd. Please see my comment below.

Thanks,
Henrik

-----

> Here's what I now have:
> 
> /* Note that DMI_MATCH(...,"MacBook") will match "MacBookPro1,1".
>  * So we need to put "Apple MacBook Pro" before "Apple MacBook". */
> static __initdata struct dmi_system_id applesmc_whitelist[] = {
> 	{ applesmc_dmi_match, "Apple MacBook Air", {
> 	  DMI_MATCH(DMI_BOARD_VENDOR, "Apple"),
> 	  DMI_MATCH(DMI_PRODUCT_NAME, "MacBookAir") },
> 		&applesmc_dmi_data[7]},
> 	{ applesmc_dmi_match, "Apple MacBook Pro 4", {
> 	  DMI_MATCH(DMI_BOARD_VENDOR, "Apple"),
> 	  DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro4") },
> 		&applesmc_dmi_data[8]},
> 	{ applesmc_dmi_match, "Apple MacBook Pro 3", {
> 	  DMI_MATCH(DMI_BOARD_VENDOR, "Apple"),
> 	  DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro3") },
> 		&applesmc_dmi_data[9]},

The two entries above are in reversed order in my tree, but
as you say, it does not matter.

> 	{ applesmc_dmi_match, "Apple MacBook Pro", {
> 	  DMI_MATCH(DMI_BOARD_VENDOR,"Apple"),
> 	  DMI_MATCH(DMI_PRODUCT_NAME,"MacBookPro") },
> 		&applesmc_dmi_data[0]},
> 	{ applesmc_dmi_match, "Apple MacBook (v2)", {
> 	  DMI_MATCH(DMI_BOARD_VENDOR,"Apple"),
> 	  DMI_MATCH(DMI_PRODUCT_NAME,"MacBook2") },
> 		&applesmc_dmi_data[1]},
> 	{ applesmc_dmi_match, "Apple MacBook (v3)", {
> 	  DMI_MATCH(DMI_BOARD_VENDOR,"Apple"),
> 	  DMI_MATCH(DMI_PRODUCT_NAME,"MacBook3") },
> 		&applesmc_dmi_data[6]},
> 	{ applesmc_dmi_match, "Apple MacBook", {
> 	  DMI_MATCH(DMI_BOARD_VENDOR,"Apple"),
> 	  DMI_MATCH(DMI_PRODUCT_NAME,"MacBook") },
> 		&applesmc_dmi_data[2]},
> 	{ applesmc_dmi_match, "Apple Macmini", {
> 	  DMI_MATCH(DMI_BOARD_VENDOR,"Apple"),
> 	  DMI_MATCH(DMI_PRODUCT_NAME,"Macmini") },
> 		&applesmc_dmi_data[3]},
> 	{ applesmc_dmi_match, "Apple MacPro2", {
> 	  DMI_MATCH(DMI_BOARD_VENDOR,"Apple"),
> 	  DMI_MATCH(DMI_PRODUCT_NAME,"MacPro2") },
> 		&applesmc_dmi_data[4]},
> 	{ applesmc_dmi_match, "Apple iMac", {
> 	  DMI_MATCH(DMI_BOARD_VENDOR,"Apple"),
> 	  DMI_MATCH(DMI_PRODUCT_NAME,"iMac") },
> 		&applesmc_dmi_data[5]},
> 	{ .ident = NULL }
> };
> 
> From my reading, we're still OK wrt the prefix-based string matching. 
> But please do double-chck this.
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
