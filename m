From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 13 May 2009 09:12:48 +0000
Subject: Re: [lm-sensors] [PATCH v2 5/7] sensord: Refactoring of loadConfig()
Message-Id: <20090513111248.37e7235c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090511160411.GF17530@ubuntu>
In-Reply-To: <20090511160411.GF17530@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 13 May 2009 11:07:20 +0200, Andre Prendel wrote:
> On Wed, May 13, 2009 at 10:21:47AM +0200, Jean Delvare wrote:
> > I mean:
> > 
> > <minus><tab><tab><tab>sensors_cleanup();
> > <plus><space><space><tab><tab><tab>sensors_cleanup();
> > 
> > The two spaces shouldn't be there. As a matter of fact, the effective
> > content of this line doesn't change, so it shouldn't show up in the
> > diff... unless there are invisible whitespace changes.
> 
> Ah, now I got it, thanks. I didn't see the two spaces (have trusted the
> Emacs indentation). I'll fix that before committing.
> 
> BTW, how do you review patches? In your mailclient or in external
> tool? Sometimes diffs are very difficult to read.

Depends on how complex the patch is. For simple patches, in my mail
client. For more complex patches, I save them, and test them using
quilt. "quilt diff" adds color to the patches, this makes them easier
to read. If the patch changes a lot of code, I often open the complete
source file to double-check the new code looks good, and also build the
code and look for warnings.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
