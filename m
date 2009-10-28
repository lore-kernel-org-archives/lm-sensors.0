From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 28 Oct 2009 09:32:15 +0000
Subject: Re: [lm-sensors] [PATCH 2/4] hwmon-f71882fg: Cleanup sysfs attr
Message-Id: <20091028103215.67cc9d28@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4AE02F3A.3000608@redhat.com>
In-Reply-To: <4AE02F3A.3000608@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 28 Oct 2009 10:26:00 +0100, Hans de Goede wrote:
> > As a side note, I don't think "fxxxx_fan_attr" or
> > "&fxxxx_fan_attr[0][0]" make any difference.
> >
> 
> I would expect the type of fxxxx_fan_attr to be a *foo[] and not a *foo,
> and thus to get a compiler warning, but you might be right, I didn't try.

Hmm, you're right, I get a warning with fxxxx_fan_attr. Apparently I
lost an opportunity to keep my mouth closed ;)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
