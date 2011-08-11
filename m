From: Matthew Garrett <mjg59@srcf.ucam.org>
Date: Thu, 11 Aug 2011 19:33:26 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon: Convert applesmc driver to pnp
Message-Id: <20110811193326.GA30658@srcf.ucam.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1312906483-3046-1-git-send-email-mjg@redhat.com>
In-Reply-To: <1312906483-3046-1-git-send-email-mjg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Aug 11, 2011 at 09:29:49PM +0200, Henrik Rydberg wrote:
> Hi Matthew,
> 
> > The applesmc driver is current a platform device with DMI matching. All
> > machines with the appropriate hardware actually expose it via an acpipnp
> > device, so it makes sense to use that rather than hardcoding model names
> > and addresses.
> 
> Sounds good, but has the approach been tested on a representative set
> of machines?

I've tested it on a Macbook Pro 1,1 and a Macbook Air 3,1 so there's a 
fairly wide range.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
