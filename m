From: Sean MacLennan <seanm@seanm.ca>
Date: Sun, 15 Jun 2008 22:07:48 +0000
Subject: Re: [lm-sensors] [PATCH] ad7414 driver
Message-Id: <20080615180748.7ba40688@lappy.seanm.ca>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080613221221.50c642ee@lappy.seanm.ca>
In-Reply-To: <20080613221221.50c642ee@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean, 

Thanks for the review... I will work on the changes.

I just wanted to make a couple of general comments. This driver was
based on the ad7418 driver, at least according to the copyrights at the
top. I assumed that the basic functionality (show/set for example) was
correct. I notice that many of the comments for this driver also apply
to the ad7418 ;)

I am using the ad7414 on the PIKA Warp product. The ad7414 is a very
important part of what we call DTM: Dynamic Thermal Management.
Basically DTM controls the fan and shuts down the machine if it gets
too hot.

The Warp does not have libsensors, let alone any apps to connect to
libsensors. All of the DTM is done in the kernel itself.

I could give you a link to the DTM code, but we had a bad thunderstorm
here and I can no longer connect to work :( I believe it is here:

http://svn.pikatech.com/appliance/branches/linux-2.6/arch/powerpc/platforms/44x/warp/warp.c

Cheers,
   Sean

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
