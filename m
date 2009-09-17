From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 17 Sep 2009 14:07:38 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon w83627hf: add mfd support.
Message-Id: <20090917160738.23c830b8@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1252585810-5336-2-git-send-email-giometti@linux.it>
In-Reply-To: <1252585810-5336-2-git-send-email-giometti@linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 17 Sep 2009 16:03:03 +0200, Rodolfo Giometti wrote:
> On Thu, Sep 17, 2009 at 03:57:55PM +0200, Jean Delvare wrote:
> > On Thu, 17 Sep 2009 15:51:20 +0200, Rodolfo Giometti wrote:
> > > I prefer propose a patch with real changes only, is that correct even
> > > if checkpatch.pl says no? :)
> > 
> > If you run checkpath.pl on the patch and not the source files, it won't
> > complain about the parts you're not touching.
> 
> I agree, but I'm going to create a new file by splitting an old one
> and during such split I can just copy code from the old file which may
> have a wrong style... should this code be fixed?

Yes, that one can be fixed on the fly. It won't make the patch any
larger.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
