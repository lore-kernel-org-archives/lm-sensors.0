From: medaglia@gmail.com (Cadu)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: Winbound W83627EHF sensor
Message-Id: <797de5c3050511075323d34b3d@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050510203454.27683f7b.medaglia@gmail.com>
In-Reply-To: <20050510203454.27683f7b.medaglia@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 5/11/05, Jean Delvare <khali@linux-fr.org> wrote:
> > I'd like to help with code. I've wrote a webcam driver to Linux, so I
> > have some experience. I'd like to know where to start! :)
> 
> Pick the datasheet here:
> http://archives.andrew.net.au/lm-sensors/pdfe5IBpZipZu.pdf

Ok... Thanks!

> Reminder for your future work: do NOT trust that datasheet like holy
> words. I have found errors already, and there may be more.

Oh.. I know. I have experience with bad datasheets too... :)

> Then start from my version of the driver (be sure to start from the
> latest version!) 

Where is the latest version? I have a patch to linux-2.6.12-rc3. I
don't know if it is the latest version.
Are you hacking this driver now? I'm asking that because if the answer
is yes, we can change the same thing at the same time, and maybe it
will not be a good thing.

> and add the missing functions (voltage inputs, VID/VRM,
> PWM outputs). My w83627ehf code is based on the w83627hf driver in the
> first place, so you can probaly find inspiration there. See how this
> other driver handles the missing features, copy to the w83627ehf driver
> and edit to match the datasheet. Then recompile and test your new driver.
> 
> Note that "sensors" won't show anything until libsensors knows about
> the new features. I invite you to first make sure that the driver works
> OK by manually reading and writing values in /sys/bus/i2c/devices/*.
> Once you have tested this, you can edit the code of libsensors and the
> sensors program (both in the lm_sensors package) to handle the new
> features.

I'll do that.

> That's it for the big plan. Now if you have more precise questions, do
> not hesitate. Oh, and please answer to the mailing-list rather than me
> directly, so that others can voice in.

Ok. I will start today!

Thank you!
Cadu
