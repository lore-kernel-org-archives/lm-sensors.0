From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 11 Apr 2007 06:32:05 +0000
Subject: Re: [lm-sensors] w83627ehf reporting ghost fan?
Message-Id: <20070411083205.2044917c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <461C3562.2070006@gmail.com>
In-Reply-To: <461C3562.2070006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ankit, David,

On Wed, 11 Apr 2007 08:12:21 +0530, Ankit Chaturvedi wrote:
> David Hubbard wrote:
> > Thank you for reporting this. This issue has been reported before, and
> > I was unable to reproduce the error. I would like to track this down,
> > although it might be a little difficult. Can you please provide the
> > following information? (I am looking for the root cause)
> > 
> > Motherboard info: manufacturer, model number
> > CPU: manufacturer, model, speed
> > RAM installed
> > Graphics Card
> > 
> > How often have you seen this problem? Is it reproducible?
> > 
> > Would you also be able to sign on to irc.freenode.net #linux-sensors
> > on Saturday? (And if yes, what times?)
> > 
> > I have an Asus A8N-VM/CSM, with an AMD Athlon 64 X2 4400+, 1 Gb RAM,
> > and no graphics card (I use the integrated nVidia 6150 on the
> > A8N-VM/CSM).
> 
> 	I have this problem as soon as w83627ehf module gets loaded at boot and
> it occurs every time. My system specs are:
> 
> Motherboard: MSI K8NGM2-IL (link:
> http://global.msi.com.tw/index.php?func=proddesc&prod_no"4)
> CPU: AMD Athlon 3500+ (2.2GHz)
> RAM: 1GB (256 MB shared video mem)
> Graphics Card: Geforce 6100 Integrated
> OS: Gentoo Linux
> 
> 	On my earlier Mandriva setup with lm-sensors on the same system, this
> problem never appeared. It has started out with Gentoo only. I am
> attaching the sensors-detect log at the end. I will be on #linux-sensors
> on Saturday since midnight(UTC) the whole time, I want to get to the
> root at this too :) . Or you can decide a more favorable timeand let me
> know.

The bug is probably mine, sorry about that. The following patch should
fix it. Ankit, can you please apply it to your kernel and report?
David, please review and comment.

[PATCH] hwmon/w83627ehf: Fix the fan5 clock divider write

Users have been complaining about the w83627ehf driver flooding their
logs with messages like:

w83627ehf 9191-0a10: Increasing fan 4 clock divider from 64 to 128

or:

w83627ehf 9191-0290: Increasing fan 4 clock divider from 4 to 8

The reason is that we failed to actually write the LSB of the encoded
clock divider value for that fan, causing the next read to report the
same old value again and again.

Additionally, the fan number was improperly reported, making the bug
harder to find.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83627ehf.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.21-rc6.orig/drivers/hwmon/w83627ehf.c	2007-04-08 11:00:57.000000000 +0200
+++ linux-2.6.21-rc6/drivers/hwmon/w83627ehf.c	2007-04-11 08:12:02.000000000 +0200
@@ -407,7 +407,7 @@ static void w83627ehf_write_fan_div(stru
 		break;
 	case 4:
 		reg = (w83627ehf_read_value(client, W83627EHF_REG_DIODE) & 0x73)
-		    | ((data->fan_div[4] & 0x03) << 3)
+		    | ((data->fan_div[4] & 0x03) << 2)
 		    | ((data->fan_div[4] & 0x04) << 5);
 		w83627ehf_write_value(client, W83627EHF_REG_DIODE, reg);
 		break;
@@ -471,9 +471,9 @@ static struct w83627ehf_data *w83627ehf_
 			   time */
 			if (data->fan[i] = 0xff
 			 && data->fan_div[i] < 0x07) {
-			 	dev_dbg(&client->dev, "Increasing fan %d "
+			 	dev_dbg(&client->dev, "Increasing fan%d "
 					"clock divider from %u to %u\n",
-					i, div_from_reg(data->fan_div[i]),
+					i + 1, div_from_reg(data->fan_div[i]),
 					div_from_reg(data->fan_div[i] + 1));
 				data->fan_div[i]++;
 				w83627ehf_write_fan_div(client, i);


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
