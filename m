From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 12 Mar 2010 10:39:44 +0000
Subject: Re: [lm-sensors] Wrong temperatures reported for Core2Duo CPU in
Message-Id: <20100312113944.4bbedb14@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <781687b2e6d2a27726f35a316f5bf821.squirrel@webmail.nodivisions.com>
In-Reply-To: <781687b2e6d2a27726f35a316f5bf821.squirrel@webmail.nodivisions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Fri, 12 Mar 2010 10:40:48 +0100, Luca Tettamanti wrote:
> On Wed, Mar 10, 2010 at 7:10 PM, Jean Delvare <khali@linux-fr.org> wrote:
> > On Wed, 10 Mar 2010 08:41:52 -0800, lmsensorslist@nodivisions.com wrote:
> >> OK, I just tested this, by running the "stress" command for a few minutes,
> >> until the coretemp values were 91C and 92C.  I then immediately shut down
> >> and went into the BIOS.  Here's the BIOS numbers:
> >>
> >> 68C CPU Die/Package Temperature
> >> 54C Motherboard Temperature
> >> 44C Motherboard Temperature
> >> 82C ICH Temperature
> >> 58C MCH Temperature
> >>
> >> And here's the same BIOS numbers after sitting there in the BIOS for 10
> >> minutes:
> >>
> >> 63C CPU Die/Package Temperature
> >> 50C Motherboard Temperature
> >> 44C Motherboard Temperature
> >> 83C ICH Temperature
> >> 54C MCH Temperature
> >>
> >> I guess the die temp is the one that corresponds to the CPU?
> >
> > Yes, it probably comes from the CPU internal sensors, although only
> > disassembling the BIOS could tell for sure.
> 
> From my experience on Asus boards the "CPU" temperature shown in the
> BIOS is usually read from the external monitoring chip, and only
> rarely from the CPU itself (using PECI - with a totally wrong tjmax -
> sigh).

Yes, but this is an Intel board here, with the QST thing, so I wouldn't
rely on the usual assumptions.

> The ICH temperature is also suspiciously high.

Indeed.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
