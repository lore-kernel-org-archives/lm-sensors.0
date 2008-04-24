From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Thu, 24 Apr 2008 22:16:46 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] ibmaem: New driver for power/energy
Message-Id: <20080424221645.GA16404@tree.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080328213805.GB7183@tree.beaverton.ibm.com> <47F1A675.3050204@codemonkey.ws>
In-Reply-To: <47F1A675.3050204@codemonkey.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

On Mon, Mar 31, 2008 at 10:05:25PM -0500, Anthony Liguori wrote:

> It really shouldn't be necessary to have all of these macro functions.  
> In this above macro, you would just have to pass the ro and rw  
> structures along with a remove function pointer.  Since all of your  
> types have common members, you could just have a common substructure and  
> pass that around.

Hmm... it isn't too difficult to refactor the registration function to
make it easier to look at, though I'd rather keep the AEM1 and AEM2 guts
separate rather than aggressively eliminating macros by making the AEM1
structs a subset of the AEM2 structs.

--D

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
