From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: 2.8.1
Message-Id: <20031114011110.GI16352@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F6484BA.24E78516@paradyne.com>
In-Reply-To: <3F6484BA.24E78516@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Nov 04, 2003 at 08:31:27PM +0100, Jean Delvare wrote:
> 
> > Is it split up into small, incremental patches, each patch only doing
> > one thing?  That is what is going to be required if it will be
> > accepted into the kernel tree.
> 
> Basically, it's all or nothing.

Hm, with that attitude, your patch will go nowhere, sorry.

Again, you are going to _have_ to build up a series of patches, each
only doing one thing, in order to try to get these changes into the
kernel.  The fact that you are going to be changing an existing api, and
breaking working drivers, in a stable kernel series so late in the
development process, is going to be a big problem in getting your
patches accepted.  You better do them in the least obtrusive manner
possible.

Good luck,

greg k-h
