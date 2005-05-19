From: lists@edeca.net (David Cannings)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: w83697hf -12v readings
Message-Id: <41D2A2F9.9060000@edeca.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <41D28D44.5080900@edeca.net>
In-Reply-To: <41D28D44.5080900@edeca.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi David,
>> > Does the BIOS display values for -12V and -5V? If it does, what are 
>> > they?
>> No, it does not, I hadn't noticed this.  It does display values for
>> Vdimm and Vio though which aren't in sensors.
> Don't you come to a conclusion at this point? ;)

I did, but I didn't think that they were because the values were way
out.  I hadn't considered the compute lines, though.

> What sensors think are -12V and -5V have to be Vdimm and Vio. Edit
> /etc/sensors.conf:
>     label in5 "Vdimm"
>     label in6 "Vio"

For the sake of the archives, these are the wrong way round (switch
Vdimm with Vio).  The notes in sensors.conf are correct.

> Comment out the compute in5 and in6 lines.
>     set in5_min 3.3 * 0.95
>     set in5_max 3.3 * 1.05
>     set in6_min 2.5 * 0.95
>     set in6_max 2.6 * 1.05

This is correct, for the Epox 4SDM2+ the value should be 2.6 (as
suggested in sensors.conf).

> Run sensors -s && sensors, see what it looks like. And adjust the limits
> afterwards if needed.

I now have the correct values for Vio and Vdimm (similar to those
reported by the BIOS), thank you.  My V5SB and Vbat appear to be correct
without swapping them, however, which is suggested in sensors.conf.

> We may add specific notes for your board if you share your experience
> once you get the correct configuration values.

A complete summary of what I have done for my sensors is below:

For Epox 4SDM2+, changes to /etc/sensors.conf, all in section for
"w83697hf-*":

  - Change 1.8 in "set in0_min" and "set in0_max" to 1.75, for a 1.75v
    core

  - Replace in5 and in6 limits with (for Vio and Vdimm):

    set in5_min 3.3 * 0.95
    set in5_max 3.3 * 1.05
    set in6_min 2.5 * 0.95
    set in6_max 2.6 * 1.05

  - Change labels to:

    label in5 "Vio"
    label in6 "Vdimm"
	
  - Comment "compute in5" and "compute in6" lines, do not swap in7 for
    in8 as suggested as V5SB/VBat appear to be correct by default.

Thanks for your help Jean,

David
