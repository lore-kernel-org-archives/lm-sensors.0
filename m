From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 28 Jun 2011 18:19:48 +0000
Subject: Re: [lm-sensors] [PATCH v3] Add support for the Philips SA56004
Message-Id: <1309285188.12139.1.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1307356845-10095-1-git-send-email-sdevrien@cisco.com>
	 <BANLkTi=gAqpDNBjCXzvNEhSuzm=3Mg9rVg@mail.gmail.com>
	 <6E4D2678AC543844917CA081C9D6B33F04CF4FFC@XMB-AMS-103.cisco.com>
	 <BANLkTim=9ygJScqy12PQXNPBStSgPbpedQ@mail.gmail.com>
In-Reply-To: <BANLkTim=9ygJScqy12PQXNPBStSgPbpedQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Fubo Chen <fubo.chen@gmail.com>
Cc: "Stijn Devriendt (sdevrien)" <sdevrien@cisco.com>, "khali@linux-fr.org" <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, 2011-06-28 at 13:50 -0400, Fubo Chen wrote:
> On Mon, Jun 27, 2011 at 9:04 AM, Stijn Devriendt (sdevrien)
> <sdevrien@cisco.com> wrote:
> >> On Mon, Jun 6, 2011 at 12:40 PM,  <sdevrien@cisco.com> wrote:
> >> > +       } else
> >> > +       if (man_id = 0xA1) { /*  NXP Semiconductor/Philips */
> >>
> >> No kernel coder writes like this. Has this ever been run through
> >> checkpatch ?
> > It has. Unfortunately this is just the coding style in the whole
> > driver. I believe it's better to have a consistent file rather
> > than 3 different styles.
> 
> Makes sense to me. By the way, it's not forbidden to clean up unusual
> coding style from other developers.
> 
Yes, but as separate patch. Please feel free to submit such a patch.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
