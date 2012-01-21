From: Tom Gundersen <teg@jklm.no>
Date: Sat, 21 Jan 2012 18:12:14 +0000
Subject: Re: [lm-sensors] w83627ehf can not be modprobed as of 3.3-rc1
Message-Id: <CAG-2HqWekOBXd+b0+PPQ6+EHT1eAvubgSEmsXfWP16p6MKv+DA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAG-2HqVsLbpTrUAJ06AU-9_rOjQtkHap1ygYqpH_RBfM5ESb6w@mail.gmail.com>
In-Reply-To: <CAG-2HqVsLbpTrUAJ06AU-9_rOjQtkHap1ygYqpH_RBfM5ESb6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Jan 21, 2012 at 6:55 PM, Ian Dobson <i.dobson@planet-ian.com> wrote:
> Normally the kernel command line "acpi_enforce_resources=lax" gets around
> the problem (BIOS marking the hw chip IO addresses as being owned by the
> BIOS).
> I know this was deprecated a few versions ago, so maybe it's been disabled
> in 3.3

I have not been using that parameter (nor any other non-standard ones).

Cheers,

Tom

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
