From: me@andrew.net.au (Andrew Pollock)
Date: Thu, 27 Apr 2006 15:51:34 +0000
Subject: [lm-sensors] Dell Latitude D610 and 2.6.16
Message-Id: <20060427155134.GN26452@daedalus.andrew.net.au>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060421050124.GY14481@daedalus.andrew.net.au>
In-Reply-To: <20060421050124.GY14481@daedalus.andrew.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Apr 27, 2006 at 09:57:29AM +0200, Jean Delvare wrote:
> Hi Andrew,
> 
> > I just thought I'd try out lm-sensors on my Dell D610 with what's in 2.6.16,
> > and sensors-detect decided that i2c-i801 and eeprom should be loaded, but
> > the sensors command fails, and there's nothing in /sys/class/hwmon (where I
> > presume from stracing sensors there is supposed to be something).
> > 
> > Should this work with this hardware?
> 
> The result you have is consistent with the drivers you loaded (which in
> turn sound OK for your hardware, I have a Dell Latitude D600 and I use
> the same drivers.) The sensors program and libsensors library were
> modified in lm_sensors 2.10.0 not to show non-sensors devices anymore
> (at least for 2.6 kernels.) EEPROMs are not sensors so it didn't belong
> there in the first place.

FWIW, the D600 is a vastly different beast to the D610. I made that mistake
when I bought it.

So are you saying that given the drivers I've loaded, there's nothing to
report on?

regards

Andrew

