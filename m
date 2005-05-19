From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:30 +0000
Subject: PATCH (take 3) for adm1026.c, kernel 2.6.10-bk14
Message-Id: <20050112185513.GB10687@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <41D5D075.4000200@paradyne.com> <20050101001205.6b2a44d3.khali@linux-fr.org> <20050103194355.GA11979@penguincomputing.com> <20050103201056.3c55e330.khali@linux-fr.org> <20050103213707.GA12765@penguincomputing.com> <20050103205231.GK9923@schnapps.adilger.int> <20050103221249.GB12765@penguincomputing.com> <20050112185055.GB16724@penguincomputing.com>
In-Reply-To: <20050112185055.GB16724@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Justin Thiessen <jthiessen@penguincomputing.com>
Cc: LM Sensors <sensors@Stimpy.netroedge.com>, LKML <linux-kernel@vger.kernel.org>, khali@linux-fr.org

On Wed, Jan 12, 2005 at 10:50:55AM -0800, Justin Thiessen wrote:
> Ok, take 3 on the adm1026 patch.
> 
> In this patch:
> 
> (1) Code has been added which ensures that the fan divisor registers are 
>     properly read into the data structure before fan minimum speeds are 
>     determined.  This prevents a possible divide by zero error.  The line 
>     which reads the hardware default fan divisor values has been reformatted 
>     as suggested by Andreas Dilger to make the intent of the statement clearer.
> 
> (2) In a similar spirit, an unecessary carriage return from a "dev_dbg" 
>     statement in the adm1026_print_gpio() function has been elminated,
>     shortening the statement to a single line and making the code easier
>     to read.
> 
> Signed-off-by: Justin Thiessen <jthiessen@penguincomputing.com

Applied, thanks.

greg k-h
