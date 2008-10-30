From: Matthew Garrett <mjg59@srcf.ucam.org>
Date: Thu, 30 Oct 2008 00:03:15 +0000
Subject: Re: [lm-sensors] Using hwmon in-kernel
Message-Id: <20081030000315.GA6410@srcf.ucam.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081008003041.GA20169@srcf.ucam.org>
In-Reply-To: <20081008003041.GA20169@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Oct 29, 2008 at 04:33:19PM -0700, Trent Piepho wrote:
> On Wed, 22 Oct 2008, Matthew Garrett wrote:
> > Mnf. I'm not convinced general kernel upstream would be enthusiastic.
> 
> Any reason for that?

Because any interface that basically enforces integer->string->integer 
conversion is an indication that you're already doing it wrong.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
