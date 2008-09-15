From: "Andrew Paprocki" <andrew@ishiboo.com>
Date: Mon, 15 Sep 2008 16:54:09 +0000
Subject: Re: [lm-sensors] it8712 rev 7; fan speeds reported incorrectly.
Message-Id: <76366b180809150954jb28fa7br2bc6b7bd614b925@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <9F6ACAE02B6DD040A1E259977622CFDB03E26A54@oslexcp1.eu.tandberg.int>
In-Reply-To: <9F6ACAE02B6DD040A1E259977622CFDB03E26A54@oslexcp1.eu.tandberg.int>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Sep 15, 2008 at 10:28 AM, Jean Delvare <khali@linux-fr.org> wrote:
>> The following hack fixes it - it just punts 16 bit fan support out to
>> rev8. It would appear our it8172 does not have 16 bit tacho support. Or
>> if it does, the driver isn't enabling it properly.
>
> Thanks for reporting. I don't have access to my collection of IT87xx
> datasheets and personal notes on chip revisions, so I can't check
> now. I will check when I am back home. Andrew, what do you think?

Hmm.. My hardware was a rev 8, so I was just guided by the datasheets.
The datasheet indicated that rev 7 supported the same 16-bit tach
capability, but maybe it is different in some way. I have the PDF
files at home, so I'll take a look later today. Since I don't have the
hardware, it might be easiest to just modify the 16-bit support to
check for rev 8 instead of rev 7 and be done with it. I'm not sure if
the location in the patch is the only place that needs to be modified
until I can look at the code again.

-Andrew

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
