From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 19 Apr 2007 12:31:34 +0000
Subject: Re: [lm-sensors] [PATCH] k8temp - Add the diode offset to reported
Message-Id: <20070419143134.541103e6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1176736441.14094.31.camel@ustr-shaha1-linux2.na.uis.unisys.com>
In-Reply-To: <1176736441.14094.31.camel@ustr-shaha1-linux2.na.uis.unisys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Amul,

On Tue, 17 Apr 2007 13:49:20 +0000, Amul Shah wrote:
> On Tue, 2007-04-17 at 18:24 +0200, Rudolf Marek wrote:
> > Hello all,
> > 
> > Amul Shah wrote:
> > > This patch adds support to include the CPU diode sensor offset when
> > > reporting CPU temperature.
> > > 
> > > Please see http://www.lm-sensors.org/ticket/2200 for the full problem
> > > description.
> > 
> > Well I dont think this is correct. I believe that diode offset register is
> > related to analog diode output not the digital sensor. Also I know that AMD is
> > using my driver and did not make any changes. This leads me to a conclusion that
> > the sensor simply does not work correctly and this error might be only
> > compensated for analog part and not the digital. IIRC in some errata AMD states
> > that the digital temperature sensor might be wrong and urges users to use the
> > analog output.
> > 
> > What do you think?
>
> Well, I was looking to see what you think. :)  Thanks for the
> information.  I'll go look for the errata and drop that information into
> the ticket.  After that we can close it as works as designed. :)  No
> need to fix what isn't broken.

What CPU version do you have exactly? You may want to take a look at
erratum 154 of document "Revision Guide for AMD Athlon™ 64 and AMD
Opteron™ Processors":
http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/25759.pdf

It mentions a 10 degrees C diode offset error. Only the JH-E6 revision
is affected.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
