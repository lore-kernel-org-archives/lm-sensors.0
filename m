From: =?ISO-8859-1?Q?=C9ric_Piel?= <eric.piel@tremplin-utc.net>
Date: Tue, 03 Nov 2009 13:25:18 +0000
Subject: Re: [lm-sensors] [RFC PATCH 09/10] lis3: Scale output values to mg
Message-Id: <4AF02F3E.7030309@tremplin-utc.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1257250185-7929-10-git-send-email-samu.p.onkalo@nokia.com>
In-Reply-To: <1257250185-7929-10-git-send-email-samu.p.onkalo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Op 03-11-09 13:32, Daniel Mack schreef:
> On Tue, Nov 03, 2009 at 01:30:07PM +0100, samu.p.onkalo@nokia.com wrote:
>>> On Tue, Nov 03, 2009 at 02:09:44PM +0200, Samu Onkalo wrote:
>>>> Report output values as 1/1000 of earth gravity.
>>> Without having tried that, I assume that changes the values 
>>> for all events reported? That would break all userspace 
>>> clients of this device, right?
>>>
>> Yes. That is one thing which need to agreed here. One possibility is to
>> implement this as a configurable feature for example using platform data.
>> In that kind of solution default value must be the old way.
> 
> Yes please :)
> 
Hello,
Actually we had already briefly discussed this with Samu. And I had
given my green light because:
 * I don't know any userspace program which would be affected by this
change (they only rely on the relative difference). Arguably, I know
only few programs.
 * Eventually, we should converge to a userspace API compatible with any
accelerometer device and exposed by all the accelerometer drivers. So
for now I consider the userspace interface of the lis3 driver quite
"soft", and any move toward this goal good.
 * Having platform data to select between old unit/new unit will add
complexity to the driver, which should be avoided whenever possible.

Of course, if you come and tell me that you know some userspace programs
which will be affected by this change, this blows away the first point.
Then I'd be much more willing to have a configurable option. But be
aware that these programs would then blow away themselves if, for
example, they expect a LIS302DL and the actual sensor is a LIS3LV02DL.
So simply fixing these programs and moving to mG might be a better option.

See you,
Eric

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
