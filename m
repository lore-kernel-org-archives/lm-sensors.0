From: Natarajan Gurumoorthy <natg@google.com>
Date: Tue, 12 Apr 2011 15:46:26 +0000
Subject: Re: [lm-sensors] [PATCH v4 1/2] Use "request_muxed_region" in it87
Message-Id: <BANLkTikFr+7duu71=yB2rVBKx1SBkmggqg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302565858-23849-1-git-send-email-natg@google.com>
	<1302565974-23906-1-git-send-email-natg@google.com>
	<20110412124155.36787390@lxorguk.ukuu.org.uk>
In-Reply-To: <20110412124155.36787390@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, Wim Van Sebroeck <wim@iguana.be>, Mike Waychison <mikew@google.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org

Alan,
      I looked at your code in kernel/resource.c and I agree the while
is not needed. I guess every time it comes back from "schedule" your
code loops back to reserve the region. I will test the code without
the while and make the needed change.

Regards
Nat

On Tue, Apr 12, 2011 at 4:41 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> + =A0 =A0 while (!request_muxed_region(REG, 2, NAME))
>> + =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> +
>
> This shouldn't need the loop ? - is it only working with the loop
> present ?
>
>
> Otherwise this looks good - I'd just like to understand if the loop was
> needed (indicating a bug has crept into the muxed alloc code somewhere
> perhaps) or not
>
> Alan
>



--=20
Regards
Nat Gurumoorthy AB6SJ

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
