From: Frank Myhr <fmyhr@fhmtech.com>
Date: Fri, 15 Aug 2008 15:40:42 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon-vid: Fix AMD K8 VID decoding
Message-Id: <48A5A37A.4050501@fhmtech.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080815105805.5d8231ce@hyperion.delvare>
In-Reply-To: <20080815105805.5d8231ce@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> > Hi Frank,
> >
> > On Fri, 15 Aug 2008 08:00:13 -0400, Frank Myhr wrote:
>> >> Jean Delvare wrote:
>>> >>> -	case 24:		/* AMD NPT 0Fh (Athlon64 & Opteron) */
>>> >>> +	case 24:		/* Athlon64 & Opteron */
>>> >>> +		val &= 0x1f;
>>> >>> +		if (val = 0x1f)
>>> >>> +			return 0;
>> >> Nice catch that all bits set is an error (voltage "off", impossible if code is
>> >> running) for the 5-vid-bit cpu's but not the 6-vid-bit ones in case 25
> >
> > Not necessarily impossible. Think of hot-pluggable CPUs...

Good point! I've got to try harder to think outside my particular box...


> >
>>> >>> +				/* fall through */
>>> >>> +	case 25:		/* AMD NPT 0Fh */
>>> >>>  		val &= 0x3f;
>>> >>>  		return (val < 32) ? 1550 - 25 * val
>>> >>>  			: 775 - (25 * (val - 31)) / 2;
>> >> The above formula is correct, and I'm the one who put it here in this
form. But
>> >> in looking at AMD cpu specs yesterday I came across:
>> >>
>> >> AMD 31116, BIOS and Kernel Developer's Guide (BKDG) For AMD Family 10h
Processors
>> >>
http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/31116.PDF
>> >> section 2.4.1.5.2, p. 30
>> >>
>> >> This gives the canonical formula for K10's, which happens to be the same
as for
>> >> the 6-vid-pin K8's:
>> >>
>> >> return (val >= 0x20) ? (7625 - 125 * (val - 0x20)) / 10
>> >> 	: 1550 - 25 * val;
>> >>
>> >> This gives the same result and is easier to compare with the AMD reference
>> >> above. Perhaps we should make this change, I'll leave it up to you.
> >
> > Why not, but let's not push this now. We're already late in the release
> > cycle, all we want to do at this point is fix regressions in the code.
> >
> > So, feel free to send an incremental patch changing the formula in the
> > code; we can have this in kernel 2.6.28.

Makes sense to me. I'll plan to submit patch against released 2.6.27.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
