From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:27 +0000
Subject: EP-9NDA3+ w/ Winbond W83627THF LPC
Message-Id: <20041219144520.GA10771@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <32906.216.9.170.171.1103272080.spork@webmail.necrotec.com>
In-Reply-To: <32906.216.9.170.171.1103272080.spork@webmail.necrotec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2004-12-19 14:06:15 +0100]:
> Hi again Erek,
> 
> > Explanation was: the W83627THF is on secondary Super-I/O address
> > (0x4e/0x4f), and the driver doesn't support that.
> > 
> > The driver would need to be updated in the same way I did for the
> > pc87360.
> 
> I have come up with a very simplified patch that would do that. Not
> exactly elegant but it keeps the changes to a minimum. The one I worked
> on while we were on IRC was really too complex and had drawbacks too.

It looks OK to me; not sure what you don't like about it.

> I have attached the patch to this mail, could you please give it a try?
> It should apply to your 2.6.8.1 kernel just fine (to the original file
> of course, not the one we modified together). If it works I'll push it
> to Greg for inclusion into the main kernel tree, and will also backport
> it to our lm_sensors CVS repository.
> 
> I also have a second patch (attached too) which partly rewrites the way
> the VID pins (nominal CPU core voltage) are read on the W83627THF (the
> chip you have). I would be grateful if you could give a try to this one
> too (again, should apply fine to your 2.6.8.1 kernel on top of the first
> one of this mail) and report if VID value is still OK for you. The patch
> drops useless code and adds additional validity checks and support for
> VRM 10 (6-bit VID values).

I added both patches to my stack and it works fine here.  But of course
my chip uses the normal 0x2e/0x2f.

(...)

> +	dev_info(&client->dev, "Reading VID from GPIO5\n");

I think this should be dev_dbg().

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
