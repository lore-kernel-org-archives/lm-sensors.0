From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:18 +0000
Subject: 2.6 lm85 driver update?
Message-Id: <20041004174558.GA21924@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Oct 04, 2004 at 09:59:02AM -0700, Justin Thiessen wrote:
> Hi,
> 
> I recently submitted a patch to the lm_sensors mailing list that implements
> basic fan control for the lm85 and compatibles with the 2.6.X kernel, along
> with the associated patches in chips.c and chips.h for libsensors.
> 
> http://archives.andrew.net.au/lm-sensors/msg18866.html
> http://archives.andrew.net.au/lm-sensors/msg18867.html
> http://archives.andrew.net.au/lm-sensors/msg18868.html
> 
> Is there any reason that these patches could not go into the tree?

Not that I can see.

> If there are any changes that need to be made I will be _happy_ to
> implement them, but I need feedback before I can do so.
> 
> It would be really helpful to get these patches officially accepted.

Just follow the steps outlined in the Documentation/SubmittingPatches
file in the kernel for how to properly create the patch (hint, so I can
apply it with -p1 when sitting inside the main kernel directory), and
adding a "Signed-off-by:" line.

Also be sure to CC: me and the sensors mailing list for anyone to point
out any problems that might be in them.

thanks,

greg k-h
