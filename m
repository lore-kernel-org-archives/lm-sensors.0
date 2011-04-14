From: Mike Waychison <mikew@google.com>
Date: Thu, 14 Apr 2011 19:00:49 +0000
Subject: Re: [lm-sensors] [PATCH v5 1/2] Use "request_muxed_region" in it87
Message-Id: <BANLkTinR53LO7HWMWoquKY5D+Aprs2OEWw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302641290-30212-1-git-send-email-natg@google.com>
 <1302641387-30264-1-git-send-email-natg@google.com> <20110413070259.GE4070@infomag.iguana.be>
 <20110413102947.3bf1cc88@lxorguk.ukuu.org.uk>
In-Reply-To: <20110413102947.3bf1cc88@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Wim Van Sebroeck <wim@iguana.be>, Nat Gurumoorthy <natg@google.com>, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org

On Wed, Apr 13, 2011 at 4:29 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Wed, 13 Apr 2011 09:03:00 +0200
> Wim Van Sebroeck <wim@iguana.be> wrote:
>
>> Hi Nat,
>>
>> > + =A0 (void) request_muxed_region(REG, 2, NAME);
>>
>> Why do we need to typecast this? Can't we just use
>> + =A0 =A0 request_muxed_region(REG, 2, NAME);
>
> We really ought to use
>
> =A0 =A0 =A0 =A0if ()
>
> in theory the request can fail if someone has hogged the resource and not
> muxed it. I'm not clear what the right thing to do in that case is -
> given it should never happen I guess log an error and bail out but that's
> a rather bigger change and perhaps should be a follow up patch ?
>

request_muxed_region() is sorta gross:  it's essentially acting like a
lock, meant to be used for short periods of time, but it can fail if
someone else decides it should.

Would it make more sense to have drivers that need to use the current
request_muxed_region() be able to force a region into a mux-only state
at driver init?  That would lead to much less contorted code to handle
the off-chance that the request_muxed_region() fails.

Ie:

Driver init:

if (!request_muxed_region(base, size, DRV_NAME))
   goto cleanup_driver_init_failed;

Driver cleanup

release_muxed_region(base, size); /* returns void */

And then within drivers:

use_muxed_region(base, size); /* sleeps until region is usable --
returns void */
/* Do stuff */
unuse_muxed_region(base, size); /* returns void */



I realize the above example re-uses the 'request_muxed_region()' name,
but at least this would be much more consistent with how
request_region is used in other drivers.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
