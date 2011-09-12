From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 12 Sep 2011 18:06:44 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon/f71882fg: Make all fan/pwm attr
Message-Id: <1315850804.2455.199.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1315563155-15774-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1315563155-15774-1-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2011-09-12 at 13:59 -0400, Hans de Goede wrote:
> Hi,
> 
> On 09/12/2011 07:48 PM, Guenter Roeck wrote:
> > On Fri, 2011-09-09 at 06:12 -0400, Hans de Goede wrote:
> >> This is a preparation patch for not registering fan/pwm attributes for
> >> some fans (rather then register them for all or for none).
> >>
> >> Signed-off-by: Hans de Goede<hdegoede@redhat.com>
> >> ---
> >
> > Hans,
> >
> > what tree is your patch series based on ? I tried to apply it to
> > mainline for testing but it failed.
> 
> Hmm, they apply cleanly for me against a fully up2date checkout of:
> git://github.com/torvalds/linux.git
> 
> Want me to resend them?
> 
No need. I had copied the patches from the gmane.org archive in a single
mbox file, and tried to apply the series as it was received from that
file ... apparently it was not in order, and git does not like that. I
was able to apply the series after separating the patches into
individual patch files.

Thanks, and sorry for the noise.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
