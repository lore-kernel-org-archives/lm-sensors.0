From: mchehab@brturbo.com.br (Mauro Carvalho Chehab)
Date: Thu, 27 Oct 2005 14:03:42 +0000
Subject: [lm-sensors]
Message-Id: <1130414559.6751.26.camel@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <87ekb9s3tn.wl%info@wore.ma.cx>
In-Reply-To: <87ekb9s3tn.wl%info@wore.ma.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Em Qua, 2005-10-26 ?s 22:46 +0200, Jean Delvare escreveu:
> Hi Mauro,
> 
> > Please don't send this patch to Andrew or mainstream. I'll apply it on
> > my tree and I will send it at the end my patchset series, for not
> > breaking these.
> 
> Fine with me, as long as it ultimately gets done.
	Good! As I said, our plan is to keep it updated and we are including
several new boards on 2.6.15 (merging and fixing several kernel drivers
developed outside V4L), and there are already some newer i2c ids on
current CVS and there are more to come.
> 
> My motivation for this cleanup is that I plan to work soon on a new way
> for drivers to instantiate i2c "clients". This new way will most
> certainly require i2c IDs, so I need to have an accurate view of how
> these are currently used. Having them centralized, as they were
> supposed to be in the first place, should make my analysis easier, and
> should reduce the risk to get things wrong.
	For sure!
> 
> Note that the new client instantiation method should suit the
> media/video drivers needs much better than the old "general probing"
> way did (which, with the RTC drivers, is actually the reason why I want
> to implement this). I'll make sure to CC you and the v4l list on my
> proposal to get your feedback.
	Ok. We all have to win with this. We've created an experimental area at
V4L tree for testing purposes. Maybe we can create a branch there to
test the newer I2C core interfaces and improve it, without breaking the
current development.
	From V4L side of view it would be better if we wait until 2.6.17 for
the newer I2C core, since, our goal to 2.6.15 is to include, with
experimental status, several newer boards like: em28xx based USB boards
(already on V4L tree), WinTV PVR USB2, ivtv and maybe usbvision. 2.6.16
should be reserved for bug fixing these devices and cleaning up USB
stuff. IMHO, it is not a good idea to change I2C interface during the
merging stuff (since lots of efforts should be made to fix
incompatibitilies and having them all using almost the same
CodingStyle).
> 
> > I have several patches that are including newer IDs on
> > linux/media/i2c-id.h and I'm just preparing a patch, on V4L tree, to
> > remove this file from kernel.
> 
> I guess we must read this as: adding news IDs to linux/i2c-id.h, and
> removing the media/id.h file?
	Yes :-)
> 
> > If this is applied, it may break dozens of patches I've already
> > prepared (at
> > http://www.linuxtv.org/download/video4linux/patches/2.6.14-rc5)
> > 
> > Maybe it would be wiser if patches that touches drivers/media devices
> > maintained on V4L go first to me, and I send to Andrew. This way, it
> > would help us not to redo an entire patchset for fixing broken stuff
> > because they would be included on a wrong order.
> 
> I did send this patch to you and the v4l list two days ago, stating
> that I would send it to Greg quickly. I did not get any answer, so I
> did. When a patch of mine gets in your way, just say so and I'll delay
> it or leave it to you altogether.
	Hmm... I didn't received it.
> I try to CC you an all i2c patches that affect media/video drivers, but
> not all of these can go through your path to Andrew rather than mine.
	We have to take care with this... otherwise some patches will break the
other's patches. 
> Changes to these drivers which are needed because of a change to
> i2c-core or the core i2c structures must obviously be done all at once,
> so I have to handle them. Two such changes are in the works right now,
> the second being Laurent Riffard's .owner and .name cleanup patchset.
> Relevant patches have been sent to the v4l list already.
	This I've received it, but I'm not sure yet how to handle it.

	This patch, if applied before the newer patchsets, will break several
of our patches. Also, since it was generated against -mm and before we
send our patchset, it is not covering all supported cards anymore (we've
included em2820, two new audio decoders and two new video decoders, all
using I2C stuff).

	It would be nice if the patches that touches video stuff were generated
against V4L tree, but it will break submission against Greg's tree.
	Maybe we can define a procedure for these patches, like sending first
to me, then to Greg. I'm open to suggestions.
> 
> Thanks,
Cheers, 
Mauro.

