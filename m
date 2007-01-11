From: vz-sensors@zeitlins.org (Vadim Zeitlin)
Date: Thu, 11 Jan 2007 19:56:13 +0000
Subject: [lm-sensors] FB-DIMM temperature
Message-Id: <E1H5621-0003wW-00@smtp.tt-solutions.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <45A65914.6040302@assembler.cz>
In-Reply-To: <45A65914.6040302@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 11 Jan 2007 17:57:38 +0100 Rudolf Marek <r.marek at assembler.cz> wrote:

RM> >  FWIW, I've opened the box to try to cool the DIMMs a bit and now the
RM> > results are
RM> > 
RM> > 	# ./fbdt
RM> > 	Intel sig at 0: 1d 11
RM> > 	Current temp is: 65.000000C
RM> > 	Intel sig at 16: 1d 11
RM> > 	Current temp is: 0.000000C
RM> > 	Intel sig at 32: 1d 11
RM> > 	Current temp is: 52.000000C
RM> > 	Intel sig at 48: 1d 11
RM> > 	Current temp is: 54.000000C
RM> > 
RM> > so not only the values did diminish but there is also 54 instead of 0 for
RM> > the last one.

 I think I know at least why the temperature is sometimes 0: it's a timing
issue, apparently you can't read the sensors too quickly. If I insert
usleep(1000) between access to the signature bytes and the temperature value,
I can reliably read non zero values. I also looked at the values of the other
registers described in the section 14.5.3 of Intel datasheet, here is the
full output:

	Sig at 0: 1d 11
	Device id: 80 04
	TEMPLO:         106.00C
	TEMPMID:        109.00C
	TEMPHI:         124.00C
	TEMPSTAT:       0x1
	TEMP:           68.50C
	Sig at 16: 1d 11
	Device id: 80 04
	TEMPLO:         106.00C
	TEMPMID:        109.00C
	TEMPHI:         124.00C
	TEMPSTAT:       0x1
	TEMP:           68.00C
	Sig at 32: 1d 11
	Device id: 80 04
	TEMPLO:         106.00C
	TEMPMID:        109.00C
	TEMPHI:         124.00C
	TEMPSTAT:       0x1
	TEMP:           59.00C
	Sig at 48: 1d 11
	Device id: 80 04
	TEMPLO:         106.00C
	TEMPMID:        109.00C
	TEMPHI:         124.00C
	TEMPSTAT:       0x1
	TEMP:           63.50C

So, assuming I interpret TEMPLO/MID/HI correctly (I also divided their
values by 2 to get the temperature in degrees Celsius), it really does look
that these DIMMs are supposed to run quite hot.

 Please let me know if I'm wrong (before I fry them :-),
VZ


