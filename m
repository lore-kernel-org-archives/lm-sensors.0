From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 13 Jan 2012 07:23:24 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm63) Add sensor type attribute for external sensor on LM96163
Message-Id: <20120113072324.GA21453@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326215659-13330-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1326215659-13330-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Jan 13, 2012 at 01:54:15AM -0500, Jean Delvare wrote:
> On Thu, 12 Jan 2012 14:14:45 -0800, Guenter Roeck wrote:
> > On Thu, 2012-01-12 at 16:51 -0500, Jean Delvare wrote:
> > > It's questionable whether you want 3 or rather 1 for TruTherm beta
> > > compensation mode. While Documentation/hwmon/sysfs-interface says 1 is
> > > PII/Celeron Diode, I think this is an historical glitch and what it
> > > really means is "CPU embedded diode". It might be the right time to fix
> > > that. BTW "sensors" says just "diode" for type 1, with no reference to
> > > PII/Celeron.
> > > 
> > Ok with me. Should we change the documentation as well (separate
> > patch) ?
> 
> I think so, yes. Either you do it, or I'll do if you prefer.
> 
I'll do it, no problem.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
