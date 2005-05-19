From: adilger@clusterfs.com (Andreas Dilger)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: Ticket #1851 - PATCH (take 2) for adm1026.c, kernel 2.6.10-bk6
Message-Id: <20050103205231.GK9923@schnapps.adilger.int>
List-Id: <lm-sensors.vger.kernel.org>
References: <41D5D075.4000200@paradyne.com> <20050101001205.6b2a44d3.khali@linux-fr.org> <20050103194355.GA11979@penguincomputing.com> <20050103201056.3c55e330.khali@linux-fr.org> <20050103213707.GA12765@penguincomputing.com>
In-Reply-To: <20050103213707.GA12765@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Justin Thiessen <jthiessen@penguincomputing.com>
Cc: LM Sensors <sensors@stimpy.netroedge.com>, LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>

On Jan 03, 2005  13:37 -0800, Justin Thiessen wrote:
> The amount of duplicated code is only a few lines, and I think the result is
> clearer if it is not extracted into a separate function.  See the following
> patch.

> +	value = adm1026_read_value(client, ADM1026_REG_FAN_DIV_0_3)
> +		| (adm1026_read_value(client, ADM1026_REG_FAN_DIV_4_7)
> +		<< 8);

The formatting of this makes it hard to follow the logic.  The "<< 8"
operation isn't aligned with the nesting parenthesis and at first I
thought there was an ambiguous order of operation "|" vs "<<".

How about the following:

--- linux-2.6.10/drivers/i2c/chips/adm1026.c.orig	2005-01-02 15:21:58.000000000 -0800
+++ linux-2.6.10/drivers/i2c/chips/adm1026.c	2005-01-02 18:27:40.695689832 -0800
@@ -452,6 +452,14 @@ void adm1026_init_client(struct i2c_clie
 		client->id, value);
 	data->config1 = value;
 	adm1026_write_value(client, ADM1026_REG_CONFIG1, value);
+
+	/* initialize fan_div[] to hardware defaults */
+	value = adm1026_read_value(client, ADM1026_REG_FAN_DIV_0_3) |
+		(adm1026_read_value(client, ADM1026_REG_FAN_DIV_4_7) << 8);
+	for (i = 0;i <= 7;++i) {
+		data->fan_div[i] = DIV_FROM_REG(value & 0x03);
+		value >>= 2;
+	}
 }
 
 void adm1026_print_gpio(struct i2c_client *client)



Also, on a completely "I don't know what the hell I'm talking about" point,
it seems odd that for values named "0_3" and "4_7" you would upshift the
"4_7" value 8 bits instead of 4, but it could be just a bad choice of
variable names.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050103/1cf38540/attachment.bin
