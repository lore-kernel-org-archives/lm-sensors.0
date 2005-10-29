From: mstamp@gmail.com (Matthew Stamp)
Date: Sat, 29 Oct 2005 19:36:24 +0000
Subject: [lm-sensors] New Abit uGuru driver + libsensors patch,
Message-Id: <44b951e70510291035j6d1c3368k8b67d7fc2dcf7d36@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4358B291.6070702@hhs.nl>
In-Reply-To: <4358B291.6070702@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hans,
 I have used the force=1 bit and it seems to work. I do however get a beep
from my system speaker and this stated in dmesg.
 No Abit uGuru found, asuming one is present because of "force" parameter
Could not determine sensor type for sensorbank1 sensor 15, skipping sensor
 Also I patched lm-sensors and in ksensors I correctly displays my cputemp.
But Every 10 seconds give or take it will drop to 0, then -1 for a few
seconds then come back up to 32c.
 Other than that I am happy to finally be able to read these sensors. I have
waited for this for years. Thank you.
 matt

 On 10/29/05, Matthew Stamp <mstamp@gmail.com> wrote:
>
> Hans,
>  I will get back with you on the force=1 bit. But about the question with
> winxp. Everything works fine. Abit's uguru program reads the sensors
> correctly.
>
>  On 10/29/05, Hans de Goede <j.w.r.degoede@hhs.nl> wrote:
> >
> >
> >
> > Matthew Stamp wrote:
> > > Hans,
> > >
> > > Since my last email I have upgraded to 2.6.14 and got all the
> > nessasary
> > > modules in place. Although I have nothing in my /sys/bus/i2c/devices.
> > > I do have abituguru and i2c_adapter in the drivers section. I was
> > > talking with ollie long ago about this also. It seems his program
> > > openguru doesn't work on my board either, I have a AN7 bios v.19. Yes
> > > I know it is been proven to work with this board but for some reason
> > it
> > > does not with mine. When I use the openguru program it just simply
> > > states that uguru was not found.
> > >
> > >
> >
> > Could you rmmod the driver and insmod it as follows:
> > insmod <path>/abituguru.ko force=1
> >
> > That should skip the early part of the detection phase, instead it will
> > just assume the uguru is there and do a testread, if the testread
> > however fails then it will still not register (show up under
> > /sys/bus/i2c/devices).
> >
> > If the testread fails we do btw have a real problem, but lets take this
> > one step at a time. Have you ever had this working under windows? and do
> > the bios readings seem sane, there is a small chance you've just got a
> > busted uGuru.
> >
> > Regards,
> >
> > Hans
> >
>
>
