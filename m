From: Matt Hsu <matt@0xlab.org>
Date: Mon, 14 Dec 2009 03:29:18 +0000
Subject: Re: [lm-sensors] Duplicated driver for LIS302-like device.
Message-Id: <4B25B10E.1010409@0xlab.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4B21B40B.2010007@0xlab.org> <4B2241D0.3050504@cam.ac.uk>
In-Reply-To: <4B2241D0.3050504@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, Samu Onkalo <samu.p.onkalo@nokia.com>, Eric Piel <eric.piel@tremplin-utc.net>, "Trisal, Kalhan" <kalhan.trisal@intel.com>, LM Sensors <lm-sensors@lm-sensors.org>

Jonathan Cameron wrote:
> Hi Matt
>   
> Gah, Not again!  So far we have had two patch sets implementing just
> this.  Looking at the latest from Samu, Eric's patch has been sent on
> to Andrew Morton for the current merge window (and is listed as being in
> his mm tree).  May even have merged since I last pulled mainline.
>
> You have my sympathies as the whole duplicating work thing happens to
> us all from time to time.  The answer is as ever, post early and post
> often to the relevant mailing lists. (though of course hardly anyone
> actually keeps to this!)
>   
    Hi Jonathan,

    Thanks for your information.
    Previously, I only went through input subsystem instead of lm-sensors.
    And now the upstream driver seems to be implemented and merged. I 
will cherry pick them into 0xlab kernel repository.

    Cheers,
    Matt
> I've cc'd in everyone I know has an interest in this driver for any
> thing else they might want to add.
>
> Jonathan
>   


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
