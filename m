From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: lm_sensors on ThinkPads
Message-Id: <3E2C7FAC.F9B5D5FF@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020927134750.B20006@Stimpy.netroedge.com>
In-Reply-To: <20020927134750.B20006@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The AT24RF08 _is_ the RFID chip.
It's really one of a kind.
See datasheet link in README.thinkpad.

Philip Edelbrock wrote:
> 
> Related side note- Could I get some clarification (from anyone reading
> who may know) on the vulnerable hardware?
> 
> The trouble, if I remember/understand correctly, wasn't that our code
> eats RFID chips, but it was the particular Atmel chip (AT24RF08?) which
> had a broken state machine which interprets I2C commands incorrectly
> under certain circumstances.  Are newer Atmel chips safe?  Are other
> RFID chips safe?  At one point, we thought that only a handful of older
> Thinkpads used the defunct vulnerable Atmel chip, and that any others
> using other chips were safe.
> 
> Just curious where our current understanding is at these days on this
> sensitive topic.
> 
> Phil
> 
> Jean Delvare wrote:
> 
> >>I've asked about the RFID EEPROM, and I'll check around to see if any
> >>of the Netvistas also have it.
> >>
> >>The document Jean was referring to is here:
> >>
> >>http://www-1.ibm.com/support/docview.wss?uid=psg1MIGR-45120
> >>
> >>You can also find it by searching the IBM site for 'identify ibm
> >>thinkpad'.
> >>
> >>It describes how to identify which model of ThinkPad you are on using
> >>the BIOS Build ID, and has a table with it.
> >>
> >>Hope it helps some.
> >>
> >>
> >
> >Actually, it could be the thing we are looking for for three years now.
> >As said before (if I remember correctly), the table described in this
> >document is rather easy to locate and decode. So the only missing step
> >is to be able to have a match between the first two caracters of the
> >BIOS build ID (HR, HV, HX...) and the presence or absence of the RFID in
> >the given model. Maybe it is a bit more complicated (if the presence
> >depends on something else) but it is definitely the base we need to
> >start with.
> >
> >Then we would also need the same for non-Thinkpad IBM systems (Netvista,
> >that is).
> >
> >Again, thanks a lot for your good work so far. We have never been this
> >near from the solution, methinks.
> >
> >
> >
