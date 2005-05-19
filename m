From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: bt839 and voodoo3
Message-Id: <20020325113739.C31061@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



It's possible that the chip internally always downsamples to 16-bit. 
We'd have to take a look at the datasheet to be sure.  The chip works
by taking the raw pixel information directly from the video chip, so
there isn't multiple versions (that I am aware of) of the same video. 
In other words, if you really have your display set at 24-bit, then
the video chip is sending 24-bit information to the BT869.  In order
for the BT869 to display the data correctly, it must be told that the
input is 24-bit data.  What it does with that data internally (like
decimating it to 16-bit) is not clear to me.  The chip, unfortunately,
is meant to be a cheap and simple chip and not meant for 'serious'
video use.

Here, take a look at the PDF for some more info:

http://www.netroedge.com/~lm78/pdfs/bt869.pdf

It answers more questions, more correctly than I can. ;')


Phil

On Mon, Mar 25, 2002 at 07:04:18PM +0000, Magnus R wrote:
> hello
> I dont get it to work at all at 24bit. it works great in xfree but on
> the tv its defentily 16bit.
> I changed the depth to 24bit but still its 16bit on the tv output...
> Have you got it to work?
> 
> bye
> Magnus
> 
> On Mon, 25 Mar 2002 09:44:39 -0800, phil@netroedge.com said:
> > 
> > Did you try 24 bit?  I think it works.  Make sure that you match your
> > bt869 settings to your current X settings (resolution, depth, etc.).
> > 
> > 
> > Phil
> > 
> > On Sun, Mar 24, 2002 at 09:33:34PM +0000, Magnus R wrote:
> > > hello!
> > > Why does the voodoo3 tv out not support more than 16bit collors? Is
> > > that a hadrware limatation?
> > > in windows it support 24bit.
> > > 
> > > bye
> > > Magnus
> > > -- 
> > > have fun!
> > > Magnus R
> > >   
> > 
> > -- 
> > Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
> >    phil@netroedge.com -- http://www.netroedge.com/~phil
> >  PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
> 
> -- 
> have fun!
> Magnus R
>   

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
