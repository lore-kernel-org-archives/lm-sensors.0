From: "Leslie Rhorer" <lrhorer@mygrande.net>
Date: Mon, 07 Jan 2013 23:31:16 +0000
Subject: Re: [lm-sensors] ASUS M5A99X EVO R2.0
Message-Id: <201301072331.r07NVHce006267@mx3.lsn.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <201301050318.r053Ioa1022953@mx3.lsn.net>
In-Reply-To: <201301050318.r053Ioa1022953@mx3.lsn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> -----Original Message-----
> From: Jean Delvare [mailto:khali@linux-fr.org]
> Sent: Monday, January 07, 2013 3:54 PM
> To: Leslie Rhorer
> Cc: lm-sensors@lm-sensors.org
> Subject: Re: [lm-sensors] ASUS M5A99X EVO R2.0
> 
> On Mon, 7 Jan 2013 15:42:43 -0600, Leslie Rhorer wrote:
> > 	Hmm.  I just put the following into /etc/sensors.conf
> >
> > chip "it8721-isa-0290"
> >
> >    label fan2 "CPU Fan"
> >
> > 	And then ran `sensors -s` followed by `sensors`, but the output from
> > `sensors` did not change.  I also tried "*-isa-*.  Is there something
> else I
> > should be doing?
> 
> Try /etc/sensors3.conf instead, or even better, create a new file
> under /etc/sensors.d for your board.

	Ah!  I hadn't even noticed there was already a /etc/sensors3.conf
file.  Editing that instead of /etc/sensors.conf did the trick.  I may
create the file in /etc/sensors.d after I get all the other stuff worked
out.  Would M5A99X_EVO.conf be OK for the name, or does the name have to be
sensors.conf?


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
