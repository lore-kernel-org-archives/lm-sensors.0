From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Mon, 16 Nov 2009 17:51:42 +0000
Subject: Re: [lm-sensors] ADT7473 and ADT7475
Message-Id: <20091116175142.GH21723@tux1.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091107154621.55b98183@hyperion.delvare>
In-Reply-To: <20091107154621.55b98183@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Nov 13, 2009 at 08:43:47PM +0100, Jean Delvare wrote:
> No, CONFIG_SENSORS_ADT7473 will simply be dropped.
> 
> What could be done is have CONFIG_SENSORS_ADT7473 select
> CONFIG_SENSORS_ADT7475 _during_ the transition phase, if you think this
> can be useful. I am a little reluctant to have Kconfig dependencies
> with no technical justifications, but in this case I can't think of any
> problem that could cause, so why not.

"The adt747[35] drivers were refactored into one driver" seems like a good
enough technical justification to me.

Then again since the drivers don't autoprobe and most everyone will have a
'modprobe adt7473' in some init script anyway, I suppose it won't really help.
So, it's probably not worth the extra effort.

--D

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
