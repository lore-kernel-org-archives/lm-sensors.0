From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Sat, 29 Oct 2005 10:14:57 +0000
Subject: [lm-sensors] New Abit uGuru driver + libsensors patch,
Message-Id: <436330C5.8030002@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <4358B291.6070702@hhs.nl>
In-Reply-To: <4358B291.6070702@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Matthew Stamp wrote:
> Hans,
>  
> Since my last email I have upgraded to 2.6.14 and got all the nessasary 
> modules in place.  Although I have nothing in my /sys/bus/i2c/devices.  
> I do have abituguru and i2c_adapter in the drivers section.  I was 
> talking with ollie long ago about this also.  It seems his program 
> openguru doesn't work on my board either,  I have a AN7 bios v.19.  Yes 
> I know it is been proven to work with this board but for some reason it 
> does not with mine.  When I use the openguru program it just simply 
> states that uguru was not found. 
> 
>  

Could you rmmod the driver and insmod it as follows:
insmod <path>/abituguru.ko force=1

That should skip the early part of the detection phase, instead it will 
just assume the uguru is there and do a testread, if the testread 
however fails then it will still not register (show up under 
/sys/bus/i2c/devices).

If the testread fails we do btw have a real problem, but lets take this 
one step at a time. Have you ever had this working under windows? and do 
the bios readings seem sane, there is a small chance you've just got a 
busted uGuru.

Regards,

Hans
