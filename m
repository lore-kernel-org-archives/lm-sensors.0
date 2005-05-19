From: miguel@rozsas.xx.nom.br (Miguel Angelo Rozsas)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: Can't access /proc file for writing
Message-Id: <1067788800.1461.45.camel@hahasiah.rozsas.xx.nom.br>
List-Id: <lm-sensors.vger.kernel.org>
References: <1067739926.5304.28.camel@hahasiah.rozsas.xx.nom.br>
In-Reply-To: <1067739926.5304.28.camel@hahasiah.rozsas.xx.nom.br>
To: lm-sensors@vger.kernel.org


Hi Jean, thanks for answered !

On Sun, 2003-11-02 at 07:52, Jean Delvare wrote:
> > Anyone can you help me, please ?
> 
> I'll do my best.
> 
> > My system is a ASUS P4T, P4 1.4GHz, running RH9, with the last
> > stable kernel 2.4.22 (from kernel.org), whith the
> > linux-2.4.22-i2c-2.8.1.patch patch applied and
> > lm_sensors-2.8.1.tar.gz installed.
> 
> Looks OK. Any additional patch (ACL, GRSEC) applied?

No, just the vanilla kernel from kernel.org and the i2c patches.

> 
> Either because "sensors -s" failed, or because these voltages aren't
> used on your system (most systems don't use these voltages anymore, so
> some don't bother monitoring them).

I think is because "sensors -s" failed. I have a virtual machine powered
by vmware and in the the BIOS setup has a option to show theses values
and I can read  right now, -11.9V and -4.98V...

The comments in the /etc/sensors.conf in the section for the
"as99127f-*" chipset, say the formulas are just a guess, because ASUS
won't released a datasheet for this chipset.

With the virtual machine help, I believe I can figure out a more precise
formula for theses readings. For this, I need to set up values with
"sensors -s", Am I right ? If I will successfully, I can contribute back
to community, with more precise configuration lines for this particular
system.

> 
> > 1) Why the permissions for /proc/bus/i2c* are 0444 ?
> 
> This is normal. These files only advertise about existing busses. Real
> files are in /proc/sys/dev/sensors.

> Move to /proc/sys/dev/sensors, and show us what "ls -lR" returns.
> 

Too long to put in-line. I am sending as an attached file.

> We have had half a dozen reports of problems similar to yours, and I
> have to say we never really found what was causing the problem (so
> couldn't solve it). If you system is specific in any way, please let us
> know (of course, i's hard to say what "specific" means here, since we
> don't really know what we're after).
> 

No, nothing cross my mind....I have a DVD, a IDE_ZIP, a NVidia card,the
last patch for the BIOS and I am using XD2 (Ximian Desktop 2). I think
is worth to mention that in single user mode, the umask is 022. I
expected 222 to explain theses permissions....

> > PS: Sorry any mistakes in my text. English isn't my native language.
> 
> It's not mine either, but we understand each other, isn't it? :)

I'm glad we did ! My English is far better than my French ! I visit
Toullouse/France several years ago, and without the help of a friend of
mine I was in trouble even for the basic needs. :-o I loved France, by
the way (in special, the country side in the spring - too beautiful) and
I hope to return to have a romantic time with my wife ;-)

best regards from Brazil,


-- 
Miguel Angelo Rozsas
miguel@rozsas.xx.nom.br
-------------- next part --------------
[00m/proc/sys/dev/sensors/:
total 0
dr-xr-xr-x    2 root     root            0 Nov  2 13:38 [00;34mas99127f-i2c-0-2d[00m
-rw-r--r--    1 root     root            0 Nov  2 13:38 [00mchips[00m
dr-xr-xr-x    2 root     root            0 Nov  2 13:38 [00;34meeprom-i2c-0-50[00m
dr-xr-xr-x    2 root     root            0 Nov  2 13:38 [00;34meeprom-i2c-0-51[00m
dr-xr-xr-x    2 root     root            0 Nov  2 13:38 [00;34meeprom-i2c-0-52[00m
dr-xr-xr-x    2 root     root            0 Nov  2 13:38 [00;34meeprom-i2c-0-53[00m

/proc/sys/dev/sensors/as99127f-i2c-0-2d:
total 0
-r--r--r--    1 root     root            0 Nov  2 13:38 [00malarms[00m
-rw-r--r--    1 root     root            0 Nov  2 13:38 [00mbeep[00m
-rw-r--r--    1 root     root            0 Nov  2 13:38 [00mfan1[00m
-rw-r--r--    1 root     root            0 Nov  2 13:38 [00mfan2[00m
-rw-r--r--    1 root     root            0 Nov  2 13:38 [00mfan3[00m
-rw-r--r--    1 root     root            0 Nov  2 13:38 [00mfan_div[00m
-rw-r--r--    1 root     root            0 Nov  2 13:38 [00min0[00m
-rw-r--r--    1 root     root            0 Nov  2 13:38 [00min1[00m
-rw-r--r--    1 root     root            0 Nov  2 13:38 [00min2[00m
-rw-r--r--    1 root     root            0 Nov  2 13:38 [00min3[00m
-rw-r--r--    1 root     root            0 Nov  2 13:38 [00min4[00m
-rw-r--r--    1 root     root            0 Nov  2 13:38 [00min5[00m
-rw-r--r--    1 root     root            0 Nov  2 13:38 [00min6[00m
-rw-r--r--    1 root     root            0 Nov  2 13:38 [00mpwm1[00m
-rw-r--r--    1 root     root            0 Nov  2 13:38 [00mpwm2[00m
-rw-r--r--    1 root     root            0 Nov  2 13:38 [00mtemp1[00m
-rw-r--r--    1 root     root            0 Nov  2 13:38 [00mtemp2[00m
-rw-r--r--    1 root     root            0 Nov  2 13:38 [00mtemp3[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00mvid[00m
-rw-r--r--    1 root     root            0 Nov  2 13:38 [00mvrm[00m

/proc/sys/dev/sensors/eeprom-i2c-0-50:
total 0
-r--r--r--    1 root     root            0 Nov  2 13:38 [00m00[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00m10[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00m20[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00m30[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00m40[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00m50[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00m60[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00m70[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00m80[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00m90[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00ma0[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00mb0[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00mc0[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00md0[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00me0[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00mf0[00m

/proc/sys/dev/sensors/eeprom-i2c-0-51:
total 0
-r--r--r--    1 root     root            0 Nov  2 13:38 [00m00[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00m10[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00m20[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00m30[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00m40[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00m50[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00m60[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00m70[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00m80[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00m90[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00ma0[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00mb0[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00mc0[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00md0[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00me0[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00mf0[00m

/proc/sys/dev/sensors/eeprom-i2c-0-52:
total 0
-r--r--r--    1 root     root            0 Nov  2 13:38 [00m00[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00m10[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00m20[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00m30[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00m40[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00m50[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00m60[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00m70[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00m80[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00m90[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00ma0[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00mb0[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00mc0[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00md0[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00me0[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00mf0[00m

/proc/sys/dev/sensors/eeprom-i2c-0-53:
total 0
-r--r--r--    1 root     root            0 Nov  2 13:38 [00m00[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00m10[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00m20[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00m30[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00m40[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00m50[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00m60[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00m70[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00m80[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00m90[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00ma0[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00mb0[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00mc0[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00md0[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00me0[00m
-r--r--r--    1 root     root            0 Nov  2 13:38 [00mf0[00m
[m
