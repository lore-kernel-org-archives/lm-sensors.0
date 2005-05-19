From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:50 +0000
Subject: Fwd: Testing LM85 driver
Message-Id: <3E76759C.6050708@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E6A6826.2060802@paradyne.com>
In-Reply-To: <3E6A6826.2060802@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I see you made it onto the mailing list. Welcome.

Hadn't seen that 2.5.65 was out.
I was just looking at the diffs between CVS and 2.5.64.
It isn't huge but it's growing.

As I'm not running a 2.5 kernel and am not following LKML, I don't have
any visibility into which of the changes actually are tested/work.
With Cristoph making all those changes it would have been a lot
of work to keep up with the backporting to CVS.
If he's done and things start coming through us again,
then it makes sense to sync up with 2.5.65.


Greg KH wrote:
> On Mon, Mar 17, 2003 at 08:01:41PM -0500, Mark D. Studebaker  wrote:
> 
>>While I was happy to do the changes, it would be helpful
>>if you wish to test my changes, or
>>for any subsequent development, if you used CVS as a base.
> 
> 
> On a side note, is anyone going to check the i2c changes into cvs that
> are now in the 2.5.65 kernel release?  The changes in that kernel
> actually enable the i2c code to run without oopsing :)
> 
> thanks,
> 
> greg k-h
