From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Thu, 10 Apr 2008 23:34:41 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] libsensors: Detect OpenFirmware hwmon
Message-Id: <20080410233441.GZ7191@tree.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080331234931.GE7191@tree.beaverton.ibm.com>
In-Reply-To: <20080331234931.GE7191@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Apr 02, 2008 at 02:03:29PM +0200, Jean Delvare wrote:

> We can of course apply this but I am wondering if this is needed in the
> long run... I seem to recall a discussion about of_platform being soon
> deprecated and Open Firmware-based devices would just use platform. Ah,
> here it is:
> 
> http://lists.lm-sensors.org/pipermail/i2c/2007-December/002548.html

I think it would be useful to pick up of_platform devices even if
they get reclassified as regular platform devices because a new
libsensors may some day encounter an old kernel.

I, err, committed it to test commit priviledges.  Oops.  I will
pull it out if there exist really strong objections to this code.

(2.6.25-rc8 still has of_platform in it...)

--D

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
