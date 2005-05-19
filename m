From: tuby@asem.it (Stefano Tubaro)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: Technical reference - Ali M5879
Message-Id: <001201c40bf1$0f35e270$051010ac@tuby>
List-Id: <lm-sensors.vger.kernel.org>
References: <000c01c4081b$427e5010$051010ac@tuby>
In-Reply-To: <000c01c4081b$427e5010$051010ac@tuby>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear Jean,

Thank you for yor e-mail.

I've tried to test your sensors-detect on a Suse 8.2 distribution, but I've
seen that the i2cdetect file is missing.

This week I'm very busy on driver development under XP.
Next week I will install the latest versions of i2c and sensors packages and
I retry your new detection program.

By the way, on Suse 8.2 I was not able to detect a Texas Instrument BQ2060
smartbattery controller.
There is a detection of a I2C chip at address 0x0B, but the smartbattery
detection fails.
I'll retry this detection too, after upgrading the i2c/sensors packages.

Thank you again and Best Regards

Stefano



From: Jean Delvare
To: Stefano Tubaro
Cc: sensors@Stimpy.netroedge.com
Sent: Saturday, March 13, 2004 7:25 PM
Subject: Re: Technical reference - Ali M5879


> I read that you don't have any technical reference for the Ali M5879
> hardware monitor.
>
> Here you can find it

Thanks :)

I used it to add detection support in sensors-detect. If you do own such
a chip, I'd like you to give it a try and confirm that it works for you.

http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/prog/detect/sensors-detect
(You'll need a recent version of i2cdetect for it to work.)

Thanks again.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

