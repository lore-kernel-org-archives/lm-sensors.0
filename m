From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 20 Oct 2008 06:48:26 +0000
Subject: Re: [lm-sensors] abituguru3: Please send .. to the abituguru3 (see
Message-Id: <20081020084826.3aac3b53@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.DEB.1.10.0810191251550.19058@p34.internal.lan>
In-Reply-To: <alpine.DEB.1.10.0810191251550.19058@p34.internal.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alistair,

On Sun, 19 Oct 2008 20:53:26 +0100, Alistair John Strachan wrote:
> On Sunday 19 October 2008 17:54:15 Justin Piszcz wrote:
> > Kernel: 2.6.27.2:
> > [   10.242065] abituguru3: found Abit uGuru3, motherboard ID: 0016
> > [   10.242105] abituguru3: this motherboard was not detected using DMI.
> > Please send the output of "dmidecode" to the abituguru3 maintainer(see
> > MAINTAINERS)
> >
> > Motherboard: AW9D-MAX as shown below.
> >
> > DMI Decode:
> [snip]
> >  	Product Name: AW9D-MAX       (Intel i975-ICH7)
> 
> The spaces are a somewhat worrying (Abit haven't done this on other boards I 
> have DMI information for), but assuming they're constant through all BIOS 
> revisions the attached patch should be safe.
> 
> (In the longer term it might be safer to only match the board product name, 
> and ignore the chipset information. I'll do this if the need arises.)

I would indeed suggest doing this. It's easy (just use strncmp()
instead of strcmp()) and then you no longer need to pay attention to the
number of spaces in the middle of the string.

> Please test the attached patch. I'll resubmit a cleaned up version if you can 
> verify that the kernel message disappears and your sensors still work.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
