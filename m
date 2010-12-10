From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 10 Dec 2010 17:37:14 +0000
Subject: Re: [lm-sensors] [PATCH v2] lm-sensors: Add support for new hwmon
Message-Id: <20101210173714.GA12627@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1278567813-9608-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1278567813-9608-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Dec 09, 2010 at 03:31:30PM -0500, Jean Delvare wrote:
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
Related question: When making libsensors API changes, do I update the API version
to 4.3.2, or stick with 4.3.1 ?

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
