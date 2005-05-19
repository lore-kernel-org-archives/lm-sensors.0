From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:13 +0000
Subject: Question concerning sensors chips.c alarm handling
Message-Id: <20040908073033.M33590@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0409071447260.8167@malachi.lee.k12.nc.us>
In-Reply-To: <Pine.LNX.4.58.0409071447260.8167@malachi.lee.k12.nc.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I was looking in the sensors program's chips.c file at the various
> print_*() routines and found the following code:
> 
> 	if (!sensors_get_feature(*name,SENSORS_ADM1025_ALARMS,&cur))
> 	    alarms = cur + 0.5;
>   	else {
> 	    printf("ERROR: Can't get alarm data!\n");
> 	    alarms = 0;
> 	}
> 
> repeated in various routines for various chips.  Why is 0.5 added to
> the alarm mask value?

Values are retrieved from libsensors as floating point numbers, not integers.
When converting from floating point to interger, C will simply drop the
non-interger part. Thus, 12345677.99999 will be converted to 12345677 while we
are obviously expecting 12345678. Thus it is usually considered a good
practice to add 0.5 to any floating point value before converting it to an
integer.

Note that I am not sure it is needed in our specific case. The "double" type
should be able to handle 32-bit integer values without losses, and the drivers
don't export alarm values over 32-bit as far as I know. So I guess that the "+
0.5" operation is theoretical and we don't actually need it. Feel free to drop
it in your own code unless you notice it is actually needed.

-- 
Jean Delvare
http://khali.linux-fr.org/
