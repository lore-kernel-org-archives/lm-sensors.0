From: morris@wolfman.com (Jim Morris)
Date: Thu, 19 May 2005 06:23:58 +0000
Subject: soloution to tickets 1263 & 1223
Message-Id: <20030608144450.63F0.MORRIS@wolfman.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EE39074.8020804@wolfman.com>
In-Reply-To: <3EE39074.8020804@wolfman.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

You are welcome...

However be warned that this means no bytes can be written that are
greater than 0x7F using the outb function.

The actual bug appears to be that the isa scanning routine is passing in
bytes that have values greater than 0xFF, which means they are not bytes.
However & 0xFF does not fix the error in the outb routine.

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
