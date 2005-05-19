From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: Missing download
Message-Id: <200405131316.i4DDG1d3064516@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <opr7rnlmpsk46x2i@localhost>
In-Reply-To: <opr7rnlmpsk46x2i@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>Hello;
>Still doesn't work, this is what I get now:
>[root@localhost william]# sensors -s
>Can't access procfs/sysfs file
>Unable to find i2c bus information;
>For 2.6 kernels, make sure you have mounted sysfs and done
>'modprobe i2c_sensor'!
>For older kernels, make sure you have done 'modprobe i2c-proc'!
>[root@localhost william]# modprobe i2c_sensor
>[root@localhost william]# sensors -s
>No sensors found!
>
>I must have done something, but can't think what it could be.

Most probably, you just didn't load the sensor modules you need. Load
them and it should work better. If you can't remember what they are,
run sensors-detect again and it should tell you.

Jean


--
Jean "Khali" Delvare
http://khali.linux-fr.org/
