From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:25:44 +0000
Subject: lsb in emc6d102 and adm1027
Message-Id: <423E7A70.4020908@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200503201236.33120.rafael.espindola@gmail.com>
In-Reply-To: <200503201236.33120.rafael.espindola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rafael ?vila de Esp?ndola wrote:

>The attached patches add support for reading the lsb from the emc6d102 and 
>change how they are read from the adm1027.
>
>The lm85_update_device function decodes the LSBs to temp_ext and in_ext. This 
>strategy was suggested by Philip Pokorny.
>  
>
Thank you for the cred.

>Index: drivers/i2c/chips/lm85.c
>=================================>--- drivers/i2c/chips/lm85.c	(revision 26738)
>+++ drivers/i2c/chips/lm85.c	(working copy)
>@@ -1411,6 +1443,28 @@
> 			/* More alarm bits */
> 			data->alarms |> 				lm85_read_value(client, EMC6D100_REG_ALARM3) << 16;
>+		} else if (data->type = emc6d102 ) {
>+			/* Have to read LSB bits after the MSB ones because
>+			   the reading of the MSB bits has frozen the
>+			   LSBs (backward from the ADM1027).
>+			 */
>+			int ext1 = lm85_read_value(client,
>+						   EMC6D102_REG_EXTEND_ADC1);
>+			int ext2 = lm85_read_value(client,
>+						   EMC6D102_REG_EXTEND_ADC2);
>+			int ext3 = lm85_read_value(client,
>+						   EMC6D102_REG_EXTEND_ADC3);
>+			int ext4 = lm85_read_value(client,
>+						   EMC6D102_REG_EXTEND_ADC4);
>+			data->in_ext[0] = ext3 & 0x0f;
>+			data->in_ext[1] = ext4 & 0x0f;
>+			data->in_ext[2] = (ext4 >> 8) & 0x0f;
>+			data->in_ext[3] = (ext3 >> 8) & 0x0f;
>+			data->in_ext[4] = (ext2 >> 8) & 0x0f;
>+
>+			data->temp_ext[0] = ext1 & 0x0f;
>+			data->temp_ext[1] = ext2 & 0x0f;
>+			data->temp_ext[2] = (ext1 >> 8) & 0x0f;
> 		}
> 
> 		data->last_reading = jiffies ;
>  
>

This doesn't look right.  The lm85_read_value() function generally only 
returns an 8-bit value.  In some cases it returns 16 bits but those are 
exceptions, and you haven't added the EMC6D102 registers to that 
exception list.

So how can you shift ext4, ext3, ext1, etc right 8 bits and have a value 
with any meaning?

Perhaps you meant to shift by only 4 bits to get the high nibble?

:v)
