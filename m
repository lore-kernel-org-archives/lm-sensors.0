From: morris@wolfman.com (Jim Morris)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: soloution to tickets 1263 & 1223
Message-Id: <20030609231155.3A3C.MORRIS@wolfman.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EE39074.8020804@wolfman.com>
In-Reply-To: <3EE39074.8020804@wolfman.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I stumbled on the actual problem here :)

Redhat 9 set the LANG to US_en- UTF8

Th eoperative word here is UTF8, which means that characters are not
always one byte. Also I think there is a bug in th eversion of perl they
ship, so the pack "C", $_[1] is taking an 16 bit character (which should be
one byte) and compalins of an overflow error.

Many programs are suffering from this bug it seems.

I'm not sure of the solution to your script, except the work around is
probably not the patch I sent you, but instead to do an export
LANG=US_en before running your script.

Probably everything that calls outb should check it is sending a byte
not a char. Or put a warning about redhat9 in the Readme or FAQ.

I would actually recommend you take out the patch I sent.


On Sun, 08 Jun 2003 16:19:59 -0400
"Mark D. Studebaker " <mds@paradyne.com> wrote:

mds> 
mds> checked in.
mds> thank you very much.
mds> 
mds> Jim Morris wrote:
mds> > This seems to happen on newer perl versions. It is fatal in as much as 
mds> > the sensors are not detected. The solution appears to be to simply add & 
mds> > 0x7f to the pack statement at line 1138 of sensors_detect...
mds> > 
mds> > sub outb
mds> > {
mds> >   my $towrite = pack( "C", $_[1] & 0x7f);
mds> > 
mds> > 
mds> > hope this helps
mds> > 
mds> 

--
Jim Morris morris@wolfman.com
