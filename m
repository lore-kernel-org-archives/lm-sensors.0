From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: [PATCH 2.6.12-rc4 1/3] dynamic sysfs callbacks
Message-Id: <253818670505101759f4db08d@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <253818670505070621784dbd63@mail.gmail.com>
	 <20050510221615.GA4613@kroah.com>
	 <2538186705051017132b6d1909@mail.gmail.com>
In-Reply-To: <2538186705051017132b6d1909@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, Jean Delvare <khali@linux-fr.org>, LM Sensors <sensors@stimpy.netroedge.com>, linux-kernel@vger.kernel.org

On further reflection, how about I work off this patch for now and for
each of the derived attributes submit a separate patch implementing
the callbacks, etc for that attribute along with an example patch
showing how it can be used to benefit some existing code (these
already exist for device and class attributes, so I'll resubmit those
examples).

This way we can be sure that we aren't changing any of the derived
attributes needlessly, and it presents a better view of exactly what
changes I'm making to others I suppose :-).

We should probably document this change somehow in the sysfs
documentation at some point too.

Thanks,
Yani
