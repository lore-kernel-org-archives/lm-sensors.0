From: info@wore.ma.cx (woremacx)
Date: Sat, 07 Jan 2006 00:43:29 +0000
Subject: [lm-sensors] LPC47M192 HW Monitoring Block
Message-Id: <492ed3850601061643o16846bealde50b12418d5041e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060104182313.15922.qmail@web81009.mail.mud.yahoo.com>
In-Reply-To: <20060104182313.15922.qmail@web81009.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

My code for 2.4 kernel is working since April 2005.
You can fetch temp and volts with my code.

get the attached file, compile, and modprobe it:
http://archives.andrew.net.au/lm-sensors/msg31005.html

Regards,
wore

On 1/7/06, Rudolf Marek <r.marek at sh.cvut.cz> wrote:
> blabuard wrote:
> > Hello, I'm interested in the status of the LPC47M192
> > chip, in particular, thermal info.
> >
> > I saw in the lm-sensors archives that Tomas Holmqvist
> > and "wore" each had written hardware monitor block
> > code (similiar chip and 2.4 respectively), but it
> > seems to dead-end Mar/Apr of 2005.  Following "wore's"
> > post
> > (http://archives.andrew.net.au/lm-sensors/msg30964.html),
> > I can use i2cdump to raw read the temperature data of
> > this chip.
> >
> > Is anyone aware of any progress to support the thermal
> > data of LPC47M192, probably via smsc47m1?
>
> Well to me seems not. So Wore and Tomas any news?
>
> Thanks
> Regards
> Rudolf
>

