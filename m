From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 24 Jun 2007 13:02:28 +0000
Subject: Re: [lm-sensors] [PATCH] Add temperature-tracking mode to f71805f
Message-Id: <20070624130228.GA3289@mars.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <1182285507009@dmwebmail.belize.chezphil.org>
In-Reply-To: <1182285507009@dmwebmail.belize.chezphil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean, Phil:

> On Tue, 19 Jun 2007 21:38:27 +0100, Phil Endecott wrote:
> > This second version of the patch includes documentation updates, adds 
> > the 'channels' sysfs files that describe the fixed relationships 
> > between pwms, fans and temperatures, reverses the order of the 
> > auto_points so that greater point number corresponds to greater 
> > temperature, and addresses the mostly-stylistic issues raised by Jean 
> > earlier today.  It seems to work for me but as I've noted before I can 
> > only test the channel-1 functionality, so I'd appreciate it if others 
> > could scan for sanity in the other channels.

* Jean Delvare <khali@linux-fr.org> [2007-06-24 11:54:06 +0200]:
> $ quilt push
> Application de hwmon-f71805f-add-temperature-tracking-mode.patch
> patching file drivers/hwmon/f71805f.c
> Hunk #1 FAILED at 126.
> Hunk #2 FAILED at 149.
> Hunk #3 FAILED at 180.
> Hunk #4 FAILED at 323.
> Hunk #5 FAILED at 353.
> Hunk #6 FAILED at 728.
> Hunk #7 FAILED at 1029.
> Hunk #8 FAILED at 1163.
> 8 out of 8 hunks FAILED -- rejects in file drivers/hwmon/f71805f.c
> patching file Documentation/hwmon/f71805f
> Hunk #1 FAILED at 38.
> Hunk #2 FAILED at 130.
> patch: **** malformed patch at line 437: pwm2 to
> 
> How exactly did you generate this patch? Please send something I can
> apply.
> 
> BTW:
> 
> > Signed-off-by: Phil Endecott <spam_from_hwmon_patch_2@chezphil.org>
> 
> I'm not sure I can push this upstream, when you are so obviously
> providing a soon-to-be-invalid e-mail address. It's OK to sign your
> kernel patches with a specific e-mail address, but it shouldn't change
> with every patch. Mark, what do you think?

I agree with you Jean.  Phil: please pick one address for all sign-off, and
make sure that your patches come From: that same address.  Thanks.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
