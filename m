From: icampbell@arcom.com (Ian Campbell)
Date: Thu, 19 May 2005 06:25:11 +0000
Subject: algorithm and bus driver for PCA9564
Message-Id: <1092297873.10253.3.camel@icampbell-debian>
List-Id: <lm-sensors.vger.kernel.org>
References: <1091438873.11210.55.camel@icampbell-debian>
In-Reply-To: <1091438873.11210.55.camel@icampbell-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2004-08-11 at 19:24, Jean Delvare wrote:
> > On Tue, 2004-08-10 at 19:38, Jean Delvare wrote:
> > > We gladly accept patches as long as code is tested and at least one
> > > person is using it on a regular basis.
> > 
> > As it happens I did the actual development on 2.6 but the customer
> > wanted 2.4 so this is the version we are actually using in anger -- so
> > here is the 2.4 patch inline. 
> 
> Hm, I guess I wasn't clear enough. By "we" I mean "the lm_sensors
> group", and as such what we accept are patches against either the i2c
> package or the lm_sensors2 package, *not* the 2.4 kernel tree. 

Ah. I didn't realise that, thanks for explaining.

>                                                                Patches
> for the 2.4 kernel tree should be directed to the LKML and Marcello
> Tosatti. Know that Marcello seems to be rather reluctant to add anything
> to the i2c subsystem in 2.4. You may still take your chance though.
> 
> Since our i2c subsystem and the one in 2.4 are not compatible, it
> probably doesn't make sense sending us anything since you won't be able
> to use it. So if you can't convince Marcello to accept your patch, you
> probably will have to maintain it as an external patch.

That's what I'll probably do, I already have lots of patches to support
my (ARM) platform that don't have a hope in hell of being merged for 2.4
so one more doesn't hurt too much.

Ian.
-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road, 			Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom	Phone:  +44 (0)1223 411 200


______________________________________________________________________
This email has been scanned by the MessageLabs Email Security System.
For more information please visit http://www.messagelabs.com/email 
______________________________________________________________________
