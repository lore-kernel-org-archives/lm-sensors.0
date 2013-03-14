From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 14 Mar 2013 16:02:40 +0000
Subject: Re: [lm-sensors] Getting temps for all CPU cores to show up on an AMD chip
Message-Id: <20130314160240.GB2734@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAO2Qn5nT3FPbyrzJCF3NfyQ2y4sgR62w5JhMQeVNsHEcWY5HDA@mail.gmail.com>
In-Reply-To: <CAO2Qn5nT3FPbyrzJCF3NfyQ2y4sgR62w5JhMQeVNsHEcWY5HDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Mar 14, 2013 at 10:26:39AM -0500, dag dg wrote:
> I have an AMD Phenom II x4 that will show the individual core temps in a
> few utilities in windows but for the life of me I can't get lm_sensors to
> display them. I'm using the k10temp and w83627dhg-isa-0290 modules. This is
> for Fedora 17 lm_sensors version 3.3.2 kernel 3.7.9-104.fc17.x86_64. Here's
> what I'm seeing at the moment:
> 

The driver only supports reporting a single temperature, so that is not
surprising. Someone with access to a datasheet and the time to do it
would have to enhance the driver.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
