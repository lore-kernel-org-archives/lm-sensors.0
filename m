From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 09 Dec 2010 20:45:18 +0000
Subject: Re: [lm-sensors] [PATCH v2] lm-sensors: Add support for new hwmon
Message-Id: <1291927518.2406.43.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1278567813-9608-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1278567813-9608-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2010-12-09 at 15:31 -0500, Jean Delvare wrote:
> On Thu, 9 Dec 2010 07:40:46 -0800, Guenter Roeck wrote:
> > Actually, I think I'll have to re-do the whole patch anyway. As you pointed out,
> > it does not reflect the documented attributes, and there are other problems 
> > such as how and when to display alarms. Without going into details,
> > I don't think we really disagree on anything
> 
> I agree.
> 
> > - the idea was to retain the existing output.
> 
> Up to a certain point, yes. Where the current output was decided
> because it made sense, we want to keep it as is. But being identical to
> the character isn't a goal per se. In particular, if switching to more
> generic code is possible and makes the code smaller and/or more
> readable and/or more maintainable, we definitely want to consider that,
> even if this changes the output slightly for some chips.
> 
Ok, makes sense.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
