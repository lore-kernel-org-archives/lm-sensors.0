From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 23 Jun 2008 13:48:53 +0000
Subject: Re: [lm-sensors] Asus atk0110 driver
Message-Id: <20080623154853.09e4d327@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080618212629.GA7917@dreamland.darkstar.lan>
In-Reply-To: <20080618212629.GA7917@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 23 Jun 2008 14:41:29 +0200, Gabriel C wrote:
> Jean Delvare wrote:
> > On Sun, 22 Jun 2008 18:15:51 +0200, Gabriel C wrote:
> >> Luca what do you think about creating  a proper patch for the driver too and send it over to 
> >> Greg to be included in his linux-staging tree ? I think that way it will get more testing.
> > 
> > Don't know which Greg you're thinking of? 
> 
> 
> Greg Kroah-Hartman
> 
> >This is an ACPI-based
> > hardware monitoring driver, so it would go to either the ACPI folks or
> > (IMHO better) to the hwmon folks (i.e. the lm-sensors list). I agree
> > that having a proper patch would be nice (but I also want to say that I
> > will not have the time to review the driver myself.)
> > 
> 
> 
> Yes sure but from what I understand linux-staging[1] tree holds not_yet__really_ready_to_merge
> drivers , filesystems and such. I don't think it does matter it is an ACPI driver.
> 
> [1] http://lkml.org/lkml/2008/6/10/329

Ah, I didn't know about this new kernel tree, thanks for the pointer. I
get what you meant now.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
