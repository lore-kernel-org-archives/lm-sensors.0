From: Natarajan Gurumoorthy <natg@google.com>
Date: Wed, 13 Apr 2011 08:15:33 +0000
Subject: Re: [lm-sensors] [PATCH v5 1/2] Use "request_muxed_region" in it87
Message-Id: <BANLkTimE4sNw1it8-te9Hk+earOVd6NeUg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302641290-30212-1-git-send-email-natg@google.com>
	<1302641387-30264-1-git-send-email-natg@google.com>
	<20110413070259.GE4070@infomag.iguana.be>
In-Reply-To: <20110413070259.GE4070@infomag.iguana.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, Mike Waychison <mikew@google.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org

Wim,
      Old habits die hard. I will get rid of it and ship out a new patch.

Regards
Nat


On Wed, Apr 13, 2011 at 12:03 AM, Wim Van Sebroeck <wim@iguana.be> wrote:
> Hi Nat,
>
>> + =A0 =A0 (void) request_muxed_region(REG, 2, NAME);
>
> Why do we need to typecast this? Can't we just use
> + =A0 =A0 =A0 request_muxed_region(REG, 2, NAME);
>
> Kind regards,
> Wim.
>
>
>



--=20
Regards
Nat Gurumoorthy AB6SJ

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
