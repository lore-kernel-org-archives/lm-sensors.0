From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 16 Jul 2008 16:51:35 +0000
Subject: Re: [lm-sensors] superio lock coordinator
Message-Id: <20080716185135.1a5d8b9b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <487C5810.3030205@gmail.com>
In-Reply-To: <487C5810.3030205@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 16 Jul 2008 09:44:02 -0600, David Hubbard wrote:
> Hi Jim,
> 
> On Wed, Jul 16, 2008 at 1:25 AM, Jean Delvare <khali@linux-fr.org> wrote:
> >> >> David,
> >> >> do you have a preference wrt fn-ptr ? and if so, a single fn with 1 arg
> >> >> :  0,1,2 for enter/exit/query ?
> >> >> do you have any use for a flag bit ?  is there generality in it ?
> >>
> >> I think we could just use the same enter and exit sequences for
> >> everything, and not make it customizable. Does that sound OK?
> >
> > No. We can have a universal exit sequence, but enter sequences are
> > per-chip (or actually per chip family). That's even one part of the
> > device identification (lets us differentiate between two chips with the
> > same device ID register value.)
> 
> I think a fn-ptr would be fine. The function could take as an arg
> enter/exit/query (0, 1, 2) and a pointer to a byte array with offset,
> value, offset, value pairs. So I see the function having 3 args:
> 
> void (* fn-ptr)(int which, char * sequence, int sequence_max_length);

I'm lost. I thought that we had just agreed that the exit sequence
would be universal? Also, what is the "query" sequence supposed to be?

Then I don't get the prototype of the function. Who would be calling
it? And who would provide the parameters? The enter sequence is a set
of number being written to a port. It is a per-chip thing (or
per-family) thing. So there are 2 possibilities:

* For each known chip or family, you store the enter sequence in an
  array, and the superio driver iterates over it. This is the approach
  taken in both isadump and sensors-detect.

OR

* For each known chip or family, you store a function, which the
  superio driver calls. The prototype of such a function would be
  something like:
  void (*enter)(int index_port, int data_port);
  This is more flexible, but at this point I have no reason to
  believe that this is needed.

Hmmm, I thought I had said I would let someone else work on this...

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
