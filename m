From: linux@1g6.biz (Nicolas)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: sis5595
Message-Id: <200307161604.40027.linux@1g6.biz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307161427.08403.linux@1g6.biz>
In-Reply-To: <200307161427.08403.linux@1g6.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello,

kernel 2.4 doesn't work on my computer 
(no networking because sis648/sis900),

The procfs stuffs are /* commented */,
I looked at differencies in via686a.c and it87.c betweens 2.4 and 2.6
 to port sis5595.c, so if
via686a/it87 aren't good in 2.6 ... :(,
I lost my time.

have a look : 
[root@hal9003 SiS 5595]# uname -a
Linux hal9003.1g6.biz 2.6.0-test1 #15 mar jui 15...
[root@hal9003 SiS 5595]# pwd
/sys/bus/i2c/drivers/SiS 5595  (apparently not totally wrong)

[root@hal9003 proc]# find /proc -iname "*sis*"
/proc/ide/sis

491         /* Register a new directory entry with module sensors */
    492         device_create_file(&new_client->dev, &dev_attr_fan_input1);
    493         device_create_file(&new_client->dev, &dev_attr_fan_min1);
    494         device_create_file(&new_client->dev, &dev_attr_fan_div1);
    495         device_create_file(&new_client->dev, &dev_attr_fan_input2);
    496         device_create_file(&new_client->dev, &dev_attr_fan_min2);
    497         device_create_file(&new_client->dev, &dev_attr_fan_div2);
    498         //device_create_file(&new_client->dev, &dev_attr_in_input0);
    499         /*
    500         if ((i = i2c_register_entry((struct i2c_client *) new_client,

I didn't know for the misdetection problem, and I just
wanted "cat /sys/..", doesn't mind about libraries...

Regards.

Nicolas.

Le Mercredi 16 Juillet 2003 15:04, vous avez ?crit :
> > I am using 2.6.0-test1,
> > and I launched "sensors-detect",
> > it told me I have an sis5595.
> > So I began to port the 2.4.21 sis5595 driver to 2.6 kernel.
> > Here are the beginning of my work, but I am stuck here :
> > i2c_detect doesn't call sis5595_detect.
>
> There are many, many SiS chipsets that are misdetected as SiS5595. I
> suggest you begin with trying lm_sensors on a 2.4 kernel, so you'll see
> if it works on your system. What's more, libsensors and most userspace
> tools do not exist
>
> > I don't know if it is because I haven't the good hardware or
> > if I made a mistake. I seems I have something at adress 8008, but I
> > don't have enougth experience in developping kernel drivers so I gived
> > up, and I send you my work.
>
> Your porting is wrong. In 2.5/2.6, sensor modules export their values
> using sysfs, not procfs. And I guess you started with an old version of
> sis5595.c, because many things I see in "your" code has been removed
> from our times ago. If you really want to port the driver, please see
> with Greg how to do this correctly.

