From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 05 Apr 2012 14:32:09 +0000
Subject: Re: [lm-sensors] NEW Nuvoton w83795 hw chip driver
Message-Id: <20120405143209.GA24078@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <29CFBC9A3FDC81418F5FACEEC8970E003069F4@ntshml01.nuvoton.com>
In-Reply-To: <29CFBC9A3FDC81418F5FACEEC8970E003069F4@ntshml01.nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Apr 05, 2012 at 06:17:11AM -0400, Chislett, William wrote:
> Good Morning,
> 
> Apologies in advance as I realise the subject of this email may be slightly
> outdated and the driver I'm referring to was created some time ago (back in
> 2009!) but I've reached a dead-end trying to get reliable sensor readings from
> a new ASUS server (ASUS ESC4000), and was hoping someone might be able to help.
> 
> The issue I'm having is that lm-sensors only reads back realistic values for
> about 10% of the time.  The rest of the time all fanspeeds default to 90,000rpm
> and all temperatures to -0.2degrees and over 80degrees, which are obviously
> incorrect.  I've tried using the latest version of lm-sensors and the w83795
> driver but keep running into this problem.  The w83795 driver provided on the
> lm-sensorswiki/Devices is the same as that provided for this server via the
> ASUS website.
> 
> I'm using Linux CentOS 5.4 with a 2.6.18-164.el5 kernel (which isn't listed as
> being supported by this driver unfortunately - probably part of the issue). 
> I've also seen similar problems, although mostly involving sensor values
> locking-up, when using this driver and ipmi-tools or similar hardware
> monitoring utilities.
> 
> I was wondering if you knew of any updated versions of this driver, or
> alternatives I could try at all.  Any sort of advice at all would be massively
> appreciated!
> 
Hi,

the most likely reason for your problem is described here in detail:

http://hansdegoede.livejournal.com/7932.html

While that kernel change was made later, ASUS boards are known to use ACPI to access
the superio chip... which tends to result in exactly the behavior you are seeing.

You can try using the asus_atk0110 driver if it is supported in your kernel, or backport
it from a later kernel version, or update your kernel to one supporting it.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
