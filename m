From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:32 +0000
Subject: lm_sensors2/kernel/busses i2c-amd756.c
Message-Id: <3CCEF435.4AA20CB@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020430163839.C262A869FF@primary.mx.nitric.com>
In-Reply-To: <20020430163839.C262A869FF@primary.mx.nitric.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I don't have any confidence in any of the code WRT locking / reentrancy /
simultaneous access. 

I don't know of specific problems but I haven't seen anything
that describes how the design avoids these problems either.

merlin wrote:
> 
> On this note, I was wondering if there are perhaps some
> reentrancy problems with the sensors code. It may just
> be that the AMD 756 is 'delicate', but the problem I
> see is that sensors will run fine for months on end, as
> long as there is just one process periodically reading
> the sensors. As soon as I introduce a second process
> (e.g., sensord with cron-based rrd logging), things
> eventually fall over (collisions, timeouts, smbus death,
> need to reboot for sensors to work again).
> 
> Currently, our locking seems to be based around the
> fact that the chip will report itself 'busy' if another
> process is using it and in schedule_timeout(). Is
> there a higher-level lock somewhere else? If not,
> should there be?
> 
> Another reproducible problem, that may just be a
> side-effect of the abort code I introduced, is that if
> I ^C a process reading the sensors (e.g., cat
> /proc/sys/dev/sensors/*/*) then it is not uncommon for
> timeout/smbus death to occur. I presume that
> schedule_timeout() will return early (interrupt) and
> things may go downhill from there. Could other
> interrupts cause similar problems?
> 
> As I say, it may be a local problem; I'm just seeking
> input.
> 
> Thanks, Merlin
> 
> r/author@mordac.netroedge.com/2002.04.30/08:55:30
> >Update of /home/cvs/lm_sensors2/kernel/busses
> >In directory mordac.netroedge.com:/tmp/cvs-serv22535
> >
> >Modified Files:
> >       i2c-amd756.c
> >Log Message:
> >mh: Increase AMD 7x6 timeout to 500ms from 100ms, add code to
> >abort/clear the bus on timeout. Appears? to improve reliability.
