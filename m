From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 29 Jan 2006 21:31:33 +0000
Subject: [lm-sensors] w83627ehf fan controll?
Message-Id: <20060129223133.73376b5b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051230143805.GA21201@Apollo>
In-Reply-To: <20051230143805.GA21201@Apollo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Yuan,

> The attachments is the diff of linux-2.6.16-rc1 and my local CVS, These
> two patches use new sensor attr and add more functions, any comments and
> modify are welcome. Hope someone can help fix the bugs in these patches
> and send it out.Thanks.
> 
> It depends on "[PATCH 15/17] hwmon: Semaphore to mutex conversions"
> hwmon-convert-semaphores-to-mutexes.patch
> The first patch is w83627ehf_use_new_sensor_device_attr.patch.txt
> w83627ehf_add_more_functions.patch.txt is the second.

I've applied the first one to start with (use new sensor device attr),
it was really good. Let alone a few minor alignment issues, the only
change I'd like to do is:

 	for (i = 0; i < 5; i++) {
-		if (!(data->has_fan & (1 << i)))
-			continue;
-		device_create_file_fan(dev, i);
+		if (data->has_fan & (1 << i))
+			device_create_file_fan(dev, i);
 	}

It's clearer and shorter that way. OK?

Also, next time, please provide -p1-style patches so that I can apply
them easily using quilt. And please also include your Signed-off-by
line.

I'll try to find some time tomorrow to review the second patch, unless
Rudolf Marek (or anyone else for that matter) beats me to it.

Thanks,
-- 
Jean Delvare

