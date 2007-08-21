From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 21 Aug 2007 08:45:10 +0000
Subject: Re: [lm-sensors] Submitting motherboard-specific support? (w/
Message-Id: <20070821104510.3cf9518e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <46C997B4.50509@dolbeau.org>
In-Reply-To: <46C997B4.50509@dolbeau.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Mon, 20 Aug 2007 22:44:02 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > Also, storing the configuration files in the wiki is probably the worse
> > thing we could come up with in these conditions, but hopefully we'll
> > have something better shortly after lm-sensors 3.0.1 is released.
> 
> Do you have something planned? As you know I've had several students work on a 
> motherboard config website without much success, I do think Ivo's 
> sensors-detect changes for dmi based autoconf are good (we need to get those 
> integrated, plan?). But the website delivered by one of his fellow students is 
> less good.

Your students' work was obviously what I was thinking about here.

> I do have a friend who is a php guru who is willing to write a php driven site 
> for us if we can provide him with proper specs.
> 
> I can start writing a spec for the website as time permits, then discuss it 
> here, and once approved ask him to write it (under an OSS license of course).

Writing it is one thing, hosting it is another. Axel, maybe I already
asked, can't remember: can we host a PHP app on lm-sensors.org?

> Another option would be to stay with the wiki, add some special markup comments 
> for the dmi strings and write a script to generate a tarbal / "database" for 
> the dmi based detect code. For me putting the info in the wiki works well, its 
> not like we are getting multiple motherboard configs per day, and the wiki 
> keeps history which can be benifitial (a sufficiently advanced website could do 
> this too).

I'd prefer a dedicated interface where anyone can contribute its
configuration. The target configuration count is in hundreds if not
thousands, that's not something we want to handle manually.

That being said, if someone _else_ is going to take care, it doesn't
matter that much to me ;) The usual open development rule applies:
whoever does the job decides how it should be done. I simply haven't
looked enough into it all yet, for now I'm focusing on getting
libsensors4 ready so that we can release it before the end of the year.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
