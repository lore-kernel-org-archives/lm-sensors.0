From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: i2c for Alpha
Message-Id: <3F8D8B33.5020002@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <200310121707.56799.jeff@jdfiles.org>
In-Reply-To: <200310121707.56799.jeff@jdfiles.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

In a pinch, you could try to remove modules you know you won't need (or 
won't build) by editing kernel/busses/Module.mk and probably also 
kernel/chips/Module.mk.  In the past, I had to do this to build on a PPC.


Phil

Jean Delvare wrote:

>>Moving on to lm-sensors 2.8.0, the build fails with the error-
>>
>>kernel/busses/i2c-nforce2.c:362: `GFP_KERNEL' undeclared (first use in
>>this function)
>>
>>Is there a known fix for this?
>>    
>>
>
>I suspect that you tried to update lm_sensors to 2.8.0 but did not
>update i2c to 2.8.0 preliminarily. Do that and it should work OK. You
>might want to take a look at our installation guide at
>http://www.ensicaen.ismra.fr/~delvare/devel/i2c/ since installing i2c
>2.8.0 is somewhat tricky.
>
>  
>
