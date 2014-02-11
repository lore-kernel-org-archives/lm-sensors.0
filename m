From: Laszlo Papp <lpapp@kde.org>
Date: Tue, 11 Feb 2014 09:14:44 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (max6650) Rename the device ids to contain the hwmon suffix
Message-Id: <CAOMwXhMjEVNmLmNe_9dczkWdNhh4yjDXU9C0Xo0Euniu-O6eAQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392045953-26596-1-git-send-email-lpapp@kde.org>
	<20140210160842.GB26997@lee--X1>
	<20140210173811.04ba5964@endymion.delvare>
	<CAOMwXhPTkrUUaUL-H_0fvZBO9_kt4jqKXs5BJYthDfu0_1c3xg@mail.gmail.com>
	<20140211085014.4ef32b56@endymion.delvare>
	<CAOMwXhMhKdp420+SPTih+C3fAgTmrpJgPnGBxsfPO3pEhESGTA@mail.gmail.com>
	<20140211085053.GD32042@lee--X1>
	<CAOMwXhPfmXDKcov_+HHDTCaieGDiMEi+6CV_OnYDM3c8+S+bfA@mail.gmail.com>
In-Reply-To: <CAOMwXhPfmXDKcov_+HHDTCaieGDiMEi+6CV_OnYDM3c8+S+bfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>
Cc: Jean Delvare <jdelvare@suse.de>, LKML <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

On Tue, Feb 11, 2014 at 8:58 AM, Laszlo Papp <lpapp@kde.org> wrote:
> On Tue, Feb 11, 2014 at 8:50 AM, Lee Jones <lee.jones@linaro.org> wrote:
>>> >> On Mon, Feb 10, 2014 at 4:38 PM, Jean Delvare <jdelvare@suse.de> wrote:
>>> >> > Additionally, dashes are explicitly forbidden in hwmon
>>> >> > device names.
>>> >>
>>> >> Also, where is that documented?
>>> >
>>> > In Documentation/hwmon/sysfs-interface:
>>> >
>>> > *********************
>>> > * Global attributes *
>>> > *********************
>>> >
>>> > name            The chip name.
>>> >                 This should be a short, lowercase string, not containing
>>> >                 spaces nor dashes, representing the chip name. This is
>>> >                 the only mandatory attribute.
>>> >                 I2C devices get this attribute created automatically.
>>> >                 RO
>>>
>>> Time to revisit this decision....
>>>
>>> So, based on the fact that children device names usually contain
>>> dashes, I do not understand why hwmon would be any special in this
>>> regard. It is possible that the hwmon developers have not faced much
>>> MFD situation before, and so, this was not considered to be handled
>>> like in other subsystems.
>>>
>>> I am proposing to change this "rule"...  Any objection?
>>
>> Prior to proposing such an invasive change which is highly likely to
>> come up against heavy opposition,
>
> It is possible that someone does not understand why you think it may
> be invasive, right? Could you please explain the reason for that?

Perhaps you think I would like to refactor all the existing
interfaces? That would be intrusive yes, but changing rules is
orthogonal to keeping compatibility in my opinion. It would be
possible to sanitize this for the feature and make consistent with
other subsystems while keeping the old drivers around as they are.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
