From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Fri, 20 May 2005 10:53:42 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc4 15/15]
Message-Id: <25381867050520015339f02e9b@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050519213551.GA806@kroah.com>
	 <v0eBIb5C.1116575188.8501740.khali@localhost>
In-Reply-To: <v0eBIb5C.1116575188.8501740.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: greg@kroah.com, LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

On 5/20/05, Jean Delvare <khali@linux-fr.org> wrote:
> 
> Hi Greg,
> disabled. While this feature was almost not used so far, I think we
> should have the driver not create interface files for disabled inputs.
> In the case of temperature channels which can be dynamically enabled and
> disabled. it would even make sense to dynamically create and delete
> related sysfs files. Doing so would allow for memory savings and would
> also be less error-prone for the user (presenting an interface for
> disabled features is quite confusing IMHO).

If you think more than a few hwmon/chip drivers will benefit from
dynamically creating the attributes, then maybe we can create some
standard method for doing so, bmcsensors of course needs to
dynamically allocate things, so I'd be using them too.

An earlier idea was to create a standard sysfs function(s) for
dynamically creating device_attributes (and others), but now we will
have custom structures with an embedded device_attribute, it looks to
me like each attribute type would require it's own function.

Yani
