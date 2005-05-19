From: phil@philedelbrock.com (Philip Edelbrock)
Date: Thu, 19 May 2005 06:25:34 +0000
Subject: bt869 driver
Message-Id: <aa1b036b3ef3deb36df5147b796373e2@philedelbrock.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050129234511.5dc19d3b.khali@linux-fr.org>
In-Reply-To: <20050129234511.5dc19d3b.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


On Jan 30, 2005, at 2:07 AM, Jean Delvare wrote:

>> The BT869 seems to fit none of these categories through, seems to be
>> neither a video4linux nor a framebuffer driver from the description,
>> it seems to just export some config stuff via /proc.
>
> I assume you mean the bt869 *driver*, not the BT869 chip. You're right,
> it doesn't follow any standard nor fit in any video subsystem. I think
> it was a hack by Philip Edelbrock to get the things up and working
> quickly. Since he was used to sensor drivers, he naturally wrote the
> bt869 driver in the exact same way.

"Hack"?  Hey, hey!  (Just teasing ;')

Yes, it was a stab at getting the chip working and the lm-sensors  
driver architecture fit like a glove to make it work.  Granted its  
utility is better fitting in a different project, hopefully a video  
related one.

>
>> What is the point of that driver?
>
> Allow people to configure the chip by writing to procfs. As I  
> understand
> it, you can change things like resolution, TV standard, video connector
> and a few other things. The doc here says it all:
> http://www2.lm-sensors.nu/~lm78/cvs/browse.cgi/lm_sensors2/doc/chips/ 
> bt869
>

Yes, it provides simple access to the chip's registers to turn video  
out 'on' and to tell it the format of data fed to it.

In a nutshell, you set up the video card by getting X going in a  
video-compatible mode-line, and then you tell the BT869 the format  
(e.g. resolution, broadcast standard, etc.).

The chip is pretty simple.  It's a modulator and outputs video blanking  
at the right moments.  It relies on the video card chipset to feed it a  
constant stream of data at a compatible resolution and timing for  
analog broadcast video.

>
> I also wonder if the BT869 chip was ever seen on non-banshee/voodoo
> boards.
>

Yes, I think it's used on GeForce(2/3/4) and TNT(2) cards.  Here's a  
list I found.  I'm not sure how current it is:

http://tvtool.cust.nearlyfreespeech.net/cardbase_t.htm

That said, I don't know how many folks are using this driver vs.  
something else like nvtv.


Phil
