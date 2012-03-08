From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 08 Mar 2012 17:08:50 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (jc42) Remove unnecessary device IDs
Message-Id: <1331226530.23014.385.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1331223985-21810-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1331223985-21810-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2012-03-08 at 11:54 -0500, Jean Delvare wrote:
> Hi Guenter,
> 
> On Thu,  8 Mar 2012 08:26:25 -0800, Guenter Roeck wrote:
> > We don't really use or need separate device IDs for the various JC42.4 compliant
> > chips, so remove them and only retain 'jc42'.
> > 
> > Also update a datasheet references for SE98A, STTS424, and STTS424E02.
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> 
> Looks good overall.
> 
> > TBD: Should we merge "Prefix" and "Addresses scanned" lines in Documentation ?
> 
> Good question. I'd say yes, my only concern being when it isn't obvious
> which datasheet is for which device. OTOH it is already a problem with
> the split entries we have today as they are already grouped by
> manufacturer. So I'd say just go and merge everything.
> 
Just sent a second version, keeping the manufacturers but moving the
Prefix and Addresses scanned information into a separate paragraph.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
