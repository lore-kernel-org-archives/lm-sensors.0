From: Frank Myhr <fmyhr@fhmtech.com>
Date: Fri, 03 Oct 2008 20:29:17 +0000
Subject: Re: [lm-sensors] Looking for IT8720 datasheet.
Message-Id: <48E6809D.2090709@fhmtech.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <79c9d4530810020825r79de9817g6933f6cab1d414c1@mail.gmail.com>
In-Reply-To: <79c9d4530810020825r79de9817g6933f6cab1d414c1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean-Marc Spaggiari wrote:

> Ok, so I will update the documentation when I will have the resistors value.

Great! Thank you.


> Regarding pwm, I'm able to read the fan speed for 3/3, but I'm able to
> modify it only for 2/3. the "power" fan seems to not reply to any
> command. Maybe it's not map correctly inside it87?

I think the mapping of it87 fan/pwm channel to motherboard fan header is
motherboard-specific. If your "power" fan is the fan inside your power
supply, then its speed is controlled by the power supply, not by the
it87. Typically the power supply will have a fan connector with only 2
wires, that can be plugged into a motherboard header to monitor (but not
control) rpm. Maybe I don't understand your situation?


> Regarding the patch, are you going to apply it? Or should I submit it somewhere?

Please submit it to this list when you are ready. Please see
Documentation/SubmittingPatches
for detailed instructions on submitting patches--the patch should be
formatted in a particular way, as should the email. Don't forget to
include "Signed-off-by:" (You can see examples in the other patches
submitted to this list.) I'd recommend sending a test email with the
patch to yourself first, to make sure your mailer isn't doing funky
things to it. I've managed to screw that up in various ways.

I've so far contributed a grand total of two (count 'em!) tiny patches,
one of which managed to trigger a regression that Jean kindly tracked
down and fixed. So I'm hardly an expert on the process. But generally
what I think happens is that after you've posted your patch to this
list, I or someone else will add an "Acked-by:" to it, Jean will add it
to his hwmon tree, which he will then submit to Linus.

Thanks for your work!,
Frank

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
