From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Mon, 20 Aug 2007 20:44:02 +0000
Subject: Re: [lm-sensors] Submitting motherboard-specific support? (w/
Message-Id: <46C9FD12.4050403@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <46C997B4.50509@dolbeau.org>
In-Reply-To: <46C997B4.50509@dolbeau.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> 
> Also, storing the configuration files in the wiki is probably the worse
> thing we could come up with in these conditions, but hopefully we'll
> have something better shortly after lm-sensors 3.0.1 is released.
> 

Hmm,

Do you have something planned? As you know I've had several students work on a 
motherboard config website without much success, I do think Ivo's 
sensors-detect changes for dmi based autoconf are good (we need to get those 
integrated, plan?). But the website delivered by one of his fellow students is 
less good.

I do have a friend who is a php guru who is willing to write a php driven site 
for us if we can provide him with proper specs.

I can start writing a spec for the website as time permits, then discuss it 
here, and once approved ask him to write it (under an OSS license of course).

Another option would be to stay with the wiki, add some special markup comments 
for the dmi strings and write a script to generate a tarbal / "database" for 
the dmi based detect code. For me putting the info in the wiki works well, its 
not like we are getting multiple motherboard configs per day, and the wiki 
keeps history which can be benifitial (a sufficiently advanced website could do 
this too).

Regards,

Hans



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
