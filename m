From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 26 Jan 2009 16:58:37 +0000
Subject: Re: [lm-sensors] Branches in lm-sensors repository
Message-Id: <20090126175837.43654a8b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090119222636.0380a479@hyperion.delvare>
In-Reply-To: <20090119222636.0380a479@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Axel,

On Mon, 26 Jan 2009 16:51:19 +0100, Jean Delvare wrote:
> This is done now. As I hopped, this was a simple matter of two "svn
> move" commands. Kudos to the Subversion developers for making it so
> easy.

Oh, BTW, I expect this change to break nightly SVN snapshots.

I suppose that we no longer really care about snapshots of the legacy
(lm-sensors 2.10) branch.

The snapshot command for trunk was operating on the legacy code before
and is now operating on the development tree. Alright, that's exactly
what we want.

The snapshot command for the lm-sensors-3.0.0 branch will fail. So all
you have to do is remove this part from the snapshot script.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
