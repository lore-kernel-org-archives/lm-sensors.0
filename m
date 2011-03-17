From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 17 Mar 2011 08:26:57 +0000
Subject: Re: [lm-sensors] Call for 3.3.0
Message-Id: <4D81C5D1.8090904@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110316224142.0493f53b@endymion.delvare>
In-Reply-To: <20110316224142.0493f53b@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 03/16/2011 10:41 PM, Jean Delvare wrote:
> Hi all,
>
> Last release of lm-sensors (3.2.0) was in October 2010, 5 months ago.
> The list of changes since then is getting large, so it's time for a new
> release. The changes are important enough that I would go for 3.3.0
> rather than 3.2.1 as originally planned.
>
> This decision is motivated by the long list of new attributes and even
> new sensor types handled by libsensors and sensors. Other changes worth
> mentioning are Guenter's generic code to display limit values in
> "sensors", the removal of some arbitrary limits in libsensors attribute
> enumeration code, and the usual addition of many new devices to
> sensors-detect.
>
> The planned schedule is as follows:
> * Saturday, March 19th, 2011: SVN freeze

I have not been able to make time yet to add detection of the new
models handled by f71882fg, in as far as they are not already
present (some probably are haven't checked). I think it would be
good to have this in place before 3.3.0. Note I cannot test
these changes, so they might as well be done by someone else
(hint hint).

Here are the new models supported by the f71882fg driver:

device-id  device-name     Fintek model
0x0814     f71869          F71869F + F71689E (register compatible)
0x0901     f71808e         F71808E
0x0909     f71889ed        F71889ED

And here is a bunch of new models I've datasheets for, but
no requests to support yet, and no support yet:

device-id  device-name(*)  Fintek model
0x1001     f71808a         F71808A
0x1007     f71869a         F71869A
0x1005     f71889a         F71889A

And some more, special models with 6 uarts, but also with
hwmon function:

device-id  device-name(*)  Fintek model
0x0704     f81865f         F81865F
0x1010     f81866d         F81866D

Wrt device-name versus Fintek model, this of course is the same
everywhere, except for the f71869 special case which is why I've
differentiated between the 2 in the above table. The LDN value for
the hwmon part for all of these is 4.

(*) In these cases the device name is not set in stone yet,
as there is no driver support yet.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
