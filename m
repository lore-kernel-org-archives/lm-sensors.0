From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: RFC: complete rewrite of i2c-i801 for 2.6.x
Message-Id: <20041201052129.GA7903@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041128193640.GB5855@jupiter.solarsys.private>
In-Reply-To: <20041128193640.GB5855@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello MDS, again:

> * Mark D. Studebaker <mds4@verizon.net> [2004-11-29 20:09:35 -0500]:
> > And I wouldn't give up on SMBus 2.0 yet. The W83791D sensor chip supports 
> > it;
> > if the W83792D does as well (awaiting datasheet from Winbond), we can 
> > enable it
> > in the forthcoming driver from Winbond and have end-to-end hardware error 
> > checking for
> > i2c transactions on a system with a 792 and a 801, should such a system 
> > appear.

* Mark M. Hoffman <mhoffman@lightlink.com> [2004-11-29 23:09:44 -0500]:
> I might own one myself.  I just noticed that CVS sensors-detect finds a
> 792 now.  I think it's unlikely, as I *know* this board has a 627thf (I've
> been using it for a while and have physically located it on the board).
> I'll have to open it up again and search for the 792.
> 
> So, assuming I really have one of these, and that it (792) does PEC...
> that will make for easy testing. :)  Speaking of which: I ran my tests
> on an ICH5, let me know if you get it to work on one of the other
> supported chipsets, especially the older ones <= ich3.

Apparently sensors-detect is wrong about 792d.  What I really have is
a w83791sd (determined by inspection).

BTW, there's really no point to implementing I2C_FUNC_SMBUS_BLOCK_DATA in
the new i801 driver as i2c_smbus_[read|write]_block_data() were yanked
out of i2c-core anyway.  And that reminds me: you probably shouldn't speak
too loudly about any other parts (shhhh... PEC, SMBus 2.0) that have no
current users, as the bloat police might show up and rip them out too. ;)

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
